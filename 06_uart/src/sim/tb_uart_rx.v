`timescale 1ns / 1ns

module tb_uart_rx();
reg sys_clk;
reg sys_rst_n;
reg rx = 1'b1;

wire [7:0] po_data;
wire po_flag;

initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    #20
    sys_rst_n = 1'b1;
end

// 时钟信号
always #10 sys_clk = ~sys_clk;

// 测试
initial begin
    #200
    rx_bit(8'd0);
    rx_bit(8'd1);
    rx_bit(8'd2);
    rx_bit(8'd3);
    rx_bit(8'd4);
    rx_bit(8'd5);
    rx_bit(8'd6);
    rx_bit(8'd7);
end

// 引出输出



// 模拟串口数据的任务
task rx_bit (
    input [7:0] data
);

integer i;
for( i= 0 ; i<10 ; i=i+1 ) begin
    case (i)
        0: rx <= 1'b0;
        1: rx <= data[0];
        2: rx <= data[1];
        3: rx <= data[2];
        4: rx <= data[3];
        5: rx <= data[4];
        6: rx <= data[5];
        7: rx <= data[6];
        8: rx <= data[7];
        9: rx <= 1'b1;
    endcase
    #(5208*20);
    end
endtask

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

endmodule
