// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Feb 24 14:04:24 2024
// Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/SoftwareData/Vivado/FPGA_Learning/11_dds_ip/src/bd/dds/ip/dds_dds_compiler_0_0/dds_dds_compiler_0_0_sim_netlist.v
// Design      : dds_dds_compiler_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dds_dds_compiler_0_0,dds_compiler_v6_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dds_compiler_v6_0_17,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module dds_dds_compiler_0_0
   (aclk,
    m_axis_data_tvalid,
    m_axis_data_tready,
    m_axis_data_tdata,
    m_axis_phase_tvalid,
    m_axis_phase_tready,
    m_axis_phase_tdata);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF M_AXIS_PHASE:S_AXIS_CONFIG:M_AXIS_DATA:S_AXIS_PHASE, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN dds_aclk_0, INSERT_VIP 0" *) input aclk;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_DATA, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN dds_aclk_0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} array_type {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value chan} size {attribs {resolve_type generated dependency chan_size format long minimum {} maximum {}} value 1} stride {attribs {resolve_type generated dependency chan_stride format long minimum {} maximum {}} value 8} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_cosine {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value cosine} enabled {attribs {resolve_type generated dependency cosine_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency cosine_width format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type generated dependency cosine_fractwidth format long minimum {} maximum {}} value 7} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}} field_sine {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value sine} enabled {attribs {resolve_type generated dependency sine_enabled format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency sine_width format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type generated dependency sine_offset format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type generated dependency sine_fractwidth format long minimum {} maximum {}} value 7} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}}}}} TDATA_WIDTH 8 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_chanid {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value chanid} enabled {attribs {resolve_type generated dependency chanid_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency chanid_width format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} field_user {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value user} enabled {attribs {resolve_type generated dependency user_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency user_width format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency user_offset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, INSERT_VIP 0" *) output m_axis_data_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TREADY" *) input m_axis_data_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TDATA" *) output [7:0]m_axis_data_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_PHASE, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN dds_aclk_0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} array_type {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value chan} size {attribs {resolve_type generated dependency chan_size format long minimum {} maximum {}} value 1} stride {attribs {resolve_type generated dependency chan_stride format long minimum {} maximum {}} value 16} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_phase_out {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value phase_out} enabled {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency phase_width format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type generated dependency phase_fractwidth format long minimum {} maximum {}} value 16} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}}}}} TDATA_WIDTH 16 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_chanid {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value chanid} enabled {attribs {resolve_type generated dependency chanid_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency chanid_width format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} field_user {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value user} enabled {attribs {resolve_type generated dependency user_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency user_width format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency user_offset format long minimum {} maximum {}} value 0}}}}}} TUSER_WIDTH 0}, INSERT_VIP 0" *) output m_axis_phase_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TREADY" *) input m_axis_phase_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TDATA" *) output [15:0]m_axis_phase_tdata;

  wire aclk;
  wire [7:0]m_axis_data_tdata;
  wire m_axis_data_tready;
  wire m_axis_data_tvalid;
  wire [15:0]m_axis_phase_tdata;
  wire m_axis_phase_tready;
  wire m_axis_phase_tvalid;
  wire NLW_U0_debug_axi_resync_in_UNCONNECTED;
  wire NLW_U0_debug_core_nd_UNCONNECTED;
  wire NLW_U0_debug_phase_nd_UNCONNECTED;
  wire NLW_U0_event_phase_in_invalid_UNCONNECTED;
  wire NLW_U0_event_pinc_invalid_UNCONNECTED;
  wire NLW_U0_event_poff_invalid_UNCONNECTED;
  wire NLW_U0_event_s_config_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_config_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_m_axis_data_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_phase_tlast_UNCONNECTED;
  wire NLW_U0_s_axis_config_tready_UNCONNECTED;
  wire NLW_U0_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_U0_debug_axi_chan_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_pinc_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_poff_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_phase_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_phase_tuser_UNCONNECTED;

  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "1" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_M_DATA = "1" *) 
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "0" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "1" *) 
  (* C_LATENCY = "6" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "8" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "16" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "0" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "8" *) 
  (* C_PHASE_ANGLE_WIDTH = "8" *) 
  (* C_PHASE_INCREMENT = "2" *) 
  (* C_PHASE_INCREMENT_VALUE = "1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "2" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  dds_dds_compiler_0_0_dds_compiler_v6_0_17 U0
       (.aclk(aclk),
        .aclken(1'b1),
        .aresetn(1'b1),
        .debug_axi_chan_in(NLW_U0_debug_axi_chan_in_UNCONNECTED[0]),
        .debug_axi_pinc_in(NLW_U0_debug_axi_pinc_in_UNCONNECTED[15:0]),
        .debug_axi_poff_in(NLW_U0_debug_axi_poff_in_UNCONNECTED[15:0]),
        .debug_axi_resync_in(NLW_U0_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(NLW_U0_debug_core_nd_UNCONNECTED),
        .debug_phase(NLW_U0_debug_phase_UNCONNECTED[15:0]),
        .debug_phase_nd(NLW_U0_debug_phase_nd_UNCONNECTED),
        .event_phase_in_invalid(NLW_U0_event_phase_in_invalid_UNCONNECTED),
        .event_pinc_invalid(NLW_U0_event_pinc_invalid_UNCONNECTED),
        .event_poff_invalid(NLW_U0_event_poff_invalid_UNCONNECTED),
        .event_s_config_tlast_missing(NLW_U0_event_s_config_tlast_missing_UNCONNECTED),
        .event_s_config_tlast_unexpected(NLW_U0_event_s_config_tlast_unexpected_UNCONNECTED),
        .event_s_phase_chanid_incorrect(NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED),
        .event_s_phase_tlast_missing(NLW_U0_event_s_phase_tlast_missing_UNCONNECTED),
        .event_s_phase_tlast_unexpected(NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tlast(NLW_U0_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(m_axis_data_tready),
        .m_axis_data_tuser(NLW_U0_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tlast(NLW_U0_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(m_axis_phase_tready),
        .m_axis_phase_tuser(NLW_U0_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .s_axis_config_tdata(1'b0),
        .s_axis_config_tlast(1'b0),
        .s_axis_config_tready(NLW_U0_s_axis_config_tready_UNCONNECTED),
        .s_axis_config_tvalid(1'b0),
        .s_axis_phase_tdata(1'b0),
        .s_axis_phase_tlast(1'b0),
        .s_axis_phase_tready(NLW_U0_s_axis_phase_tready_UNCONNECTED),
        .s_axis_phase_tuser(1'b0),
        .s_axis_phase_tvalid(1'b0));
endmodule

(* C_ACCUMULATOR_WIDTH = "16" *) (* C_AMPLITUDE = "0" *) (* C_CHANNELS = "1" *) 
(* C_CHAN_WIDTH = "1" *) (* C_DEBUG_INTERFACE = "0" *) (* C_HAS_ACLKEN = "0" *) 
(* C_HAS_ARESETN = "0" *) (* C_HAS_M_DATA = "1" *) (* C_HAS_M_PHASE = "1" *) 
(* C_HAS_PHASEGEN = "1" *) (* C_HAS_PHASE_OUT = "1" *) (* C_HAS_SINCOS = "1" *) 
(* C_HAS_S_CONFIG = "0" *) (* C_HAS_S_PHASE = "0" *) (* C_HAS_TLAST = "0" *) 
(* C_HAS_TREADY = "1" *) (* C_LATENCY = "6" *) (* C_MEM_TYPE = "1" *) 
(* C_MODE_OF_OPERATION = "0" *) (* C_MODULUS = "9" *) (* C_M_DATA_HAS_TUSER = "0" *) 
(* C_M_DATA_TDATA_WIDTH = "8" *) (* C_M_DATA_TUSER_WIDTH = "1" *) (* C_M_PHASE_HAS_TUSER = "0" *) 
(* C_M_PHASE_TDATA_WIDTH = "16" *) (* C_M_PHASE_TUSER_WIDTH = "1" *) (* C_NEGATIVE_COSINE = "0" *) 
(* C_NEGATIVE_SINE = "0" *) (* C_NOISE_SHAPING = "0" *) (* C_OPTIMISE_GOAL = "0" *) 
(* C_OUTPUTS_REQUIRED = "0" *) (* C_OUTPUT_FORM = "0" *) (* C_OUTPUT_WIDTH = "8" *) 
(* C_PHASE_ANGLE_WIDTH = "8" *) (* C_PHASE_INCREMENT = "2" *) (* C_PHASE_INCREMENT_VALUE = "1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
(* C_PHASE_OFFSET = "2" *) (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) (* C_POR_MODE = "0" *) 
(* C_RESYNC = "0" *) (* C_S_CONFIG_SYNC_MODE = "0" *) (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
(* C_S_PHASE_HAS_TUSER = "0" *) (* C_S_PHASE_TDATA_WIDTH = "1" *) (* C_S_PHASE_TUSER_WIDTH = "1" *) 
(* C_USE_DSP48 = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "dds_compiler_v6_0_17" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module dds_dds_compiler_0_0_dds_compiler_v6_0_17
   (aclk,
    aclken,
    aresetn,
    s_axis_phase_tvalid,
    s_axis_phase_tready,
    s_axis_phase_tdata,
    s_axis_phase_tlast,
    s_axis_phase_tuser,
    s_axis_config_tvalid,
    s_axis_config_tready,
    s_axis_config_tdata,
    s_axis_config_tlast,
    m_axis_data_tvalid,
    m_axis_data_tready,
    m_axis_data_tdata,
    m_axis_data_tlast,
    m_axis_data_tuser,
    m_axis_phase_tvalid,
    m_axis_phase_tready,
    m_axis_phase_tdata,
    m_axis_phase_tlast,
    m_axis_phase_tuser,
    event_pinc_invalid,
    event_poff_invalid,
    event_phase_in_invalid,
    event_s_phase_tlast_missing,
    event_s_phase_tlast_unexpected,
    event_s_phase_chanid_incorrect,
    event_s_config_tlast_missing,
    event_s_config_tlast_unexpected,
    debug_axi_pinc_in,
    debug_axi_poff_in,
    debug_axi_resync_in,
    debug_axi_chan_in,
    debug_core_nd,
    debug_phase,
    debug_phase_nd);
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_phase_tvalid;
  output s_axis_phase_tready;
  input [0:0]s_axis_phase_tdata;
  input s_axis_phase_tlast;
  input [0:0]s_axis_phase_tuser;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [0:0]s_axis_config_tdata;
  input s_axis_config_tlast;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [7:0]m_axis_data_tdata;
  output m_axis_data_tlast;
  output [0:0]m_axis_data_tuser;
  output m_axis_phase_tvalid;
  input m_axis_phase_tready;
  output [15:0]m_axis_phase_tdata;
  output m_axis_phase_tlast;
  output [0:0]m_axis_phase_tuser;
  output event_pinc_invalid;
  output event_poff_invalid;
  output event_phase_in_invalid;
  output event_s_phase_tlast_missing;
  output event_s_phase_tlast_unexpected;
  output event_s_phase_chanid_incorrect;
  output event_s_config_tlast_missing;
  output event_s_config_tlast_unexpected;
  output [15:0]debug_axi_pinc_in;
  output [15:0]debug_axi_poff_in;
  output debug_axi_resync_in;
  output [0:0]debug_axi_chan_in;
  output debug_core_nd;
  output [15:0]debug_phase;
  output debug_phase_nd;

  wire \<const0> ;
  wire \<const1> ;
  wire aclk;
  wire [7:0]m_axis_data_tdata;
  wire m_axis_data_tready;
  wire m_axis_data_tvalid;
  wire [15:0]m_axis_phase_tdata;
  wire m_axis_phase_tready;
  wire m_axis_phase_tvalid;
  wire NLW_i_synth_debug_axi_resync_in_UNCONNECTED;
  wire NLW_i_synth_debug_core_nd_UNCONNECTED;
  wire NLW_i_synth_debug_phase_nd_UNCONNECTED;
  wire NLW_i_synth_event_phase_in_invalid_UNCONNECTED;
  wire NLW_i_synth_event_pinc_invalid_UNCONNECTED;
  wire NLW_i_synth_event_poff_invalid_UNCONNECTED;
  wire NLW_i_synth_event_s_config_tlast_missing_UNCONNECTED;
  wire NLW_i_synth_event_s_config_tlast_unexpected_UNCONNECTED;
  wire NLW_i_synth_event_s_phase_chanid_incorrect_UNCONNECTED;
  wire NLW_i_synth_event_s_phase_tlast_missing_UNCONNECTED;
  wire NLW_i_synth_event_s_phase_tlast_unexpected_UNCONNECTED;
  wire NLW_i_synth_m_axis_data_tlast_UNCONNECTED;
  wire NLW_i_synth_m_axis_phase_tlast_UNCONNECTED;
  wire NLW_i_synth_s_axis_config_tready_UNCONNECTED;
  wire NLW_i_synth_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_i_synth_debug_axi_chan_in_UNCONNECTED;
  wire [15:0]NLW_i_synth_debug_axi_pinc_in_UNCONNECTED;
  wire [15:0]NLW_i_synth_debug_axi_poff_in_UNCONNECTED;
  wire [15:0]NLW_i_synth_debug_phase_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_phase_tuser_UNCONNECTED;

  assign debug_axi_chan_in[0] = \<const0> ;
  assign debug_axi_pinc_in[15] = \<const0> ;
  assign debug_axi_pinc_in[14] = \<const0> ;
  assign debug_axi_pinc_in[13] = \<const0> ;
  assign debug_axi_pinc_in[12] = \<const0> ;
  assign debug_axi_pinc_in[11] = \<const0> ;
  assign debug_axi_pinc_in[10] = \<const0> ;
  assign debug_axi_pinc_in[9] = \<const0> ;
  assign debug_axi_pinc_in[8] = \<const0> ;
  assign debug_axi_pinc_in[7] = \<const0> ;
  assign debug_axi_pinc_in[6] = \<const0> ;
  assign debug_axi_pinc_in[5] = \<const0> ;
  assign debug_axi_pinc_in[4] = \<const0> ;
  assign debug_axi_pinc_in[3] = \<const0> ;
  assign debug_axi_pinc_in[2] = \<const0> ;
  assign debug_axi_pinc_in[1] = \<const0> ;
  assign debug_axi_pinc_in[0] = \<const0> ;
  assign debug_axi_poff_in[15] = \<const0> ;
  assign debug_axi_poff_in[14] = \<const0> ;
  assign debug_axi_poff_in[13] = \<const0> ;
  assign debug_axi_poff_in[12] = \<const0> ;
  assign debug_axi_poff_in[11] = \<const0> ;
  assign debug_axi_poff_in[10] = \<const0> ;
  assign debug_axi_poff_in[9] = \<const0> ;
  assign debug_axi_poff_in[8] = \<const0> ;
  assign debug_axi_poff_in[7] = \<const0> ;
  assign debug_axi_poff_in[6] = \<const0> ;
  assign debug_axi_poff_in[5] = \<const0> ;
  assign debug_axi_poff_in[4] = \<const0> ;
  assign debug_axi_poff_in[3] = \<const0> ;
  assign debug_axi_poff_in[2] = \<const0> ;
  assign debug_axi_poff_in[1] = \<const0> ;
  assign debug_axi_poff_in[0] = \<const0> ;
  assign debug_axi_resync_in = \<const0> ;
  assign debug_core_nd = \<const0> ;
  assign debug_phase[15] = \<const0> ;
  assign debug_phase[14] = \<const0> ;
  assign debug_phase[13] = \<const0> ;
  assign debug_phase[12] = \<const0> ;
  assign debug_phase[11] = \<const0> ;
  assign debug_phase[10] = \<const0> ;
  assign debug_phase[9] = \<const0> ;
  assign debug_phase[8] = \<const0> ;
  assign debug_phase[7] = \<const0> ;
  assign debug_phase[6] = \<const0> ;
  assign debug_phase[5] = \<const0> ;
  assign debug_phase[4] = \<const0> ;
  assign debug_phase[3] = \<const0> ;
  assign debug_phase[2] = \<const0> ;
  assign debug_phase[1] = \<const0> ;
  assign debug_phase[0] = \<const0> ;
  assign debug_phase_nd = \<const0> ;
  assign event_phase_in_invalid = \<const0> ;
  assign event_pinc_invalid = \<const0> ;
  assign event_poff_invalid = \<const0> ;
  assign event_s_config_tlast_missing = \<const0> ;
  assign event_s_config_tlast_unexpected = \<const0> ;
  assign event_s_phase_chanid_incorrect = \<const0> ;
  assign event_s_phase_tlast_missing = \<const0> ;
  assign event_s_phase_tlast_unexpected = \<const0> ;
  assign m_axis_data_tlast = \<const0> ;
  assign m_axis_data_tuser[0] = \<const0> ;
  assign m_axis_phase_tlast = \<const0> ;
  assign m_axis_phase_tuser[0] = \<const0> ;
  assign s_axis_config_tready = \<const1> ;
  assign s_axis_phase_tready = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "1" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_M_DATA = "1" *) 
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "0" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "1" *) 
  (* C_LATENCY = "6" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "8" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "16" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "0" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "8" *) 
  (* C_PHASE_ANGLE_WIDTH = "8" *) 
  (* C_PHASE_INCREMENT = "2" *) 
  (* C_PHASE_INCREMENT_VALUE = "1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "2" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  dds_dds_compiler_0_0_dds_compiler_v6_0_17_viv i_synth
       (.aclk(aclk),
        .aclken(1'b0),
        .aresetn(1'b0),
        .debug_axi_chan_in(NLW_i_synth_debug_axi_chan_in_UNCONNECTED[0]),
        .debug_axi_pinc_in(NLW_i_synth_debug_axi_pinc_in_UNCONNECTED[15:0]),
        .debug_axi_poff_in(NLW_i_synth_debug_axi_poff_in_UNCONNECTED[15:0]),
        .debug_axi_resync_in(NLW_i_synth_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(NLW_i_synth_debug_core_nd_UNCONNECTED),
        .debug_phase(NLW_i_synth_debug_phase_UNCONNECTED[15:0]),
        .debug_phase_nd(NLW_i_synth_debug_phase_nd_UNCONNECTED),
        .event_phase_in_invalid(NLW_i_synth_event_phase_in_invalid_UNCONNECTED),
        .event_pinc_invalid(NLW_i_synth_event_pinc_invalid_UNCONNECTED),
        .event_poff_invalid(NLW_i_synth_event_poff_invalid_UNCONNECTED),
        .event_s_config_tlast_missing(NLW_i_synth_event_s_config_tlast_missing_UNCONNECTED),
        .event_s_config_tlast_unexpected(NLW_i_synth_event_s_config_tlast_unexpected_UNCONNECTED),
        .event_s_phase_chanid_incorrect(NLW_i_synth_event_s_phase_chanid_incorrect_UNCONNECTED),
        .event_s_phase_tlast_missing(NLW_i_synth_event_s_phase_tlast_missing_UNCONNECTED),
        .event_s_phase_tlast_unexpected(NLW_i_synth_event_s_phase_tlast_unexpected_UNCONNECTED),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tlast(NLW_i_synth_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(m_axis_data_tready),
        .m_axis_data_tuser(NLW_i_synth_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tlast(NLW_i_synth_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(m_axis_phase_tready),
        .m_axis_phase_tuser(NLW_i_synth_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .s_axis_config_tdata(1'b0),
        .s_axis_config_tlast(1'b0),
        .s_axis_config_tready(NLW_i_synth_s_axis_config_tready_UNCONNECTED),
        .s_axis_config_tvalid(1'b0),
        .s_axis_phase_tdata(1'b0),
        .s_axis_phase_tlast(1'b0),
        .s_axis_phase_tready(NLW_i_synth_s_axis_phase_tready_UNCONNECTED),
        .s_axis_phase_tuser(1'b0),
        .s_axis_phase_tvalid(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
gl8oTb3yK39LjDQS0B4PYP+vte8cGiBpEmJ9JLxCkI04rBQJe5sCt4dvUGvg1Ga0GoPkN0BTvh6i
v1YMWuZiJg==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
LV5tnIhV6fXU4gAQOLXCxdxya9doivJt+Y+5yV24zJ1I56Mu4gOTYyKzdDBlwz49as5fPNOvHvtM
FEjflUU6R2Yh76tXBr2An7Tc7qdcv/WUX57JWpXSPQfxdtsoJzfNEA5lf9cFyHWa+eE27NH4fCIB
fHvZTqNYCqZpO8hMEWo=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CtefK+dE5tJYyIkOlXrI1GU3HbXkaFgSREpPJj1NZdNualyVqOHiPJK5xJ71xxO6zkXYtBYfzkxn
9Eqf7SpqFizTSC3YZVNAp0ix3wloJ2xu9/08YGAzwYtrD72s/REOd9GdOS5BW5KfXcLDWxJnWFK3
mjj+cPJfHeoGuNLu6gH6HD/lNP6geaOelYYVD/TVk4P/j6qWfCikFKKuomVo3jbRD7F7QdkJDCeh
d5Xc8VxEXSaKIjFRuMTWZtjAQjFH5UpSMVhxV/fXhvzSM6V5P4QZA+memX692B8GYsTFU76iMlss
d7ocDlaRWbY0BTXFb2HZNfGcl+sqYKs8PYn/UA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UTuJ2/FiXz7w8k47LqoJjpB8chaAWEBjYpgn4jj1PBd2l6Nj6avA0We0iYNi5AJkwcUofxaNsFtE
+sVWsmGPk/0vN5Q90wbwbfGu18ni9SqWiSNRSUzzfB9h0bol599BuMG2pbcdYlanUIn9oPi4ZKeJ
2M667aoQ2BTcU/o1U8nn5wuoiboeNIqzcJS0jj+j6J5UYz5aHgwMcFlCGUwSQuAp+2VIulW4T1IV
NW+4iXCF7wife+1/XS6RYcYu+n4km8U2A8z/nLIuNXSO1T2HaR6rR3YxTorPEFUQnfrre1FxRLzT
6pi4dXPFPyG1bXISdn2AleLyNN3VFQjTEgHwsA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FMUkchj5p9XvgJ9tR5grSuP9aw5xa30l1YgNWO9WvtYYjYtQnsPBns5ryDL+PXPqQYQ3i0NvbEVZ
mN4H44H269BdOgH+vRRI3SR79goz8NqADp1QSv06wD02bUASlMq9aM6Phdxmqoalzn7A7dWDa+nU
2QokmpYQQylaKE1ZbXrz6loBY1IeoaMxbsQcvxJcI2aG1HO9NfyR9d5i3K9UmO1t9jFA+8k+GsKj
kNnLxX6I0J9fN8wKc7D007S9DgoQs6+WuCL6CudeG25OH6Gy/uLkY2Udzdpodegx89FgRLo92dDh
+0eWKh3H5TN2vtQ9mtD1iH6zm1l1IqnYy2G06A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
IjA88m1asiYMyCqMLSP/pVhA6mm9v8t5bFtEAMOvlQO8WTy5Vpca8kFPPuhuf6voqy+zwcLXRU9a
5UwLvCxgOEOo68GA3l4AR9WaPmcxPTPUwChO8zkHIDrS0eoDFMY1OTr1Lv8pbJknphtPExopREwk
KuHbtq4Mg3zw+se7q5E=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nZ0uDa4zhbQfoZoNpOAKrHOsOrOlSYjg5j1zWlifZ7mksZmmo1GUwbu4BrFKsE9nPAJUOa85AaS6
3sPqXGDLUL68TzDI06mN0/idhoIRBSJNinUfJpw4Ro9h/zNx1E//RfaHklSArW0rHrP6JnabQq/E
ywpKofyKtfWBjZrTJqD+xFD3BsXO9W35e9lAY/pTqzN6C7dC2o6xELYMw7a37e+7TEDqEPb1kk1i
VC/DX7v1veomIkT4wlTej+pa1pSQH6uN/huOhLuz4yEz/zZdnoDInKQyuWaZgdQV+2dfYBgbf+po
404pK0Ii/DBBTh6IKooZGzVmsyG/5MKNX6F9vw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OpitmzVWkukNOOtAM4FX8z/3G/hEsmZvNVp97wjJcFKf5IeTFQg1dttmi1SUNq4EDlP7um40WjEY
189BrOCdwmb2VNZPfNYNPRzR4RtvKHkFIkdTru4I3IZ5p0Tj+kmxCEhK99+meYc5WMuHoy+V2BDJ
FU0c32CKjNH9wdF/yqq6TbxFKG9vKXa1lLCzKGPH7GWFrejFuuVMANkv8VGhTcC2BoOtA5vRjw6a
pkl09QjLAOnpZKuGFS4OiOgupTQ37n5EvbaV+ND793maZ8+aCy5wBSb20gc7t4wlgNqZlPv/nmpC
Ry2U2cv2Gl+08xa5SJcU3qUFukX5WcwtKzHP0A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oK7LoSob3AACiDBKWNAL6QV417YzIHNselja7Ut6hx6nXfeYc/d9ATmhiz5IokrkMsuAIwxfmE6i
/vYL/akAo/1kMTxlGYnaKoRWeY2LSrIt3K6pDOJ+e23CbzbRH2p2a8dzT4E9LaxbChGpn7ZS7om1
0gpvjgAiz9se5hLkarQbKpACnuQDGaeVWJWE8pLoEJpYMXdlLwZQQ1A0UKeuJU6qNDmqlTUqrF/+
qxsAhDuMRIqhMSxGG8zX5aBq+Hz3AbsBQb5J0oj7PVlMjJk4njeEp6tUqSLyWG/Tdtgv+wPZ/HbE
9s3q4DVwTHLNyC8zLjVMBkb8HGYuTlivMugdvw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 71984)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
