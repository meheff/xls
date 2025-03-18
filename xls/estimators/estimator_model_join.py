#
# Copyright 2023 The XLS Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

r"""Estimator model utility.

Joins an "op_models" textproto and a "data_points" textproto
into a single "estimator_model" textproto.  Checks are performed
that ops with regression estimators (and only those ops)
have data points.

Usage:
  estimator_model_join --op_models=/path/to/op_models.textproto \
      --data_points=/path/to/data_points.textproto \
      --output=/path/to/estimator_model.textproto
"""

import collections
import enum
from typing import MutableMapping, Sequence

from absl import app
from absl import flags

from google.protobuf import text_format
from xls.common import gfile
from xls.estimators import estimator_model
from xls.estimators import estimator_model_pb2
from xls.estimators import estimator_model_utils


@enum.unique
class UpdateMode(enum.Enum):
  """Options for delay model update semantics."""

  # Replace the whole delay model.
  NONE = 'none'
  # Replace the whole set of points for all ops having any updated/added point.
  UPDATE_WHOLE_OPS = 'update_whole_ops'
  # Update/add data points, and keep all existing points having no updated
  # counterparts.
  UPDATE_POINTS = 'update_points'


_OP_MODELS = flags.DEFINE_string(
    'op_models',
    None,
    'The file path/name location of the input op_models textproto.',
)
flags.mark_flag_as_required('op_models')

_DATA_POINTS = flags.DEFINE_string(
    'data_points',
    None,
    'The file path/name location of the input data_points textproto.',
)
flags.mark_flag_as_required('data_points')

_METRIC = flags.DEFINE_enum_class(
    'metric',
    None,
    estimator_model.Metric,
    'The metric estimated by this estimator model.',
    required=True,
)

_OUTPUT = flags.DEFINE_string(
    'output',
    None,
    'The file path/name to write the output estimator_model textproto.',
)

_UPDATE_MODE = flags.DEFINE_enum_class(
    'update_mode',
    UpdateMode.NONE,
    UpdateMode,
    'Whether and how to apply update semantics, where `data_points` may contain'
    ' only some new points to incorporate into an existing model. Can be'
    ' `none`, `update_whole_ops`, or `update_points`. `update_whole_ops`'
    ' discards any existing points for ops represented in data_points, while'
    ' `update_points` only discards existing points that have exact'
    ' counterparts.',
)

# A set containing the name of the fields in estimator_model.estimator.Estimator
# proto such that the fields contain regression models.
_REGRESSION_TYPES = frozenset({'regression', 'area_regression'})


def sync_check(
    oms: estimator_model_pb2.OpModels,
    dps: estimator_model_pb2.DataPoints,
    update_mode: UpdateMode,
) -> None:
  """Compares the op types in the source protos to make sure they're in sync.

  Every op that has a regression estimator should have data point(s).
  Any op that doesn't have a regresssion estimator should not have
  any data points.

  Args:
    oms: estimator_model_pb2.OpModels     OpModels proto
    dps: estimator_model_pb2.DataPoints   DataPoints proto
    update_mode: UpdateMode           The update semantics to apply
  """
  regression_ops = {
      x.op
      for x in oms.op_models
      if x.estimator.WhichOneof('estimator') in _REGRESSION_TYPES
  }
  data_point_ops = set([x.operation.op for x in dps.data_points])

  errors = []
  for op in regression_ops:
    if op not in data_point_ops and update_mode == UpdateMode.NONE:
      errors.append(f'# {op} has a regression estimator but no data points.')
  for op in data_point_ops:
    if op not in regression_ops:
      errors.append(
          f"# {op} has data points but doesn't have a regression estimator."
      )
  if errors:
    raise app.UsageError('Issues found:\n' + '\n'.join(errors))


