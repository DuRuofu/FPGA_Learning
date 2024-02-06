`timescale 1ns / 1ns

module freq_meter(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire clk_test,

    output wire [31:0] freq
    );

// 实例化频率测量模块
freq_meter_calc freq_meter_calc_1(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .clk_test(clk_test),

    .freq(freq)
    );
endmodule
