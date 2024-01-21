`timescale 1ns / 1ns

module tb_dds_ctrl();

reg sys_clk;
reg sys_rst_n;
reg [3:0] wave_sel;

wire [9:0] da_data;
wire da_clk;

// 初始化时钟
initial begin
    sys_clk     = 1'b1;
    sys_rst_n   <= 1'b0;
    wave_sel    <= 4'b0000;
    #200;
    sys_rst_n <= 1'b1;
    #10000;
    wave_sel <= 4'b0001;
    #80000;
    wave_sel <= 4'b0010;
    #80000;
    wave_sel <= 4'b0100;
    #80000;
    wave_sel <= 4'b1000;
    #80000;
    wave_sel <= 4'b0001;

end

// 产生时钟(50MHz)
always #10 sys_clk = ~sys_clk;



dds_ctrl dds_ctrl(
.sys_clk        (sys_clk),
.sys_rst_n      (sys_rst_n),
.wave_sel       (wave_sel),

.dac_data       (da_data),
.dac_clk        (da_clk)
    );
endmodule
