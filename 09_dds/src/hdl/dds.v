
// 顶层DDS模块
module dds(
input wire              sys_clk,
input wire              sys_rst_n,
input wire [3:0]        key,

output wire [9:0]       dac_data,
output wire             dac_clk
    );

wire [3:0] wave_sel;


// 实例化按键控制
key_ctrl key_ctrl_0(
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    .key            (key),

    // 波形选择信号
    .wave_sel       (wave_sel)    
);

// 实例化dds控制
dds_ctrl dds_ctrl_0(
.sys_clk        (sys_clk),
.sys_rst_n      (sys_rst_n),
.wave_sel       (wave_sel),

.dac_data       (dac_data),
.dac_clk        (dac_clk)
    );

endmodule
