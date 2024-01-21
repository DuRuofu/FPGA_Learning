
// 测试IP核调用
module pll(
    input   wire sys_clk,
    output  wire clk_100m,
    output  wire clk_25m,
    output  wire clk_s_90,
    output  wire clk_d_20,
    output  wire locked
    );

pll_ip pll_ip_inst
(
    // Clock out ports
    .clk_100m   (clk_100m),     // output clk_100m
    .clk_25m    (clk_25m),     // output clk_25m
    .clk_s_90   (clk_s_90),     // output clk_s_90
    .clk_d_20   (clk_d_20),     // output clk_d_20
    // Status and control signals
    .locked     (locked),       // output locked
    // Clock in ports
    .pll_clk    (sys_clk));      // input pll_clk

endmodule
