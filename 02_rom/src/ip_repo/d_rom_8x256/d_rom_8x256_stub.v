// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Jan 21 12:45:34 2024
// Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/SoftwareData/Vivado/FPGA_Learning/02_rom/src/ip_repo/d_rom_8x256/d_rom_8x256_stub.v
// Design      : d_rom_8x256
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module d_rom_8x256(clka, addra, douta, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[7:0],douta[7:0],clkb,addrb[6:0],doutb[15:0]" */;
  input clka;
  input [7:0]addra;
  output [7:0]douta;
  input clkb;
  input [6:0]addrb;
  output [15:0]doutb;
endmodule
