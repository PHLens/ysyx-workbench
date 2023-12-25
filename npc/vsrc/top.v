module top(
  input [1:0] Y,
  input [1:0] X0,
  input [1:0] X1,
  input [1:0] X2,
  input [1:0] X3,
  output reg[1:0] F
);
  mux4to1 mux(Y, X0, X1, X2, X3, F);
endmodule
