`timescale 1ns / 1ns

// 串口接收模块
module uart_rx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire  sys_clk,        // 系统时钟
    input wire  sys_rst_n,      // 系统复位信号
    input wire  rx,             // 串口接收数据

    output reg [7:0] po_data,  // 模块输出数据
    output reg       po_flag   // 串口接收数据完成标志
);

parameter BAUD_CNT__MAX = CLK_FREQ/UART_BSP; // 波特率计数器最大值

// 中间变量
reg rx_reg_1;       // 用于同步数据
reg rx_reg_2;       // 用于缓冲数据
reg rx_reg_3;       // 用于缓冲数据
reg start_flag;     // 用于判断起始位
reg work_en;        // 用于使能接收模块
reg [15:0] baud_cnt;// 用于计数波特率
reg bit_flag;       // 读取标志
reg [3:0] bit_cnt;  // 读取位数计数
reg [7:0] rx_data;  // 读取到的数据
reg rx_flag ;       // 读取完成标志

// 对输入信号进行同步
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_reg_1 <= 1'b1;  // 初值为1
    end
   else begin
        rx_reg_1 <= rx;
    end
end

// 用于同步数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_reg_2 <= 1'b1;  // 初值为1
    end
   else begin
        rx_reg_2 <= rx_reg_1;
    end
end

// 用于同步数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_reg_3 <= 1'b1;  // 初值为1
    end
   else begin
        rx_reg_3 <= rx_reg_2;
    end
end

// 开始标志信号 start_flag
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       start_flag <= 1'b0;  // 初值为0
    end
    else if((rx_reg_3 == 1'b1) && (rx_reg_2== 1'b0) && (work_en == 1'b0)) begin
        start_flag <= 1'b1;
    end
    else begin
        start_flag <= 1'b0;
    end
end

// 使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       work_en <= 1'b0;  // 初值为0
    end
    // 开始接收拉高
    else if(start_flag == 1'b1) begin
        work_en <= 1'b1;
    end
    // 接收结束拉低(比特计数器为8，且读取标志为高)
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
        work_en <= 1'b0;
    end
    else begin
        work_en <= work_en;
    end
end

// 波特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       baud_cnt <= 1'b0;  // 初值为0
    end
    // 归零条件
    else if((baud_cnt == BAUD_CNT__MAX - 1'b1) || (work_en == 1'b0) ) begin
        baud_cnt <= 16'b0;
    end
    // 波特计数器递增
    else if (work_en == 1'b1) begin
        baud_cnt <= baud_cnt + 1'b1;
    end
    else begin
        baud_cnt <= baud_cnt;
    end
end

// 比特标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       bit_flag <= 1'b0;  // 初值为0
    end
    // 波特计数器达到波特率的一半时，比特标志拉高
    else if(baud_cnt == BAUD_CNT__MAX/2 - 1'b1) begin
        bit_flag <= 1'b1;
    end
    else begin
        bit_flag <= 1'b0;
    end
end

// 比特计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       bit_cnt <= 4'b0;  // 初值为0
    end
    // 归零条件
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
        bit_cnt <= 4'b0;
    end
    // 比特计数器递增
    else if (bit_flag == 1'b1) begin
        bit_cnt <= bit_cnt + 1'b1;
    end
    else begin
        bit_cnt <= bit_cnt;
    end
end

// 数据拼接
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_data <= 8'd0;  // 初值为0
        end
    // 数据拼接(串行转并行数据)
    else if((bit_cnt >= 4'd1) && (bit_cnt <= 4'd8) && (bit_flag == 1'b1)) begin
        rx_data <= {rx_reg_3, rx_data[7:1]};
    end
    else begin
        rx_data <= rx_data;
    end
end

// rx标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       rx_flag <= 1'b0;  // 初值为0
    end
    else if((bit_cnt == 4'd8) && (bit_flag == 1'b1)) begin
        rx_flag <= 1'b1;
    end   
    else begin
        rx_flag <= 1'b0;
    end
end

// 输出数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       po_data <= 8'd0;  // 初值为0
    end
    else if(rx_flag == 1'b1) begin
        po_data <= rx_data;
    end
    else begin
        po_data <= po_data;
    end
end

// 输出标志信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
       po_flag <= 1'b0;  // 初值为0
    end
    else begin
        po_flag <= rx_flag;
    end
end
endmodule
