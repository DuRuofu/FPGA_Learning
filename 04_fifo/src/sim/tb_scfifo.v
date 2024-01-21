`timescale 1ns / 1ns

module tb_scfifo();
// 定义信号
reg sys_clk;
reg sys_rst_n;
reg [7:0] din;
reg wr_en;
reg rd_en;
wire [7:0] dout;
wire full;
wire empty;
wire [7:0] data_count;

reg [1:0] cnt;



// 初始化时钟
initial begin
    sys_clk = 1'b0;
    sys_rst_n <= 1'b0;
    #20
    sys_rst_n <= 1'b1;
end
always #10 sys_clk = ~sys_clk;

// 计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        cnt <= 2'b0;
    end
    else if(cnt == 2'd3)begin
        cnt <= 2'b0;
    end
    else begin
        cnt <= cnt + 1'b1;
    end
    end 
    
//写使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        wr_en <= 1'b0;
    end
    else if(cnt == 2'd0 && rd_en == 1'b0)begin
        wr_en <= 1'b1;
    end
    else begin
        wr_en <= 1'b0;
    end
    end

// 写数据
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        din <= 8'b0;
    end
    else if(din == 8'd255 && wr_en == 1'b1)begin
        din <= 8'b0;
    end
    else if(wr_en == 1'b1) begin
        din <= din + 8'b1;
    end
    end

// 读使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        rd_en <= 1'b0;
    end
    //数据写满
    else if(full == 1'b1)begin
        rd_en <= 1'b1;
    end
    //数据未写满
    else if(empty == 1'b1)begin
        rd_en <= 1'b0;
    end
    end

// 实例化待测模块
scfifo scfifo(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .din(din),
    .wr_en(wr_en),
    .rd_en(rd_en),

    .dout(dout),
    .full(full),
    .empty(empty),
    .data_count(data_count)
    );

endmodule
