-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Jan 20 20:13:48 2024
-- Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/SoftwareData/Vivado/Project/pll_ip/src/ip_repo/pll_ip/pll_ip_stub.vhdl
-- Design      : pll_ip
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pll_ip is
  Port ( 
    clk_100m : out STD_LOGIC;
    clk_25m : out STD_LOGIC;
    clk_s_90 : out STD_LOGIC;
    clk_d_20 : out STD_LOGIC;
    locked : out STD_LOGIC;
    pll_clk : in STD_LOGIC
  );

end pll_ip;

architecture stub of pll_ip is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_100m,clk_25m,clk_s_90,clk_d_20,locked,pll_clk";
begin
end;
