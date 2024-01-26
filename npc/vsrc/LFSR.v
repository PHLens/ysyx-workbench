/*
  Linear-feedback shift register.
*/
module LFSR #(DATA_LEN = 8) (
  input [DATA_LEN-1:0] in,
  input clk,
  output [DATA_LEN-1:0] out,
  output a_out
);
  reg all_zero = ~(| in[DATA_LEN-1:0]);
  reg a = in[4] ^ in[3] ^ in[2] ^ in[0];
  reg [DATA_LEN-1:0] tmp = all_zero ? {in[DATA_LEN-1:1], 1'b1} : in; // handle all zero case.
  always @(posedge clk) begin
    a <= tmp[4] ^ tmp[3] ^ tmp[2] ^ tmp[0];
    tmp <= {a, tmp[DATA_LEN-1:1]};
  end
  ShiftRegister r0(tmp, a, 3'b101, clk, out);
  assign a_out = a;
endmodule
