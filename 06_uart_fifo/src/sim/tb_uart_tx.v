`timescale 1ns / 1ns

module tb_uart_tx();

reg sys_clk;
reg sys_rst_n;
reg [7:0] pi_data;
reg pi_flag;

wire tx;

// 系统时钟初始化
initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    #20;
    sys_rst_n = 1'b1;
end

// 生成系统时钟
always #10 sys_clk = ~sys_clk;

// 测试序列
initial begin
    pi_data <= 8'd0;
    pi_flag <= 1'b0;
    #200;
    // 0
    pi_data <= 8'd0;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 1
    pi_data <= 8'd1;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 2
    pi_data <= 8'd2;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 3
    pi_data <= 8'd3;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 4
    pi_data <= 8'd4;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 5
    pi_data <= 8'd5;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 6
    pi_data <= 8'd6;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
    #(5208*10*20);
    // 7
    pi_data <= 8'd7;
    pi_flag <= 1'b1;
    #20;
    pi_flag <= 1'b0;
end

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
    .pi_data            (pi_data),  
    .pi_flag            (pi_flag),

    .tx                 (tx)
);
endmodule
