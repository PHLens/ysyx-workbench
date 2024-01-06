module adder #(DATA_LEN = 1) (
  input [DATA_LEN-1:0] a,
  input [DATA_LEN-1:0] b,
  input cin,
  output [DATA_LEN-1:0] sum,
  output cout
);
  assign {cout, sum} = a + b + { {DATA_LEN-1{1'b0}}, cin};
endmodule
