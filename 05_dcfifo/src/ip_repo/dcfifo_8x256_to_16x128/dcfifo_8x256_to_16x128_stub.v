// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Jan 21 22:52:06 2024
// Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/SoftwareData/Vivado/FPGA_Learning/05_dcfifo/src/ip_repo/dcfifo_8x256_to_16x128/dcfifo_8x256_to_16x128_stub.v
// Design      : dcfifo_8x256_to_16x128
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_3,Vivado 2018.3" *)
module dcfifo_8x256_to_16x128(wr_clk, rd_clk, din, wr_en, rd_en, dout, full, empty, 
  rd_data_count, wr_data_count)
/* synthesis syn_black_box black_box_pad_pin="wr_clk,rd_clk,din[7:0],wr_en,rd_en,dout[15:0],full,empty,rd_data_count[6:0],wr_data_count[7:0]" */;
  input wr_clk;
  input rd_clk;
  input [7:0]din;
  input wr_en;
  input rd_en;
  output [15:0]dout;
  output full;
  output empty;
  output [6:0]rd_data_count;
  output [7:0]wr_data_count;
endmodule
