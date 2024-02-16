`timescale 1ns / 1ns

module i2c_eeprom(
	input   wire    sys_clk     ,   // 系统时钟50Mhz
	input   wire    sys_rst_n   ,   // 全局复位
	input   wire    key_wr      ,   // 按键信号:写
	input   wire    key_rd       ,  // 按键信号:读

	output  wire    tx              // 串口发送数据
    );

parameter UART_BSP = 115200 ; // 串口波特率
parameter SYS_CLK_FREQ = 50_000_000 ; // 系统时钟频率

wire key_flag_wr; // 按键消抖后的信号:写
wire key_flag_rd; // 按键消抖后的信号:读

reg [7:0] data; // 串口输出缓冲输入数据
reg tx_wr_en;   // 串口输出缓冲区写入使能

// 写按键按下
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        //key_flag_wr <= 0;
    end 
	else if(key_flag_wr == 1'b1) begin
		data <= 8'd31;
		tx_wr_en <= 1'b1;
	end
	else begin
		tx_wr_en <= 1'b0;
	end
end

// 读按键按下
// always @(posedge sys_clk or negedge sys_rst_n) begin
// 	if (!sys_rst_n) begin
// 		//key_flag_rd <= 0;
// 	end 
// 	else if(key_flag_rd == 1'b1) begin
// 		data <= 8'd2;
// 		tx_wr_en <= 1'b1;
// 	end
// 	else begin
// 		data <= 8'd0;
// 		tx_wr_en <= 1'b0;
// 	end
// end


// 例化按键消抖模块
key_filter key_filter_0
(
    .sys_clk    (sys_clk    ),  //input     sys_clk
    .sys_rst_n  (sys_rst_n  ),  //input     sys_rst_n
    .key_in     (key_wr     ),  //input     key_in
                        
    .key_flag   (key_flag_wr   )   //output    key_flag
);

key_filter key_filter_1
(
    .sys_clk    (sys_clk    ),  //input     sys_clk
    .sys_rst_n  (sys_rst_n  ),  //input     sys_rst_n
    .key_in     (key_rd     ),  //input     key_in
                        
    .key_flag   (key_flag_rd   )   //output    key_flag
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
    .wr_en(tx_wr_en),       // 串口输出缓冲区输入数据标志(写入使能)

    .tx(tx)                 // 串口发送数据
);

endmodule

//  按键测试：每次按键按下时，就翻转蜂鸣器的状态 
//  always @ (posedge sys_clk or negedge sys_rst_n) begin 
// 	 if(!sys_rst_n) 
// 	 beep <= 1'b1; 
// 	 else if(key_flag_wr) //有效的一次按键被按下 
//  beep <= ~beep; 
//  else 
//  beep <= beep; 
//  end
