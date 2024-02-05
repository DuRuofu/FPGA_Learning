`timescale 1ns / 1ns

module rs232(
    input wire sys_clk,
    input wire sys_rst_n,
    input wire rx,

    output wire tx
);


wire [7:0] po_data;
wire po_flag;


// 实例化UART接收模块
uart_rx
#(
    .UART_BSP(9600),   // 波特率
    .CLK_FREQ(50_000_000)   // 时钟频率
)
uart_rx_inst
(
    .sys_clk            (sys_clk),        // 系统时钟
    .sys_rst_n          (sys_rst_n),      // 系统复位信号
    .rx                 (rx),             // 串口接收数据

    .po_data            (po_data),  // 模块输出数据
    .po_flag            (po_flag)   // 串口接收数据完成标志
);
// 实例化UART发送模块
uart_tx
#(
    .UART_BSP(9600),   // 波特率
    .CLK_FREQ(50_000_000)   // 时钟频率
)
uart_tx_inst
(
    .sys_clk            (sys_clk),        
    .sys_rst_n          (sys_rst_n),      
    .pi_data            (po_data),  
    .pi_flag            (po_flag),

    .tx                 (tx)
);

endmodule
