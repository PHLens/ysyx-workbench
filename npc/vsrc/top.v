module top(
  input [7:0] din,
  input [2:0] shamt,
  input LR,
  input AL,
  output [7:0] dout
);
  BarrelShifter bs(din, shamt, LR, AL, dout);
endmodule
