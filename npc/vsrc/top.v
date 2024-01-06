module top(
  input [3:0] a,
  input [3:0] b,
  input [2:0] mode,
  output reg[3:0] sum,
  output N,
  output Z,
  output C,
  output V
);
  alu #(4)alu1(sum, N, Z, C, V, a, b, mode);
endmodule
