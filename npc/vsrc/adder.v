module adder #(DATA_LEN = 1) (
  input [DATA_LEN-1:0] a,
  input [DATA_LEN-1:0] b,
  input cin,
  output [DATA_LEN-1:0] sum,
  output cout
);
  assign sum = a ^ b;
  assign cout = a & cin | b & cin | a & b;
endmodule
