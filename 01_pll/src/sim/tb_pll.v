`timescale 1ns / 1ns

module tb_pll();

reg sys_clk;
wire clk_100m;
wire clk_25m;
wire clk_s_90;
wire clk_d_20;
wire locked;
initial sys_clk = 1'b1;

always #10 sys_clk = ~sys_clk;

pll pll_ip_inst(
    .sys_clk(sys_clk),
    .clk_100m(clk_100m),
    .clk_25m(clk_25m),
    .clk_s_90(clk_s_90),
    .clk_d_20(clk_d_20),
    .locked(locked)
    );
endmodule
