-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Mon Jan 22 02:38:56 2024
-- Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/SoftwareData/Vivado/FPGA_Learning/10_dds/src/ip_repo/clk_pll_125m/clk_pll_125m_stub.vhdl
-- Design      : clk_pll_125m
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_pll_125m is
  Port ( 
    clk_out : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end clk_pll_125m;

architecture stub of clk_pll_125m is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out,clk_in";
begin
end;
