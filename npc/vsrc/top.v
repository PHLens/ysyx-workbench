module top(
  input [7:0] x,
  input en,
  output reg[2:0] y,
  output reg[6:0] z,
  output reg out
);
  encoder83 encoder(x, en, y);
  bcd7seg seg(y, z);
  always @(x) begin
    if (x == 0) out = 0;
    else out = 1;
  end
endmodule
