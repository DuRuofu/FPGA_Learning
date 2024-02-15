`timescale 1ns / 1ns

// 串口输出 + 缓冲

module uart_fifo_tx
#(
    parameter UART_BSP = 'd9600,        // 波特率
    parameter CLK_FREQ = 'd50_000_000   // 时钟频率
)
(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire [7:0] data_in, // 串口输出缓冲区输入数据
    input wire wr_en,          // 串口输出缓冲区输入数据标志(写入使能)

    //output wire empty,          // 串口输出缓冲区空标志
    //output wire full,            // 串口输出缓冲区满标志
    output wire tx              // 串口发送数据
);

wire [7:0] data_out;  // 串口输出数据
wire rd_en;
wire empty;

// 缓冲区非空就使能缓冲区数据读出,并且和串口发送模块的写入使能相连
assign rd_en =!empty;

// 实例化UART发送模块
uart_tx
#(
    .UART_BSP(UART_BSP),   // 波特率
    .CLK_FREQ(CLK_FREQ)   // 时钟频率
)
uart_tx
(
    .sys_clk            (sys_clk),        
    .sys_rst_n          (sys_rst_n),      
    .pi_data            (data_out),  
    .pi_flag            (wr_en),

    .tx                 (tx)
);

// 实例化UART发送缓冲
dcfifo_uart_1024x8 dcfifo_uart_1024x8_tx (
  .rst(~sys_rst_n),        // input wire rst
  .wr_clk(sys_clk),  // input wire wr_clk
  .rd_clk(sys_clk),  // input wire rd_clk
  .din(data_in),        // input wire [7 : 0] din
  .wr_en(wr_en),    // input wire wr_en
  .rd_en(rd_en),    // input wire rd_en

  .dout(data_out),      // output wire [7 : 0] dout
  .full(),      // output wire full
  .empty(empty)    // output wire empty
);

endmodule
