//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Fri Feb 23 22:18:05 2024
//Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
//Command     : generate_target microblaze_wrapper.bd
//Design      : microblaze_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module microblaze_wrapper
   (led_tri_o,
    sys_clk,
    uart_rtl_0_rxd,
    uart_rtl_0_txd);
  output [3:0]led_tri_o;
  input sys_clk;
  input uart_rtl_0_rxd;
  output uart_rtl_0_txd;

  wire [3:0]led_tri_o;
  wire sys_clk;
  wire uart_rtl_0_rxd;
  wire uart_rtl_0_txd;

  microblaze microblaze_i
       (.led_tri_o(led_tri_o),
        .sys_clk(sys_clk),
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd));
endmodule
