`timescale 1ns / 1ns


module tb_rom();

reg sys_clk;
reg sys_rst_n;
reg [7:0] addr;
wire [7:0] dout;

initial begin
    sys_clk = 1'b1;
    sys_rst_n <= 1'b0;
    #20;
    sys_rst_n <= 1'b1;
end

always #10 sys_clk = ~sys_clk;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        addr <= 8'b0;
    end
    else if(addr == 8'd255) begin
        addr <= 8'b0;
    end
    else begin
        addr <= addr + 1'b1;
    end
end

rom rom(
    .sys_clk(sys_clk),
    .addr(addr),
    .dout(dout)
    );
endmodule
