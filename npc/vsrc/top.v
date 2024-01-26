module top(
  input [7:0] init,
  input clk,
  output [6:0] h,
  output [6:0] l,
  output a,
  output [7:0] o
);
  wire [7:0] out;
  LFSR lfsr(init, clk, out, a);
  bcd7seg seg1(out[7:4], h);
  bcd7seg seg2(out[3:0], l);
  assign o = out;
endmodule
