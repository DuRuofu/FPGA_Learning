
module dds_ctrl(
input wire sys_clk,
input wire sys_rst_n,
input wire [3:0] wave_sel,

output wire [9:0] dac_data,
output wire  dac_clk
    );

wire clk_125m; //倍频时钟
reg [31:0] fre_add;
reg [11:0] rom_addr_reg;//相位调制后的相位码
reg [13:0] rom_addr;//相位累加器


//频率调节控制字
parameter  F_WORD = 32'd32949;  //频率调节,F_WORD的越大,最终输出的频率越低
//相位调节控制字
parameter  P_WORD = 12'd1024;//相位偏移量

//数据rd_data是在clk的上升沿更新的，所以DA芯片在clk的下降沿锁存数据是稳定的时刻
//而DA实际上在da_clk的上升沿锁存数据,所以时钟取反,这样clk的下降沿相当于da_clk的上升沿
assign  dac_clk = ~clk_125m;        
//assign  dac_data = rd_data;    //将读到的ROM数据赋值给DA数据端口



// 相位累加器
always @(posedge clk_125m or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0)
        fre_add <= 32'b0;
    else begin
        fre_add <= fre_add + F_WORD;
    end
end

// rom地址寄存器(要取数据的地址，不加偏移量)
always @(posedge clk_125m or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0)
        rom_addr_reg <= 12'b0;
    else begin
        // 相位累加器高12位加上相位偏移量
        rom_addr_reg <= fre_add[31:20] + P_WORD;
    end
end


// rom地址寄存器(要取数据的地址，加上偏移量)
always @(posedge clk_125m or negedge sys_rst_n) begin
    if(sys_rst_n == 1'b0)
        rom_addr <= 14'b0;
    //根据不同波形计算偏移
    else begin
        case (wave_sel)
            4'b0001: rom_addr <= rom_addr_reg ; // 正弦波
            4'b0010: rom_addr <= rom_addr_reg + 14'd4096; // 方波
            4'b0100: rom_addr <= rom_addr_reg + 14'd8192; // 三角波
            4'b1000: rom_addr <= rom_addr_reg + 14'd12288; // 锯齿波
            default: rom_addr <= rom_addr_reg ;
        endcase
    end

end


// 实例化PLL倍频时钟
clk_pll_125m clk_pll_125m_01
   (
    .clk_out(clk_125m),     // output clk_out
    .clk_in(sys_clk));      // input clk_in


// rom模块
rom_16384x10b rom_16384x10b_01 (
  .clka(clk_125m),    // input wire clka
  .addra(rom_addr),  // input wire [13 : 0] addra
  .douta(dac_data)  // output wire [9 : 0] douta
);

endmodule