def create_op_to_points_mapping(
    dps: Sequence[estimator_model_pb2.DataPoint],
) -> MutableMapping[str, Sequence[estimator_model_pb2.DataPoint]]:
  """Returns a dict of sublists of the given data points, separated by op."""
  result = collections.defaultdict(list)
  for point in dps:
    result[point.operation.op].append(point)
  return result


def update_op_data_points(
    existing_dps: Sequence[estimator_model_pb2.DataPoint],
    new_dps: Sequence[estimator_model_pb2.DataPoint],
) -> Sequence[estimator_model_pb2.DataPoint]:
  """Returns a combined sequence of existing_dps + new_dps that are for one op.

  The new_dps data is preferred where a sample spec is represented in both.

  Args:
    existing_dps: The existing data points.
    new_dps: The updated and/or additional data points.
  """
  existing_order = [
      estimator_model_utils.get_data_point_key(point) for point in existing_dps
  ]
  existing_points = estimator_model_utils.map_data_points_by_key(existing_dps)
  new_points = estimator_model_utils.map_data_points_by_key(new_dps)
  return [
      new_points[key] if key in new_points else existing_points[key]
      for key in existing_order
  ] + [
      point
      for point in new_dps
      if estimator_model_utils.get_data_point_key(point) not in existing_points
  ]


def update_data_points(
    output_file: str,
    new_dps: estimator_model_pb2.DataPoints,
    update_mode: UpdateMode,
) -> estimator_model_pb2.DataPoints:
  """Creates a proto of the data points in output_file updated with new_dps."""
  result_dps = estimator_model_pb2.DataPoints()
  new_points_by_op = create_op_to_points_mapping(new_dps.data_points)
  ops_with_finished_updates = set()
  with gfile.open(output_file, 'r') as f:
    existing_em = text_format.ParseLines(
        f, estimator_model_pb2.EstimatorModel()
    )
  old_points_by_op = create_op_to_points_mapping(existing_em.data_points)
  for point in existing_em.data_points:
    op = point.operation.op
    if op in new_points_by_op:
      result_dps.data_points.extend(
          update_op_data_points(old_points_by_op[op], new_points_by_op[op])
          if update_mode == UpdateMode.UPDATE_POINTS
          else new_points_by_op[op]
      )
      del new_points_by_op[op]
      ops_with_finished_updates.add(op)
    elif op not in ops_with_finished_updates:
      result_dps.data_points.append(point)
  for op in new_points_by_op:
    result_dps.data_points.extend(new_points_by_op[op])

  return result_dps


def main(argv):
  if len(argv) > 1:
    raise app.UsageError('Too many command-line arguments.')

  oms = estimator_model_pb2.OpModels()
  with gfile.open(_OP_MODELS.value, 'r') as f:
    oms = text_format.Parse(f.read(), oms)

  dps = estimator_model_pb2.DataPoints()
  with gfile.open(_DATA_POINTS.value, 'r') as f:
    dps = text_format.Parse(f.read(), dps)

  em = estimator_model_pb2.EstimatorModel()

  for om in oms.op_models:
    em.op_models.append(om)

  if _UPDATE_MODE.value != UpdateMode.NONE:
    em.data_points.extend(
        update_data_points(_OUTPUT.value, dps, _UPDATE_MODE.value).data_points
    )
  else:
    for dp in dps.data_points:
      em.data_points.append(dp)

  em.metric = estimator_model.Metric.to_metric_proto(_METRIC.value)

  print('# proto-file: xls/estimators/estimator_model.proto')
  print('# proto-message: xls.estimator_model.EstimatorModel')
  print(em, end='')

  if _OUTPUT.value:
    with gfile.open(_OUTPUT.value, 'w') as f:
      f.write('# proto-file: xls/estimators/estimator_model.proto\n')
      f.write('# proto-message: xls.estimator_model.EstimatorModel\n')
      f.write(text_format.MessageToString(em))

  sync_check(oms, dps, _UPDATE_MODE.value)


if __name__ == '__main__':
  app.run(main)
