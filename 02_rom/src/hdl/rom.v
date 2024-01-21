
// 调用ip核

module rom(
    input   wire    sys_clk,
    input   wire    [7:0] addr,
    output  wire    [7:0] dout
    );

rom_8x256 rom_8x256 (
  .clka     (sys_clk),    // input wire clka
  .addra    (addr),  // input wire [7 : 0] addra
  .douta    (dout)  // output wire [7 : 0] douta
);



endmodule
