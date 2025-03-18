// Copyright 2022 The XLS Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// BEGIN_CONFIG
// exception: "// Command \'[\'/xls/tools/eval_ir_main\', \'--input_file=args.txt\', \'--use_llvm_jit\', \'sample.ir\', \'--logtostderr\']\' returned non-zero exit status 1."
// issue: "https://github.com/google/xls/issues/746"
// sample_options {
//   input_is_dslx: true
//   sample_type: SAMPLE_TYPE_FUNCTION
//   ir_converter_args: "--top=main"
//   convert_to_ir: true
//   optimize_ir: true
//   use_jit: true
//   codegen: false
//   simulate: false
//   use_system_verilog: false
//   timeout_seconds: 600
//   calls_per_sample: 128
// }
// inputs {
//   function_args {
//     args: "bits[53]:0xa_1e04_2b76_1c86; (bits[53]:0x800_0000, bits[39]:0x6_3532_56a6, bits[44]:0x208_2883_20d7, bits[63]:0x6149_6906_42bf_73be); bits[21]:0x0; bits[6]:0x0; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0xe_a081_b057_3bd3; (bits[53]:0x6_a2e5_b453_3d41, bits[39]:0x62_f117_9bfe, bits[44]:0xa1_b05d_bf43, bits[63]:0x5555_5555_5555_5555); bits[21]:0x5_bbbb; bits[6]:0x0; bits[125]:0x0; bits[68]:0x4000_0000_0000"
//     args: "bits[53]:0x0; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x2200_9280, bits[63]:0x400); bits[21]:0x0; bits[6]:0x2a; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x0"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x11_dfd0_9d59_47d5, bits[39]:0x7f_ffff_ffff, bits[44]:0x554_b1d8_51b0, bits[63]:0x5555_5555_5555_5555); bits[21]:0x15_5555; bits[6]:0x1f; bits[125]:0x0; bits[68]:0x7_df7f_fb7f_ffcd_fdff"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x0, bits[44]:0xff7_ffea_ffdf, bits[63]:0x75af_cfff_ffbe_bc08); bits[21]:0x4_7686; bits[6]:0x20; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x14_7c75_cba7_8dfc, bits[39]:0x7d_ffff_ff7b, bits[44]:0xfeb_effa_b6fb, bits[63]:0x3e10_cff7_e84d_3c00); bits[21]:0x1f_ffff; bits[6]:0x3f; bits[125]:0xe0e_6b57_c4e9_2c86_baa9_e736_abf0_0545; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x0; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x1022_0218, bits[44]:0x100_0404_0000, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x15_5555; bits[6]:0x3f; bits[125]:0x8000_0000_0000; bits[68]:0x1_0000"
//     args: "bits[53]:0x0; (bits[53]:0x4000_0000_0000, bits[39]:0x0, bits[44]:0xaaa_aaaa_aaaa, bits[63]:0x510a_c85c_0082_42da); bits[21]:0x6_dedb; bits[6]:0x20; bits[125]:0x1000_8107_80ba_aaea_aaaa_a88a_eaaa; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x0, bits[39]:0x3f_ffff_ffff, bits[44]:0x7ff_e79e_ae0a, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x1f_febf; bits[6]:0x32; bits[125]:0x1822_a8ea_a2ae_aaaa_aaaa_aae2_8ebe_baaa; bits[68]:0xc_a000_0000_0080_0000"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x9_fe7f_7fff_fffd, bits[39]:0x800, bits[44]:0x555_5555_5555, bits[63]:0x3bfb_ffef_dff3_fcbf); bits[21]:0x1f_fdff; bits[6]:0x2a; bits[125]:0x400_0000_0000_0000_0000_0000_0000; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xa_eeea_baaa_a288, bits[39]:0x2a_8aea_aa8a, bits[44]:0xfff_ffff_ffff, bits[63]:0x4a6_e1f7_e8fd_5e04); bits[21]:0x1f_ffff; bits[6]:0x0; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x2aba_a2aa_a8ae_bb8e"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x200_0000, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x4ae_2da1_81b8, bits[63]:0x3faf_f7ff_ffff_fc28); bits[21]:0x15_5555; bits[6]:0x3f; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x3_cd7d_58a0_217f_057b"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xf_ffdf_7fcf_f9e7, bits[39]:0x2a_aaaa_aaaa, bits[44]:0xaaa_aaaa_aaaa, bits[63]:0x5fc6_f2ec_fd3f_c49a); bits[21]:0x4_0000; bits[6]:0x0; bits[125]:0x3ff_effd_ffdb_cfe2_28a8_a2a2_ebae_2aaa; bits[68]:0xf_a10d_1fdc_0433_a79e"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xe_ebaa_baaa_aaa8, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x555_5555_5555, bits[63]:0x0); bits[21]:0x100; bits[6]:0x0; bits[125]:0x17_6e9c_577f_54e1_a859_926e_7d0c_2145; bits[68]:0x0"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x15_5555_5555_5555, bits[39]:0x2a_aaaa_aaaa, bits[44]:0xfff_ffff_ffff, bits[63]:0x7fd7_effb_ffef_7fff); bits[21]:0xd_9dfb; bits[6]:0x3f; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x0, bits[44]:0x7ff_ffff_ffff, bits[63]:0x3de3_2856_b05c_75da); bits[21]:0x19_f3d9; bits[6]:0x3d; bits[125]:0x11ed_c38f_9eda_baee_3a7d_ed65_63ff_acbf; bits[68]:0x0"
//     args: "bits[53]:0x1c_2949_7dac_cd88; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x79_f929_c5ce, bits[44]:0xfff_ffff_ffff, bits[63]:0x5555_5555_5555_5555); bits[21]:0x0; bits[6]:0x0; bits[125]:0x6e_f0c5_2384_3a0c_bdee_a07c_e735_155c; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x0, bits[39]:0x6d_5c10_5115, bits[44]:0x505_5547_4740, bits[63]:0x5555_5555_5555_5555); bits[21]:0x400; bits[6]:0x1f; bits[125]:0x0; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x15_3f3f_5ee9_b7ba, bits[39]:0x69_5fdf_eff6, bits[44]:0x5fb_fe5d_f96c, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x0; bits[6]:0x3f; bits[125]:0xfbf_ebbb_374a_bcac_7984_3a9b_c880_8a97; bits[68]:0xb_31f9_9ba9_fe7b_4c09"
//     args: "bits[53]:0x16_ed81_368d_040f; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x79_3f8d_7a8e, bits[44]:0xd91_228d_042f, bits[63]:0x5bb6_0cca_3412_3ad8); bits[21]:0x1000; bits[6]:0x3f; bits[125]:0x800_0000_0000_0000_0000; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x80_0000; (bits[53]:0x4e34_9b86_196a, bits[39]:0x55_5555_5555, bits[44]:0xfff_ffff_ffff, bits[63]:0x851_3de2_cebc_5395); bits[21]:0xf_ffff; bits[6]:0x3d; bits[125]:0x80_0000_0000; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0x4_0000_0000_0000; (bits[53]:0xf_abdd_0f42_1ee0, bits[39]:0x820_0002, bits[44]:0xfff_ffff_ffff, bits[63]:0x1000_1800_0000_06aa); bits[21]:0x0; bits[6]:0x1; bits[125]:0x65_c953_bafc_f3dd_8ff7_fcfb_0a1b_66fb; bits[68]:0x1_8ed9_e81b_92f6_5f56"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x1f_e7ef_f4f1, bits[44]:0x555_5555_5555, bits[63]:0x3fd3_a47f_bdc7_7d7d); bits[21]:0x15_5555; bits[6]:0x15; bits[125]:0x147f_3af3_ed7e_c1ba_fbc4_abc7_397f_d9fe; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x1f_9bd3_95f7_1ad3, bits[39]:0x7f_ffff_ffff, bits[44]:0xbff_fffd_fbbb, bits[63]:0x0); bits[21]:0x4; bits[6]:0x1f; bits[125]:0x0; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x10_0000_0000_0000; (bits[53]:0x1c_0030_9258_44c4, bits[39]:0x5_5200_0a88, bits[44]:0x200, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0x441; bits[6]:0x0; bits[125]:0x400_4155_5557_555d_5574_4135_1457_5505; bits[68]:0x1900_0002_4020_0614"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x0, bits[44]:0xff7_e7e3_ff7b, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0xf_ffff; bits[6]:0x15; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x0"
//     args: "bits[53]:0xf89e_06a5_5d0f; (bits[53]:0x15_5555_5555_5555, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x555_5555_5555, bits[63]:0x56b2_4d92_c7fe_2e99); bits[21]:0x1f_ffff; bits[6]:0x3e; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0x20; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x14_1030_8005, bits[44]:0x181_0020, bits[63]:0x646_5355_0068_b57d); bits[21]:0x9_5620; bits[6]:0x15; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x40; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x7f_ffff_ffff, bits[44]:0x740_9ac8_4418, bits[63]:0x3908_5436_0099_7251); bits[21]:0x15_5555; bits[6]:0x1; bits[125]:0x0; bits[68]:0x0"
//     args: "bits[53]:0x5_bae6_80d7_43b3; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x80, bits[44]:0xaaa_aaaa_aaaa, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0x4_0021; bits[6]:0x8; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xe_6f5f_7fcc_f3fd, bits[39]:0x7d_b73e_ffea, bits[44]:0x9d1_0bff_cd7e, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0xa_aaaa; bits[6]:0x2a; bits[125]:0x1510_0000_4114_0000_0012_911c_0184_0029; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xf_7fbf_db7b_fcb7, bits[39]:0x55_5555_5555, bits[44]:0x9ed_d7fe_9fbb, bits[63]:0x3eff_dbfd_fa7f_fd77); bits[21]:0x1f_ffff; bits[6]:0x3f; bits[125]:0xfe7_24c7_60ed_6306_0a81_dcf2_f154_cb59; bits[68]:0x8_0000_0000_0000"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x18_7c62_efce_a289, bits[39]:0x0, bits[44]:0xfbf_fffe_7fff, bits[63]:0x200_0000); bits[21]:0x16_d7e5; bits[6]:0x3f; bits[125]:0x1562_0718_09e4_fb7b_2d97_e331_66ec_152f; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x11_fe52_bc2e_eabd, bits[39]:0x7f_ffef_bbff, bits[44]:0x10_0000, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0x1b_7b56; bits[6]:0x1f; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x3_9210_4c63_a1c3_1208"
//     args: "bits[53]:0x0; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x0, bits[44]:0xc08_0050_0210, bits[63]:0xc80_8314_9404_0271); bits[21]:0x15_5555; bits[6]:0x32; bits[125]:0x914_941a_0ab6_02dd_5515_d154_5167_5554; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x20; (bits[53]:0x442_0840_4020, bits[39]:0x28, bits[44]:0x800_0200_a290, bits[63]:0x481e_d591_989c_d249); bits[21]:0x4_0000; bits[6]:0x0; bits[125]:0x68_b9f4_09e6_bce2_5f42_a46a_115c_20cf; bits[68]:0x6_ea6a_697c_b23e_30f8"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x15_5555_5555_5555, bits[39]:0x77_ab5a_bbcc, bits[44]:0xfe3_bffb_9fff, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0xf_7ddb; bits[6]:0x0; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x7_bff3_f9ff_ffd9_d55f"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0xd_33fe_cf9d_2f92, bits[39]:0x7f_ffff_ffff, bits[44]:0xfb9_ddff_2ffd, bits[63]:0x2a72_cced_3ff3_3bfb); bits[21]:0x1f_ffff; bits[6]:0x3b; bits[125]:0x1fff_ffab_a3ae_2a8e_8af0_aafe_2ea0_aae3; bits[68]:0xe_115b_5c2f_415a_855f"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x0, bits[44]:0x5d5_5375_1757, bits[63]:0x0); bits[21]:0x13_e484; bits[6]:0x15; bits[125]:0x13f4_84bb_bb20_9daa_2a8a_2eea_a2ab_ef06; bits[68]:0x8_88a8_e28c_ac2e_94f5"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x15_5707_6550_55d5, bits[39]:0x55_5555_5555, bits[44]:0xaaa_aaaa_aaaa, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0x2_0000; bits[6]:0x18; bits[125]:0x0; bits[68]:0x48_2680_081a_4081"
//     args: "bits[53]:0x0; (bits[53]:0x8_0010_2208_a940, bits[39]:0x4_0800_0800, bits[44]:0xc39_0c77_9f1f, bits[63]:0x0); bits[21]:0x16_0248; bits[6]:0x2a; bits[125]:0xf8c_0f74_145d_515d_9f25_1047_5355_5d9c; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x15_5555_5555_5555, bits[39]:0x7d_ffff_ffff, bits[44]:0x555_5555_5555, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0x0; bits[6]:0x3f; bits[125]:0x172c_36d8_1960_1d17_9137_dd4c_ae0b_b2d1; bits[68]:0xf_6fd7_b577_2ef7_a37f"
//     args: "bits[53]:0x20_0000_0000; (bits[53]:0x4, bits[39]:0x4_0000, bits[44]:0x5cb_4314_b682, bits[63]:0x2620_30d6_6d76_5b16); bits[21]:0xf_ffff; bits[6]:0x8; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x0"
//     args: "bits[53]:0x200; (bits[53]:0x18_0040_c346_8247, bits[39]:0x2_8000_0300, bits[44]:0x408_0009_8818, bits[63]:0x8_0155); bits[21]:0xa_aaaa; bits[6]:0x2a; bits[125]:0x10_0000_0000_0000_0000; bits[68]:0xb_0049_249d_0424_f8c7"
//     args: "bits[53]:0x19_a145_47c4_b853; (bits[53]:0x19_ad95_43d4_a0d2, bits[39]:0x0, bits[44]:0x7ff_ffff_ffff, bits[63]:0x89e_e371_3152_5341); bits[21]:0x15_5555; bits[6]:0x15; bits[125]:0xae0_3af3_a7e9_e697_17b7_fbdf_be9d_7786; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x8_ebeb_a1e3_2e0b, bits[39]:0x22_a0ba_00ce, bits[44]:0x2cb_a3af_2ab8, bits[63]:0x2aaa_ebaa_aa2a_abbf); bits[21]:0x15_5555; bits[6]:0x1; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x0"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xc_b8ce_a3a8_095a, bits[39]:0x2a_aaaa_aa8a, bits[44]:0xaaa_a2aa_aaaa, bits[63]:0x7e0b_f903_d949_9865); bits[21]:0x1e_1d7b; bits[6]:0x3c; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x0"
//     args: "bits[53]:0x0; (bits[53]:0x14_eb7d_35d1_4009, bits[39]:0x55_5555_5555, bits[44]:0x427_8708_0529, bits[63]:0x841_0880_0044_a800); bits[21]:0x0; bits[6]:0xb; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x28_aafa_b2aa, bits[44]:0xfff_ffff_ffff, bits[63]:0x8000_0000); bits[21]:0x1a_0e9e; bits[6]:0xe; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x5_636d_5d57_dadc_767d"
//     args: "bits[53]:0x2000_0000; (bits[53]:0x1180_200c_0009, bits[39]:0x7e_cb98_bdf0, bits[44]:0x7ff_ffff_ffff, bits[63]:0xe5e_b594_d1a1_6bf4); bits[21]:0x15_5555; bits[6]:0x0; bits[125]:0x8000_0000_0000_0000_0000; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0xf_3fe0_05aa_6efb, bits[39]:0x2a_aaaa_aaaa, bits[44]:0xbf7_ffec_eedf, bits[63]:0x1cdd_524c_24ed_ea6d); bits[21]:0x1f_ffff; bits[6]:0x15; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0xe_fefe_fee7_fb77_977b"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x40_0000, bits[39]:0x3f_ffff_ffff, bits[44]:0x451_155d_627f, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x1f_ffff; bits[6]:0x3f; bits[125]:0xd33_f51d_34d8_c5d7_48f4_ee3f_1c85_f2b0; bits[68]:0x100_0000_0000_0000"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x7_7e7d_ebba_ddff, bits[39]:0x55_5555_5555, bits[44]:0xf4c_1073_c46f, bits[63]:0x800_0000_0000); bits[21]:0x11_3f9b; bits[6]:0x27; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x4_4d42_e215_cb91_5e97"
//     args: "bits[53]:0x0; (bits[53]:0xa_8fe0_5f3f_7900, bits[39]:0x1_0140_0080, bits[44]:0x2f4_0c0a_4083, bits[63]:0x711d_ef19_cbe9_4cdc); bits[21]:0x10_4421; bits[6]:0x3f; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x0; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x4_7a44_1004, bits[44]:0x1800_0000, bits[63]:0x20e6_bfa6_2200_03b7); bits[21]:0x1000; bits[6]:0x1; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x409_1889_0880_0045"
//     args: "bits[53]:0x0; (bits[53]:0x8_c090_0500_cc00, bits[39]:0x55_5555_5555, bits[44]:0x34c2_3f4b, bits[63]:0x2032_0204_8000_539a); bits[21]:0x1000; bits[6]:0x1f; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x924_6f0b_2502_ea41"
//     args: "bits[53]:0x2_0000_0000_0000; (bits[53]:0x15_5555_5555_5555, bits[39]:0x21_07ab_6164, bits[44]:0x2, bits[63]:0x5ad2_28c7_6070_0000); bits[21]:0x15_5555; bits[6]:0x0; bits[125]:0x10_0000_0000_0000; bits[68]:0x1_0000_4024_0102_010e"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x73_c715_7732, bits[44]:0x1dd_4df9_d555, bits[63]:0x5155_5975_5c15_7820); bits[21]:0x15_7554; bits[6]:0x0; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x15_5555_5555_5555, bits[39]:0x46_1e2c_28a7, bits[44]:0x400, bits[63]:0x5d41_b47b_d20b_c2df); bits[21]:0x0; bits[6]:0x1; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x2_23a9_b885_5edd_3e50"
//     args: "bits[53]:0x13_14ad_08d1_93f5; (bits[53]:0x13_14ad_08d1_92f7, bits[39]:0x25_beb7_f3f3, bits[44]:0x42d_12d7_d3d5, bits[63]:0x4a50_2689_c74d_75f6); bits[21]:0x0; bits[6]:0x0; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x7_ca74_447c_dbc6_f0cc"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x80_0000, bits[39]:0x77_b67c_75d1, bits[44]:0x6cc_5e9e_d5c6, bits[63]:0x55d5_fd55_95dd_9560); bits[21]:0x1c_5f55; bits[6]:0x0; bits[125]:0x4; bits[68]:0x0"
//     args: "bits[53]:0x800_0000_0000; (bits[53]:0xa002_06c1_4302, bits[39]:0x0, bits[44]:0x809_000a_8100, bits[63]:0x6b0_2815_bba5_08e9); bits[21]:0xa_aaaa; bits[6]:0x1f; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0xa_aaa9_2aa8_aa82_a8aa"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x15_43e1_6558_7f33, bits[39]:0x55_4755_5555, bits[44]:0x0, bits[63]:0x5d55_5d55_5454_d5ff); bits[21]:0xf_ffff; bits[6]:0x3f; bits[125]:0x1816_8ac4_94a8_14ad_a45d_91a1_dd01_c486; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0x8_0000_0000; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x2a_2464_8980, bits[44]:0xfff_ffff_ffff, bits[63]:0x7728_3d04_a3b6_e328); bits[21]:0xf_ffff; bits[6]:0x0; bits[125]:0x25_bc61_444b_0c2e_7bb6_63ad_9f60_020f; bits[68]:0x2a4a_9dc8_e9b4_df71"
//     args: "bits[53]:0x4000_0000; (bits[53]:0x10_1104_4413_b001, bits[39]:0x2e_5f9e_1a3b, bits[44]:0x7ff_ffff_ffff, bits[63]:0x210_0800_3208); bits[21]:0x0; bits[6]:0x15; bits[125]:0xaa4_8b5b_4a51_e113_2996_ae61_a136_7a08; bits[68]:0xd_506f_02dc_7040_15b5"
//     args: "bits[53]:0x0; (bits[53]:0x1b_0366_07a9_a126, bits[39]:0x5f_2a8b_7029, bits[44]:0xfff_ffff_ffff, bits[63]:0x1_0400_02ba); bits[21]:0xd_fc2c; bits[6]:0x0; bits[125]:0x0; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x0; (bits[53]:0x19_6bd4_f8d2_b302, bits[39]:0x40_a240_e208, bits[44]:0x630_9ae5_3083, bits[63]:0x0); bits[21]:0x12_40d4; bits[6]:0x1f; bits[125]:0x1909_09d3_11a5_3c54_486d_1dd5_a5ba_2eb2; bits[68]:0x2_48e5_5981_a3b8_a0a2"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x1f_ffff_fbff_ff77, bits[39]:0x3d_674f_4f4c, bits[44]:0x7ff_bff7_5fe7, bits[63]:0x6ffd_ffbf_ffff_fe80); bits[21]:0x1f_ffff; bits[6]:0x3f; bits[125]:0x1edf_6795_4015_d755_1d5d_6545_d557_57d7; bits[68]:0x0"
//     args: "bits[53]:0x9f4a_2a62_3449; (bits[53]:0x1c_1d03_9ac6_744e, bits[39]:0x55_5555_5555, bits[44]:0xcc4_5e21_9cc1, bits[63]:0x75_08ad_9863_23e2); bits[21]:0x13_1c8d; bits[6]:0x21; bits[125]:0x4_0000_0000_0000_0000; bits[68]:0x2_bb17_1ebe_dc93_2881"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x3f_ffff_ffff, bits[44]:0x400, bits[63]:0x1_0000_0000_0000); bits[21]:0x15_5555; bits[6]:0x1f; bits[125]:0xabb_bae8_a8ba_a87e_fff4_e6df_b3fd_f25d; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x0; (bits[53]:0x7_c14c_4191_2e07, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x402_2a40_1428, bits[63]:0x4_0000_0000_0000); bits[21]:0xa_aaaa; bits[6]:0x3f; bits[125]:0x800_0014_0108_2077_fffe_ffbf_ffff_fdef; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x7_29a2_b4dd_5e94, bits[39]:0x7f_ffff_ffff, bits[44]:0x3f7_8835_d7fa, bits[63]:0x0); bits[21]:0x0; bits[6]:0x31; bits[125]:0x1401_41c0_55ff_7d5d_554d_5c55_5551_1575; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x14_fdde_f9fd_f1ef, bits[39]:0x67_a3ba_dfd3, bits[44]:0x7ff_ffff_ffff, bits[63]:0x7ac6_e3ff_b0a7_7ce1); bits[21]:0xf_ffff; bits[6]:0x10; bits[125]:0x5b8_f454_7693_c287_cd86_8aef_3507_423d; bits[68]:0xf_cd86_8acf_7507_423f"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x8_c04c_b12b_21ae, bits[39]:0x100, bits[44]:0x7ff_ffff_ffff, bits[63]:0x5555_5555_5555_5555); bits[21]:0x14_9059; bits[6]:0x14; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x8_4125_bff7_f47d_fef6"
//     args: "bits[53]:0x4000_0000; (bits[53]:0x0, bits[39]:0x7f_ffff_ffff, bits[44]:0x0, bits[63]:0x140_0100_13ef); bits[21]:0x1f_ffff; bits[6]:0x15; bits[125]:0x304_0629_1beb_0503_f8ee_75ba_76d4_fcec; bits[68]:0x8088_5002_c104_dd15"
//     args: "bits[53]:0x0; (bits[53]:0x0, bits[39]:0x1401_0000, bits[44]:0x90c_4520_4004, bits[63]:0x6e00_0308_04a9_0a55); bits[21]:0x8000; bits[6]:0x21; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0x0; (bits[53]:0x19_508a_3ec0_99b7, bits[39]:0x5a_5c38_fd08, bits[44]:0x960_61e0_4e00, bits[63]:0x802_4000_0000_4000); bits[21]:0x800; bits[6]:0x0; bits[125]:0x157_515d_8357_c585_dd85_175b_5c74_1c75; bits[68]:0x2_0400_0800_0200_0800"
//     args: "bits[53]:0x10_52a5_0485_d79c; (bits[53]:0x40_0000, bits[39]:0x3f_ffff_ffff, bits[44]:0x210_5485_b6f0, bits[63]:0x6548_d426_175e_6081); bits[21]:0x15_5555; bits[6]:0x2a; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0xa_9f77_ef7f_ffdd_edcf"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x8_aab7_bcb6_afa2, bits[39]:0x11_af30_df13, bits[44]:0xaaa_aaaa_aaaa, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0xa_aaaa; bits[6]:0x3f; bits[125]:0x17f7_f486_fdd6_bbfa_1f6d_1e6f_c486_a0fd; bits[68]:0x0"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x3f_ffff_ffff, bits[44]:0x555_5555_5555, bits[63]:0x55d9_1451_d459_47b5); bits[21]:0xa_aaaa; bits[6]:0x2f; bits[125]:0x7d3_5575_7555_7311_5080_d653_4545_4965; bits[68]:0x10"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x17_d533_5584_c5d4, bits[39]:0x5d_5515_1c55, bits[44]:0x711_57b4_5654, bits[63]:0x5555_5555_5555_5555); bits[21]:0x4; bits[6]:0x2; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x48_f7e7_1d37, bits[44]:0xffe_fddf_7ffe, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x80; bits[6]:0x2; bits[125]:0x164_4100_0110_5320_908d_c405_1800_c048; bits[68]:0x6_b0da_b102_21d6_7a6b"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x15_5567_5515_5555, bits[39]:0x100_0000, bits[44]:0x555_5555_5155, bits[63]:0x4555_5455_5553_138f); bits[21]:0x1f_ffff; bits[6]:0x34; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x1_5315_1d79_2579_6e37"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x8000_0000_0000, bits[39]:0x0, bits[44]:0x555_5555_5555, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x12_d39a; bits[6]:0x1a; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x0"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x2a_aeaa_aaa2, bits[44]:0xec2_aae6_ac2b, bits[63]:0x0); bits[21]:0x15_aab1; bits[6]:0x31; bits[125]:0x1cc5_0815_7120_51fc_f145_be55_9d35_5dff; bits[68]:0x2_454f_99db_45fe_2991"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x1a_aaa6_aaab_829f, bits[39]:0x7f_ffff_ffff, bits[44]:0xba2_0a9a_cf2a, bits[63]:0xdee_9ae9_34ab_e612); bits[21]:0xa_aa28; bits[6]:0x2a; bits[125]:0x1_0000_0000_0000_0000_0000; bits[68]:0x4024_2015_404e_4078"
//     args: "bits[53]:0x0; (bits[53]:0x15_5555_5555_5555, bits[39]:0x0, bits[44]:0x80_0180_81e2, bits[63]:0x217_088c_855a_1414); bits[21]:0x1f_ffff; bits[6]:0x3f; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0xb_7ee7_ffff_7ff7_ffaf"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x2_e8a7_baae_9aae, bits[39]:0x39_ab34_9a2b, bits[44]:0x3be_0a8d_eb3d, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0xeaaa; bits[6]:0x0; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x1a2a_a3ea_82ea_89aa"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x1e_dffe_dbbf_ff3b, bits[39]:0x1_0000, bits[44]:0xbff_dfbf_fe7f, bits[63]:0x200_0000_0000_0000); bits[21]:0x1f_ffff; bits[6]:0x37; bits[125]:0x1baa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x6_27ef_ddff_b197_2128"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x6f_e1e5_df3a, bits[44]:0x517_6f3f_6b0f, bits[63]:0x5555_5555_5555_5555); bits[21]:0x15_5555; bits[6]:0x20; bits[125]:0x1d6f_31fd_f7ce_654f_b769_bd47_3aff_eb78; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xf_effb_ffff_dfef, bits[39]:0x400, bits[44]:0x40_0000_0000, bits[63]:0x38d9_c5be_53fc_ad83); bits[21]:0xa_aaaa; bits[6]:0x3f; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x4_2550_bc2a_beb2_fc12"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x7f_ffff_ffff, bits[44]:0xfab_ff7e_7e7f, bits[63]:0x0); bits[21]:0x20; bits[6]:0x0; bits[125]:0x109_bfff_efef_ff7f_bffe_ffff_6fcf_fecd; bits[68]:0x7_ffbf_f7ff_fedf_a1d3"
//     args: "bits[53]:0x8; (bits[53]:0x2_4080_0d01, bits[39]:0x0, bits[44]:0x555_5555_5555, bits[63]:0x2001_3900_8600_21f6); bits[21]:0x0; bits[6]:0x1f; bits[125]:0xd60_5c0a_8424_1010_0043_3680_5090_4560; bits[68]:0x1_912d_7d85_1b1a_44c5"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x15_5555_5555_5555, bits[39]:0x6c_6ab2_a880, bits[44]:0xaaa_8aba_aaaa, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0x1f_ffff; bits[6]:0x1f; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x5_721e_058b_7435_e49d"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x0, bits[39]:0x31_1173_7160, bits[44]:0x1_0000_0000, bits[63]:0x3c0c_9565_95c5_8ea2); bits[21]:0x1b_9054; bits[6]:0x1f; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x1_5327_341e_ce73_912f"
//     args: "bits[53]:0x0; (bits[53]:0x8_8008_0240_0202, bits[39]:0x809, bits[44]:0x640_a18d_099c, bits[63]:0x4000_0201_0000_03aa); bits[21]:0x12_f48f; bits[6]:0x0; bits[125]:0x0; bits[68]:0x5_4e40_1a4b_9217_93c8"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x16_5f7f_5b7f_faff, bits[39]:0x2a_aaaa_aaaa, bits[44]:0xffe_9efe_7f39, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0x1f_ffff; bits[6]:0x2a; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x8_0000_0000; (bits[53]:0x10_4808_0812_8080, bits[39]:0x51_1113_6429, bits[44]:0xfff_ffff_ffff, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0x5_c47a; bits[6]:0x2a; bits[125]:0x5cc_7a80_1002_c010_0200_8000_0400_0000; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xb_ffdf_feff_77ff, bits[39]:0x55_5555_5555, bits[44]:0xfe4_16ef_4131, bits[63]:0x3fff_fff7_ffff_fdff); bits[21]:0x1f_fbdf; bits[6]:0x1f; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0x4000_0000_0000"
//     args: "bits[53]:0x0; (bits[53]:0x2000_0000, bits[39]:0x10_0200_0240, bits[44]:0x0, bits[63]:0x1a83_5d39_e362_12de); bits[21]:0xf_ffff; bits[6]:0x19; bits[125]:0xfff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x0"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x1f_d751_564d_5d55, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x555_5555_5555, bits[63]:0x39dc_5754_b11b_f5a6); bits[21]:0x0; bits[6]:0x1f; bits[125]:0xdb4_200c_808a_4419_200d_0091_4334_8872; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0x80_0000, bits[39]:0x62_0220_274c, bits[44]:0xfff_ffff_ffff, bits[63]:0x5555_5555_5555_5555); bits[21]:0x10; bits[6]:0x1f; bits[125]:0xf82_0800_0c10_4410_0014_0000_9000_0000; bits[68]:0x7_dfff_fbff_ff7f_ff47"
//     args: "bits[53]:0x15_5435_6068_f6ae; (bits[53]:0x15_5555_5555_5555, bits[39]:0x7f_ffff_ffff, bits[44]:0x555_5555_5555, bits[63]:0x0); bits[21]:0xa_aaaa; bits[6]:0x18; bits[125]:0xc13_40d3_0a5a_ea70_5848_18a6_c4f5_1024; bits[68]:0xa_979d_a1f6_d986_32a5"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x15_5555_5555_5555, bits[39]:0x5d_bc7b_b7df, bits[44]:0x19f_7289_5e7a, bits[63]:0x3bff_ffef_f7bf_fc01); bits[21]:0x1f_ffdf; bits[6]:0x9; bits[125]:0x6ec_5b56_feff_b325_fc26_b166_7fee_bfd0; bits[68]:0x1_0000_0000_0000_0000"
//     args: "bits[53]:0x800_0000_0000; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x58_83de_889d, bits[44]:0x931_322e_17d4, bits[63]:0x2630_e78f_94b8_15e7); bits[21]:0xa_aaaa; bits[6]:0x0; bits[125]:0x800_0000_0000_0000_0000_0000; bits[68]:0x4_d560_9f1a_0101_858b"
//     args: "bits[53]:0x8_0000; (bits[53]:0x15_5555_5555_5555, bits[39]:0x1c_042a_8415, bits[44]:0x4_0000_0000, bits[63]:0x5555_5555_5555_5555); bits[21]:0x0; bits[6]:0x0; bits[125]:0x10_0000_0000_0000_0000_0000_0000_0000; bits[68]:0x7_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0x15_5555_5555_5555; (bits[53]:0x8_5805_1555_4525, bits[39]:0x7d_129b_1a56, bits[44]:0x555_5555_5555, bits[63]:0x510e_835e_679d_330b); bits[21]:0xa_aaaa; bits[6]:0x1; bits[125]:0x8ea_22be_d3ad_a5df_cffd_79fc_fabf_bf6a; bits[68]:0x2000_0000_0000"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xf_f7ff_dfff_ffff, bits[39]:0x3a_b96b_7ebf, bits[44]:0xd1d_caae_75b9, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0xa_aaaa; bits[6]:0x3f; bits[125]:0x2fd_687c_3ca4_9ca0_8534_1f51_5094_5504; bits[68]:0xf_eae8_a88a_2a0a_888a"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x1f_77ff_ae9f_ce5e, bits[39]:0x7d_f7d7_bff7, bits[44]:0x7ff_ffff_ffff, bits[63]:0x1a9f_5f6b_57ff_4962); bits[21]:0x15_5555; bits[6]:0x15; bits[125]:0x4b8_aead_9c2c_e880_5adc_3253_9274_e90e; bits[68]:0x0"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x55_5555_5555, bits[44]:0xaaa_aaaa_aba8, bits[63]:0x0); bits[21]:0x9_a5a3; bits[6]:0x15; bits[125]:0x8a6_a37f_dfff_ffff_f6f7_7dff_ffff_fffd; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x5d_ffde_8544, bits[44]:0x555_5555_5555, bits[63]:0x0); bits[21]:0x1b_ffbb; bits[6]:0x2a; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0xa_8080_00c8_0520_4004"
//     args: "bits[53]:0x1_361a_6283_d3ae; (bits[53]:0x2_a65a_f20f_63e3, bits[39]:0xa_6ea1_53aa, bits[44]:0x40_0000_0000, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0xa_aaaa; bits[6]:0x2f; bits[125]:0x136_1a62_83d3_0e7f_ffef_ffff_ffff_f7ff; bits[68]:0x5_5555_bfff_ddde_ffef"
//     args: "bits[53]:0x80_0000; (bits[53]:0x4_ba9d_d0f8_4a00, bits[39]:0x80_0000, bits[44]:0x115_1d83_434e, bits[63]:0x33_81c6_6048_11a2); bits[21]:0x15_5555; bits[6]:0x1f; bits[125]:0x0; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x0; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x40_2008_5050, bits[44]:0x555_5555_5555, bits[63]:0x2818_c004_0400_01bf); bits[21]:0x1_0000; bits[6]:0x2d; bits[125]:0x1b0_0a28_298e_fee0_6a38_8aa8_8cba_a97a; bits[68]:0x6a38_8aa8_8cb8_a13a"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0x1d_ff6b_fb6f_a96d, bits[39]:0x0, bits[44]:0x7ff_ffff_ffff, bits[63]:0x7fff_ffff_ffff_ffff); bits[21]:0x1f_ffff; bits[6]:0x2e; bits[125]:0xfec_8900_34aa_3e84_8036_a0f7_2305_a670; bits[68]:0x4_d74b_cd16_41d3_8737"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x15_5555_5555_5555, bits[39]:0x7f_ffff_ffff, bits[44]:0xf89_876f_97f9, bits[63]:0x1f7f_fddd_afbb_fdf5); bits[21]:0x1f_dfda; bits[6]:0x29; bits[125]:0xfff_f5ff_ffff_ff00_0000_0000_0000_0000; bits[68]:0x0"
//     args: "bits[53]:0x0; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x3c_b704_9b48, bits[44]:0x441_0965_240c, bits[63]:0x0); bits[21]:0xe_2c2c; bits[6]:0x30; bits[125]:0xf6e_2dec_ca96_ae8a_e8a2_2c93_e90a_aeff; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x0; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x405_0dd1_bf82, bits[63]:0x0); bits[21]:0x15_9004; bits[6]:0x0; bits[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa; bits[68]:0x6e65_b9ba_14ab_0401"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xa_aaaa_aaaa_aaaa, bits[39]:0x2a_aaaa_aaaa, bits[44]:0xefe_ffff_ffff, bits[63]:0x2458_8024_6607_f0f4); bits[21]:0x0; bits[6]:0x1a; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0x7_ffff_e7fc_6bfe_bfff"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xd_9d8c_2d2b_80a1, bits[39]:0x3a_aea8_a2aa, bits[44]:0x0, bits[63]:0x2aaa_aaab_a2ab_a989); bits[21]:0x0; bits[6]:0x8; bits[125]:0x100; bits[68]:0x5_5555_5555_5555_5555"
//     args: "bits[53]:0x0; (bits[53]:0x1b_7022_ec44_7d13, bits[39]:0x7_400d_4214, bits[44]:0x286_0040_0800, bits[63]:0x62a1_452c_8cc7_47e8); bits[21]:0x7_dafb; bits[6]:0x0; bits[125]:0x0; bits[68]:0xc_0000_8804_0020_0020"
//     args: "bits[53]:0xe_5651_0a32_4167; (bits[53]:0x1e_9746_de25_4477, bits[39]:0x2a_aaaa_aaaa, bits[44]:0x4a3_47bb_4879, bits[63]:0x39d9_4428_c905_9fbf); bits[21]:0x1f_ffff; bits[6]:0x3d; bits[125]:0x1fff_ffff_ffff_ffff_ffff_ffff_ffff_ffff; bits[68]:0xf_ffff_ffff_ffff_ffff"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0x2000, bits[39]:0x7d_f3ff_beb5, bits[44]:0x7b7_eece_b9df, bits[63]:0x2ffd_bee8_fff7_e3ef); bits[21]:0x1f_ffff; bits[6]:0x2b; bits[125]:0x1dc8_136b_28c8_fff6_74d0_ad1b_908a_260a; bits[68]:0xb_7ff7_feff_fff7_ffff"
//     args: "bits[53]:0x0; (bits[53]:0x10_6670_a2da_9940, bits[39]:0x10_9440_21a1, bits[44]:0x400_9011_000c, bits[63]:0x2aaa_aaaa_aaaa_aaaa); bits[21]:0x15_5555; bits[6]:0x15; bits[125]:0x800_0000_0000; bits[68]:0xa_aaaa_aaaa_aaaa_aaaa"
//     args: "bits[53]:0xa_aaaa_aaaa_aaaa; (bits[53]:0xe_cf8e_aaa9_efa9, bits[39]:0x1e_920b_227a, bits[44]:0x555_5555_5555, bits[63]:0x286a_3aab_ae22_e820); bits[21]:0x0; bits[6]:0x15; bits[125]:0xaba_eaaa_aaaa_aa00_2000_6100_6000_0002; bits[68]:0x4_0000_0000_0000"
//     args: "bits[53]:0xf_ffff_ffff_ffff; (bits[53]:0xf_ffff_ffff_ffff, bits[39]:0x7f_fefb_fffd, bits[44]:0x555_5555_5555, bits[63]:0x0); bits[21]:0x15_5555; bits[6]:0x1f; bits[125]:0xa99_f496_af44_73d5_817a_5abd_a538_08c7; bits[68]:0x1000_0000"
//     args: "bits[53]:0x1f_ffff_ffff_ffff; (bits[53]:0xb_3833_bce3_6ef7, bits[39]:0x55_5555_5555, bits[44]:0xaaa_aaaa_aaaa, bits[63]:0x3fff_ffff_ffff_ffff); bits[21]:0x0; bits[6]:0x3a; bits[125]:0x1fff_ffff_bfff_ff08_0000_0000_0000_0000; bits[68]:0x7198_ccea_4481_1490"
//     args: "bits[53]:0x200_0000_0000; (bits[53]:0x1f_ffff_ffff_ffff, bits[39]:0x2_0001_0549, bits[44]:0x201_86a5_802c, bits[63]:0x272b_b389_15f1_5e33); bits[21]:0x0; bits[6]:0x2a; bits[125]:0x1555_5555_5555_5555_5555_5555_5555_5555; bits[68]:0xf_ffff_ffff_ffff_ffff"
//   }
// }
// END_CONFIG
type x19 = u53;
fn main(x0: u53, x1: (u53, u39, u44, s63), x2: s21, x3: u6, x4: sN[125], x5: uN[68]) -> (sN[125], x19[4], uN[68]) {
  let x6: u53 = (x0) << (if (x0) >= (u53:12) { u53:12 } else { x0 });
  let x7: sN[125] = (x4) / (sN[125]:0xaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa_aaaa);
  let x8: u6 = (x3)[:];
  let x9: u39 = x1.1;
  let x10: sN[125] = one_hot_sel(x3, [x4, x4, x7, x7, x7, x7]);
  let x11: uN[251] = ((((x6) ++ (x6)) ++ (x0)) ++ (x0)) ++ (x9);
  let x12: s19 = s19:0x7_ffff;
  let x13: s21 = !(x2);
  let x14: uN[191] = ((((x8) ++ (x5)) ++ (x9)) ++ (x9)) ++ (x9);
  let x15: uN[68] = -(x5);
  let x16: u6 = (((x8) as u6)) ^ (x3);
  let x17: u53 = !(x6);
  let x18: u53 = !(x17);
  let x20: x19[4] = [x0, x17, x18, x6];
  let x21: uN[68] = (((x7) as uN[68])) * (x15);
  let x22: sN[125] = (x10) - (((x5) as sN[125]));
  let x23: (s21, u6, u53, x19[4]) = (x2, x8, x6, x20);
  let x24: uN[289] = (((x16) ++ (x9)) ++ (x18)) ++ (x14);
  let x25: uN[191] = !(x14);
  (x22, x20, x21)
}
