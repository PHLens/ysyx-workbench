module mux4to1(
  input [1:0] Y,
  input [1:0] X0,
  input [1:0] X1,
  input [1:0] X2,
  input [1:0] X3,
  output reg[1:0] F
);
  wire tmp1, tmp2, tmp3, tmp4;
  assign tmp1 = ~Y[0] & ~Y[1];
  assign tmp2 = ~Y[0] & Y[1];
  assign tmp3 = Y[0] & ~Y[1];
  assign tmp4 = Y[0] & Y[1];
  always @(*) begin
    if (tmp1) F = X0;
    else if (tmp2) F = X1;
    else if (tmp3) F = X2;
    else if (tmp4) F = X3;
    else F = '0;
  end
endmodule
