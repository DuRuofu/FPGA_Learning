`timescale 1ns / 1ns
module tb_dcfifo();

reg wr_clk;
reg rd_clk;
reg sys_rst_n;
reg [7:0] din;
reg wr_en;
reg rd_en;

reg full_reg0;
reg full_reg1;

wire [7:0] dout;
wire full;
wire empty;
wire [6:0] rd_data_count;
wire [7:0] wr_data_count;

reg [1:0] cnt;


// 初始化时钟
initial begin
    wr_clk = 1'b1;
    rd_clk = 1'b1;
    sys_rst_n = 1'b0;
    #20;
    sys_rst_n = 1'b1;
end

// 写时钟(50Mhz)
always begin
    #10 wr_clk = ~wr_clk;
end

// 读时钟(25Mhz)
always begin
    #20 rd_clk = ~rd_clk;
end

// 计数器逻辑
always @(posedge wr_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 2'b00;
    else if(cnt == 2'b11)
        cnt <= 2'b00;
    else
        cnt <= cnt + 1'b1;
end

// 写使能
always @(posedge wr_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        wr_en <= 1'b0;
    else if(cnt == 2'b00 && rd_en == 1'b0)
        wr_en <= 1'b1;
    else
        wr_en <= 1'b0;
end


// 写数据
always @(posedge wr_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        din <= 8'b0;
    else if(din == 8'd255 && wr_en == 1'b1)
        din <= 8'd0;
    else if(wr_en == 1'b1)
        din = din + 8'd1;
end

// 对写满信号进行同步处理
always @(posedge rd_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        full_reg0 <= 1'b0;
        full_reg1 <= 1'b0;
    end
    else begin
        full_reg0 <= full;
        full_reg1 <= full_reg0;
    end
    end

// 读使能
always @(posedge rd_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rd_en <= 1'b0;
    else if(full_reg1 == 1'b1)
        rd_en <= 1'b1;
    else if(empty == 1'b1)
        rd_en <= 1'b0;
end


// 实例化测试模块
dcfifo dcfifo(
.wr_clk         (wr_clk),
.rd_clk         (rd_clk),
.din            (din),
.wr_en          (wr_en),
.rd_en          (rd_en),

.dout           (dout),
.full           (full),
.empty          (empty),
.rd_data_count  (rd_data_count),
.wr_data_count  (wr_data_count)
    );
endmodule
