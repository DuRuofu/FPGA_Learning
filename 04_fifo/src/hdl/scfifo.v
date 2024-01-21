
module scfifo(
input wire sys_clk,
input wire sys_rst_n,
input wire [7:0] din,
input wire wr_en,
input wire rd_en,

output wire [7:0] dout,
output wire full,
output wire empty,
output wire [7:0] data_count
    );


scfifo_8x256 scfifo_8x256 (
  .clk(sys_clk),                // input wire clk
  .srst(~sys_rst_n),              // input wire srst
  .din(din),                // input wire [7 : 0] din
  .wr_en(wr_en),            // input wire wr_en
  .rd_en(rd_en),            // input wire rd_en
  .dout(dout),              // output wire [7 : 0] dout
  .full(full),              // output wire full
  .empty(empty),            // output wire empty
  .data_count(data_count)  // output wire [7 : 0] data_count
);

endmodule
