`timescale 1ns / 1ns

module uart_fifo_demo(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire rx,

    output wire tx
);

parameter UART_BSP = 115200 ; // 波特率
parameter SYS_CLK_FREQ = 50_000_000 ; // 系统时钟频率

wire [7:0] data;

wire rx_empty;
wire rx_rd_en;  
wire tx_wr_en;

// 接收缓冲区读取使能
assign rx_rd_en = !rx_empty;

// 发送缓冲区写入使能
assign tx_wr_en = !rx_empty;



// 实例化UART接收模块
uart_fifo_rx
#(
    .UART_BSP(UART_BSP),        // 波特率
    .CLK_FREQ(SYS_CLK_FREQ)   // 时钟频率
)
uart_fifo_rx
(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .rx(rx),         // 串口接收数据
    .rd_en(rx_rd_en),      // 串口输入缓冲区读取数据使能

    .data_out(data), // 串口输入缓冲区输出数据
    .empty(rx_empty)   // 串口输入缓冲区空标志
    //.full()        // 串口输入缓冲区满标志
);


// 实例化UART发送模块
uart_fifo_tx
#(
    .UART_BSP(UART_BSP),        // 波特率
    .CLK_FREQ(SYS_CLK_FREQ)   // 时钟频率
)
uart_fifo_tx
(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .data_in(data),         // 串口输出缓冲区输入数据
    .wr_en(tx_wr_en),           // 串口输出缓冲区输入数据标志(写入使能)

    //.empty(),           // 串口输出缓冲区空标志
    //.full(),            // 串口输出缓冲区满标志
    .tx(tx)               // 串口发送数据
);



endmodule
