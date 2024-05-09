module top(
  input clk,
  //input we,
  input [7:0] in,
  input [3:0] in_addr,
  input [3:0] out_addr,
  output reg [6:0] out1,
  output reg [6:0] out2
);
  reg [7:0] tmp;
  RAM ram(in, in_addr, out_addr, 1, clk, tmp);
  bcd7seg sg0(tmp[7:4], out1);
  bcd7seg sg1(tmp[3:0], out2);
endmodule
