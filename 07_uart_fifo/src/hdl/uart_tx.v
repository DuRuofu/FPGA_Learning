`timescale 1ns / 1ns
module uart_tx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire          sys_clk,        // 系统时钟
    input wire          sys_rst_n,      // 系统复位信号
    input wire   [7:0]  pi_data,        // 模块输入数据
    input wire          pi_flag,        // 串口输入数据标志

    output reg  tx             // 数据输出
);

parameter BAUD_CNT__MAX = CLK_FREQ/UART_BSP; // 波特率计数器最大值

reg         work_en;  // 工作使能
reg [15:0]  baud_cnt; // 波特计数器
reg         bit_flag; // 数据标志
reg [3:0]   bit_cnt;  // 比特计数器

// 使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        work_en <= 1'b0;
    end
    else if(pi_flag == 1'b1) begin
        work_en <= 1'b1;
    end
    else if((bit_cnt == 4'd9) && (bit_flag == 1'b1)) begin
        work_en <= 1'b0;
    end
    else 
        work_en <= work_en;
end

// 波特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        baud_cnt <= 16'd0;
    end
    // 归零条件
    else if((work_en == 1'b0) || (baud_cnt == BAUD_CNT__MAX - 1'b1)) begin
        baud_cnt <= 16'd0;
    end
    // 计数条件
    else if(work_en == 1'b1) begin
        baud_cnt <= baud_cnt + 1'b1;
    end
    else 
        baud_cnt <= baud_cnt;
end

// 比特标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        bit_flag <= 1'b0;
    end
    else if(baud_cnt == 16'b1) begin
        bit_flag <= 1'b1;
    end
    else begin
        bit_flag <= 1'b0;
    end
end

// 比特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        bit_cnt <= 4'd0;
    end
    // 归零条件
    else if((bit_flag == 1'b1) && (bit_cnt == 4'd9)) begin
        bit_cnt <= 4'd0;
    end
    // 计数条件
    else if((bit_flag == 1'b1) && (work_en == 1'b1)) begin
        bit_cnt <= bit_cnt + 1'b1;
    end
    else begin
        bit_cnt <= bit_cnt;
    end

end

// 输出信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        tx <= 1'b1; //空闲为高
    end
    else if(bit_flag == 1'b1)begin
        case(bit_cnt)
            4'd0: tx <= 1'b0; //起始位为低
            4'd1: tx <= pi_data[0];
            4'd2: tx <= pi_data[1];
            4'd3: tx <= pi_data[2];
            4'd4: tx <= pi_data[3];
            4'd5: tx <= pi_data[4];
            4'd6: tx <= pi_data[5];
            4'd7: tx <= pi_data[6];
            4'd8: tx <= pi_data[7];
            4'd9: tx <= 1'b1; //停止位为高
            default: tx <= 1'b1;
        endcase
    end
end

endmodule
