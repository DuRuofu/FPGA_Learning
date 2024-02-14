`timescale 1ns / 1ns

// 串口输入 + 缓冲
module uart_fifo_rx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire rx,         // 串口接收数据
    input wire rd_en,      // 串口输入缓冲区读取数据使能

    output wire [7:0] data_out, // 串口输入缓冲区输出数据
    output wire empty      // 串口输入缓冲区空标志
    //output wire full        // 串口输入缓冲区满标志
);

wire [7:0] data_in;
wire data_in_flag;

// 实例化UART接收模块
uart_rx
#(
    .UART_BSP(UART_BSP),   // 波特率
    .CLK_FREQ(CLK_FREQ)   // 时钟频率
)
uart_rx
(
    .sys_clk            (sys_clk),        // 系统时钟
    .sys_rst_n          (sys_rst_n),      // 系统复位信号
    .rx                 (rx),             // 串口接收数据

    .po_data            (data_in),  // 模块输出数据
    .po_flag            (data_in_flag)   // 串口接收数据完成标志
);


// 实例化FIFO
dcfifo_uart_1024x8 dcfifo_uart_1024x8_rx (
  .rst(~sys_rst_n),        // input wire rst
  .wr_clk(sys_clk),  // input wire wr_clk
  .rd_clk(sys_clk),  // input wire rd_clk
  .din(data_in),        // input wire [7 : 0] din
  .wr_en(data_in_flag),    // input wire wr_en
  .rd_en(rd_en),    // input wire rd_en

  .dout(data_out),      // output wire [7 : 0] dout
  .full(),      // output wire full
  .empty(empty)    // output wire empty
);

endmodule
