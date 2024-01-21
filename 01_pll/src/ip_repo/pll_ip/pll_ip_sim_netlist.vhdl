-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Jan 20 20:13:48 2024
-- Host        : LAPTOP-0I7S0H2D running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/SoftwareData/Vivado/Project/pll_ip/src/ip_repo/pll_ip/pll_ip_sim_netlist.vhdl
-- Design      : pll_ip
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tfgg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pll_ip_pll_ip_clk_wiz is
  port (
    clk_100m : out STD_LOGIC;
    clk_25m : out STD_LOGIC;
    clk_s_90 : out STD_LOGIC;
    clk_d_20 : out STD_LOGIC;
    locked : out STD_LOGIC;
    pll_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pll_ip_pll_ip_clk_wiz : entity is "pll_ip_clk_wiz";
end pll_ip_pll_ip_clk_wiz;

architecture STRUCTURE of pll_ip_pll_ip_clk_wiz is
  signal clk_100m_pll_ip : STD_LOGIC;
  signal clk_25m_pll_ip : STD_LOGIC;
  signal clk_d_20_pll_ip : STD_LOGIC;
  signal clk_s_90_pll_ip : STD_LOGIC;
  signal clkfbout_buf_pll_ip : STD_LOGIC;
  signal clkfbout_pll_ip : STD_LOGIC;
  signal pll_clk_pll_ip : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_plle2_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_ibufg : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufg : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufg : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufg : label is "AUTO";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout3_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout4_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of plle2_adv_inst : label is "PRIMITIVE";
begin
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_pll_ip,
      O => clkfbout_buf_pll_ip
    );
clkin1_ibufg: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => pll_clk,
      O => pll_clk_pll_ip
    );
clkout1_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_100m_pll_ip,
      O => clk_100m
    );
clkout2_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_25m_pll_ip,
      O => clk_25m
    );
clkout3_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_s_90_pll_ip,
      O => clk_s_90
    );
clkout4_buf: unisim.vcomponents.BUFG
     port map (
      I => clk_d_20_pll_ip,
      O => clk_d_20
    );
plle2_adv_inst: unisim.vcomponents.PLLE2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT => 20,
      CLKFBOUT_PHASE => 0.000000,
      CLKIN1_PERIOD => 20.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE => 10,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT1_DIVIDE => 40,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT2_DIVIDE => 20,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 90.000000,
      CLKOUT3_DIVIDE => 20,
      CLKOUT3_DUTY_CYCLE => 0.200000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CLKFBIN => clkfbout_buf_pll_ip,
      CLKFBOUT => clkfbout_pll_ip,
      CLKIN1 => pll_clk_pll_ip,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKOUT0 => clk_100m_pll_ip,
      CLKOUT1 => clk_25m_pll_ip,
      CLKOUT2 => clk_s_90_pll_ip,
      CLKOUT3 => clk_d_20_pll_ip,
      CLKOUT4 => NLW_plle2_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_plle2_adv_inst_CLKOUT5_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_plle2_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_plle2_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => locked,
      PWRDWN => '0',
      RST => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pll_ip is
  port (
    clk_100m : out STD_LOGIC;
    clk_25m : out STD_LOGIC;
    clk_s_90 : out STD_LOGIC;
    clk_d_20 : out STD_LOGIC;
    locked : out STD_LOGIC;
    pll_clk : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of pll_ip : entity is true;
end pll_ip;

architecture STRUCTURE of pll_ip is
begin
inst: entity work.pll_ip_pll_ip_clk_wiz
     port map (
      clk_100m => clk_100m,
      clk_25m => clk_25m,
      clk_d_20 => clk_d_20,
      clk_s_90 => clk_s_90,
      locked => locked,
      pll_clk => pll_clk
    );
end STRUCTURE;
