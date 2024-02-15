module da_send(
    input                 clk         ,  //系统时钟
    input                 rst_n       ,  //系统复位，低电平有效
    
    input        [9:0]    rd_data     ,  //ROM读出的数据
    output  reg  [9:0]    rd_addr     ,  //读ROM地址
    //DA接口
    output                da_clk      ,  //DA驱动时钟
    output       [9:0]    da_data        //输出给DA的数据  
    );

//parameter
//频率调节控制
parameter  FREQ_ADJ = 10'd5;  //频率调节,FREQ_ADJ的越大,最终输出的频率越低,范围0~255

//reg define
reg    [9:0]    freq_cnt  ;  //频率调节计数器

//*****************************************************
//**                    main code
//*****************************************************

//数据rd_data是在clk的上升沿更新的，所以DA芯片在clk的下降沿锁存数据是稳定的时刻
//而DA实际上在da_clk的上升沿锁存数据,所以时钟取反,这样clk的下降沿相当于da_clk的上升沿
assign  da_clk = ~clk;        
assign  da_data = rd_data;    //将读到的ROM数据赋值给DA数据端口

//频率调节计数器
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        freq_cnt <= 10'd0;
    else if(freq_cnt == FREQ_ADJ)    
        freq_cnt <= 10'd0;
    else         
        freq_cnt <= freq_cnt + 10'd1;
end

//读ROM地址
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        rd_addr <= 10'd0;
    else begin
        if(freq_cnt == FREQ_ADJ) begin
            rd_addr <= rd_addr + 10'd1;
        end    
    end            
end

endmodule