module alu #(DATA_LEN = 1) (
  output reg [DATA_LEN-1:0] res,
  output N,
  output Z,
  output C,
  output V,
  input [DATA_LEN-1:0] a,
  input [DATA_LEN-1:0] b,
  input [2:0] ctl
);
  wire [DATA_LEN-1:0] mux1_out;
  MuxKey #(2, 1, DATA_LEN) mux1(mux1_out, ctl[0], {
    1'b0, b,
    1'b1, ~b
  });
  wire [DATA_LEN-1:0] sum;
  wire cout;
  adder #(DATA_LEN) add(a, mux1_out, ctl[0], sum,  cout);
  wire lt, eq;
  wire sgn_a, sgn_b;
  assign sgn_a = a[DATA_LEN-1];
  assign sgn_b = b[DATA_LEN-1];
  assign lt = ~(sgn_a ^ sgn_b) ? a < b : ~(sgn_a < sgn_b); // Two's complement.
  assign eq = a == b;
  MuxKey #(8, 3, DATA_LEN) mux2(res, ctl, {
    3'b000, sum,
    3'b001, sum,
    3'b010, ~a,
    3'b011, a & b,
    3'b100, a | b,
    3'b101, a ^ b,
    3'b110, lt ? {DATA_LEN{1'b1}} : {DATA_LEN{1'b0}},
    3'b111, eq ? {DATA_LEN{1'b1}} : {DATA_LEN{1'b0}}
  });
  assign N = res[DATA_LEN-1]; // Negetive
  assign Z = ~(& res[DATA_LEN-1:0]); // Zero
  assign C = ~ctl[2] & ~ctl[1] & cout; // Cout
  assign V = ~ctl[2] & ~ctl[1]
    & ~(a[DATA_LEN-1] ^ b[DATA_LEN-1] ^ ctl[0])
    & (a[DATA_LEN-1] ^ sum[DATA_LEN-1]); // oVerflow

endmodule
