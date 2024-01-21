`timescale 1ns / 1ns

module tb_ram();

reg sys_clk;
reg sys_rst_n;
reg wr_en;
reg [7:0] addr;
reg wr_flag;


wire [7:0] din;
wire [7:0] dout;


// 初始化时钟
initial begin
    sys_clk = 1'b1;
    sys_rst_n <= 1'b0;
    #20;
    sys_rst_n <= 1'b1;
end

// 时钟周期
always #10 sys_clk = ~sys_clk;


//写标志
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0 ) begin
        wr_flag <= 1'b0;
    end
    else if(addr == 8'd255) begin
        wr_flag <= 1'b1;
    end
    else begin
        wr_flag <= wr_flag;
    end
end


// 写信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0 ) begin
        wr_en <= 1'b0;
    end
    else if(wr_flag == 1'b1) begin
        wr_en <= 1'b0;
    end
    else begin
        wr_en <= 1'b1;
    end
end


// 地址信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0 ) begin
        addr <= 8'd0;
    end
    else if(addr == 8'd255) begin
        addr <= 8'd0;
    end
    else begin
        addr <= addr + 1'b1;
    end
end

//写数据
assign  din = (wr_en == 1'b1) ? addr : 8'd0;

ram ram1(
    .sys_clk(sys_clk),
    .wr_en(wr_en),
    .addr(addr),
    .din(din),
    .dout(dout)
    );
endmodule
