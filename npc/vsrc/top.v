module top(
  input clk,
  input reset,
  input in,
  output out
);
  FSMs fsm(clk, reset, in, out);
endmodule
