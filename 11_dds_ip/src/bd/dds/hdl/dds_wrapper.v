//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sat Feb 24 14:03:40 2024
//Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
//Command     : generate_target dds_wrapper.bd
//Design      : dds_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dds_wrapper
   (M_AXIS_DATA_0_tdata,
    M_AXIS_DATA_0_tready,
    M_AXIS_DATA_0_tvalid,
    M_AXIS_PHASE_0_tdata,
    M_AXIS_PHASE_0_tready,
    M_AXIS_PHASE_0_tvalid,
    aclk_0);
  output [7:0]M_AXIS_DATA_0_tdata;
  input M_AXIS_DATA_0_tready;
  output M_AXIS_DATA_0_tvalid;
  output [15:0]M_AXIS_PHASE_0_tdata;
  input M_AXIS_PHASE_0_tready;
  output M_AXIS_PHASE_0_tvalid;
  input aclk_0;

  wire [7:0]M_AXIS_DATA_0_tdata;
  wire M_AXIS_DATA_0_tready;
  wire M_AXIS_DATA_0_tvalid;
  wire [15:0]M_AXIS_PHASE_0_tdata;
  wire M_AXIS_PHASE_0_tready;
  wire M_AXIS_PHASE_0_tvalid;
  wire aclk_0;

  dds dds_i
       (.M_AXIS_DATA_0_tdata(M_AXIS_DATA_0_tdata),
        .M_AXIS_DATA_0_tready(M_AXIS_DATA_0_tready),
        .M_AXIS_DATA_0_tvalid(M_AXIS_DATA_0_tvalid),
        .M_AXIS_PHASE_0_tdata(M_AXIS_PHASE_0_tdata),
        .M_AXIS_PHASE_0_tready(M_AXIS_PHASE_0_tready),
        .M_AXIS_PHASE_0_tvalid(M_AXIS_PHASE_0_tvalid),
        .aclk_0(aclk_0));
endmodule
