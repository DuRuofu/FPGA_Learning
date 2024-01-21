

module ram(
input wire wr_en,
input wire [7:0] addr,
input wire sys_clk,
input wire [7:0] din,
output wire [7:0] dout
    );

s_ram_8x256 ram_8x256 (
  .clka(sys_clk),    // input wire clka
  .wea(wr_en),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [7 : 0] addra
  .dina(din),    // input wire [7 : 0] dina
  .douta(dout)  // output wire [7 : 0] douta
);

endmodule
