`timescale 1ns / 1ns

module freq_meter_tb;

reg sys_clk;
reg sys_rst_n;
reg clk_test;

wire [31:0] freq;



// 重置
initial begin
    sys_clk = 0;
    sys_rst_n <= 0;
    #20; // 等待足够的时间以稳定系统
    sys_rst_n <= 1;
    clk_test =1;
end

// 时钟生成
always #10 sys_clk = ~sys_clk;


// 待测信号生成
always #50 clk_test = ~clk_test;

defparam freq_meter.freq_meter_calc_1.CNT_GATE_S_MAX = 749;
defparam freq_meter.freq_meter_calc_1.CNT_RISE_MAX = 124;

// 实例化被测模块
freq_meter freq_meter (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .clk_test(clk_test),
    .freq(freq)
);
endmodule

