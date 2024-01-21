
module dcfifo(
input wire wr_clk,
input wire rd_clk,
input wire [7:0] din,
input wire wr_en,
input wire rd_en,

output wire [15:0] dout,
output wire full,
output wire empty,
output wire [6:0] rd_data_count,
output wire [7:0] wr_data_count
    );

dcfifo_8x256_to_16x128  dcfifo(
  .wr_clk(wr_clk),                // input wire wr_clk
  .rd_clk(rd_clk),                // input wire rd_clk
  .din(din),                      // input wire [7 : 0] din
  .wr_en(wr_en),                  // input wire wr_en
  .rd_en(rd_en),                  // input wire rd_en
  .dout(dout),                    // output wire [15 : 0] dout
  .full(full),                    // output wire full
  .empty(empty),                  // output wire empty
  .rd_data_count(rd_data_count),  // output wire [6 : 0] rd_data_count
  .wr_data_count(wr_data_count)  // output wire [7 : 0] wr_data_count
);


endmodule
