// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Feb 24 14:04:24 2024
// Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/SoftwareData/Vivado/FPGA_Learning/11_dds_ip/src/bd/dds/ip/dds_dds_compiler_0_0/dds_dds_compiler_0_0_stub.v
// Design      : dds_dds_compiler_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_17,Vivado 2018.3" *)
module dds_dds_compiler_0_0(aclk, m_axis_data_tvalid, m_axis_data_tready, 
  m_axis_data_tdata, m_axis_phase_tvalid, m_axis_phase_tready, m_axis_phase_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,m_axis_data_tvalid,m_axis_data_tready,m_axis_data_tdata[7:0],m_axis_phase_tvalid,m_axis_phase_tready,m_axis_phase_tdata[15:0]" */;
  input aclk;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [7:0]m_axis_data_tdata;
  output m_axis_phase_tvalid;
  input m_axis_phase_tready;
  output [15:0]m_axis_phase_tdata;
endmodule
