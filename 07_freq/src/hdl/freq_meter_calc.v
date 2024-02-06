`timescale 1ns / 1ns

module freq_meter_calc(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire clk_test,

    output reg [31:0] freq
    );
// 参数定义：
parameter CNT_GATE_S_MAX = 27'd74_999_999; //闸门计数器最大值(1.5s)
parameter CNT_RISE_MAX = 27'd12_500_000-1; //闸门计数器最大值(0.25s)
parameter CLK_STAND_FREQ = 27'd100_000_000; //标准参考时钟频率


// 声明变量：
reg  [26:0] cnt_gate_s; //软件闸门计数器
reg gate_s; //软件闸门标志
reg gate_a; //实际闸门标志
reg  [47:0] cnt_clk_test; //软件闸门计数器
reg gate_a_test_reg; //实际闸门标志缓冲（延时一拍）
reg  [47:0] cnt_clk_test_reg; //软件闸门计数器值

reg [47:0] cnt_clk_stand; //标准参考时钟计数器
reg gate_a_stand_reg; //实际闸门标志缓冲（延时一拍）
reg [47:0] cnt_clk_stand_reg; //标准参考时钟计数器值

reg calc_flag; //计算标志
reg calc_flag_reg; //计算标志
reg [63:0] freq_reg; //软件闸门计数器值

wire gate_a_fall_t; //实际闸门下降沿标志(test)
wire gate_a_fall_s; //实际闸门下降沿标志(stand)
wire clk_stand; //标准参考时钟


// 测量X值
// 闸门计数器：
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt_gate_s <= 27'b0;
    end
    // 清零条件
    else if(clk_test) begin
        cnt_gate_s <= 27'b0;
    end
    else if(cnt_gate_s == CNT_GATE_S_MAX) begin
            cnt_gate_s <= 27'b0;
        end
    else begin
        cnt_gate_s <= cnt_gate_s + 1;
    end
end

// 闸门标志：
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        gate_s <= 1'b0;
    end
    // 拉高
    else if((cnt_gate_s > CNT_RISE_MAX) && (cnt_gate_s <=CNT_GATE_S_MAX-CNT_RISE_MAX)) begin
        gate_s <= 1'b1;
    end
    // 拉低
    else begin
        gate_s <= 1'b0;
    end
end

// 实际闸门标志：
always @(posedge clk_test or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        gate_a <= 1'b0;
    end
    else begin
        gate_a <= gate_s;
    end
end

// 软件闸门计数器
always @(posedge clk_test or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt_clk_test <= 48'b0;
    end
    // 清零条件
    else if(gate_a == 1'b0) begin
        cnt_clk_test <= 48'b0;
    end
    // 计数条件
    else if(gate_a == 1'b1) begin
        cnt_clk_test <= cnt_clk_test + 1;
    end
    else 
        cnt_clk_test <= 48'b0;
end

// 实际闸门标志缓冲（延时一拍）
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        gate_a_test_reg <= 1'b0;
    end
    else begin
        gate_a_test_reg <= gate_a;
    end
end

// 实际闸门下降沿标志
assign gate_a_fall_t = (gate_a_test_reg == 1'b1) && (gate_a == 1'b0)?1'b1:1'b0;

// 软件闸门计数器值
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt_clk_test_reg <= 48'd0;
    end
    else if(gate_a_fall_t == 1'b1) begin
        cnt_clk_test_reg <= cnt_clk_test;
    end
end

// 测量Y值
// 实例化倍频模块,产生标准信号
clk_stand clk_stand_inst
(
// Clock out ports
.clk_out1(sys_clk),     // output clk_out1
// Status and control signals
.reset(~sys_rst_n), // input reset
// Clock in ports
.clk_in1(clk_stand));      // input clk_in1

// 标准参考时钟计数器
always @(posedge clk_stand or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt_clk_stand <= 48'd0;
    end
    else if(gate_a == 1'b0)
        cnt_clk_stand <= 48'd0;
    else if(gate_a == 1'b1) begin
        cnt_clk_stand <= cnt_clk_stand + 1;
    end    
end

// 实际闸门标志缓冲（延时一拍）
always @(posedge clk_stand or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        gate_a_stand_reg <= 1'b0;
    end
    else begin
        gate_a_stand_reg <= gate_a;
    end
end

// 实际闸门下降沿标志(stand)
assign gate_a_fall_s = (gate_a_stand_reg == 1'b1) && (gate_a == 1'b0)?1'b1:1'b0;

// 标准参考时钟计数器值
always @(posedge clk_stand or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt_clk_stand_reg <= 48'd0;
    end
    else if(gate_a_fall_s == 1'b1) begin
        cnt_clk_stand_reg <= cnt_clk_stand;
    end
end

// 频率计算标志
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        calc_flag <= 1'b0;
    end
    else if(cnt_gate_s == CNT_GATE_S_MAX) begin
        calc_flag <= 1'b1;
    end
    else begin
        calc_flag <= 1'b0;
    end
end


// 频率计算
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        freq_reg <= 32'd0;
    end
    else if(calc_flag == 1'b1) begin
        freq_reg <= (cnt_clk_test_reg * CLK_STAND_FREQ) / cnt_clk_stand_reg;
    end
end

// 计算标志信号缓冲
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        calc_flag_reg <= 1'b0;
    end
    else begin
        calc_flag_reg <= calc_flag;
    end
end

// 输出频率
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        freq <= 32'd0;
    end
    else if(calc_flag_reg == 1'b1) begin
        freq <= freq_reg[31:0];
    end
end

endmodule
