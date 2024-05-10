module top(
  input clk,
  input clrn,
  input ps2_clk,
  input ps2_data,
  output reg [6:0] out1,
  output reg [6:0] out2,
  output reg ready,
  output reg sampling,
  output reg overflow
);
  reg [7:0] tmp;
  reg nextdata_n = 1'b1;
  ps2_keyboard kb(clk, clrn, ps2_clk, ps2_data, nextdata_n, tmp, ready, sampling, overflow);
  always @(clk) begin
    if (ready == 1'b1) begin
      nextdata_n <= 1'b0;
    end
    else begin
      nextdata_n <= 1'b1;
    end
  end
  bcd7seg sg0(tmp[7:4], out1);
  bcd7seg sg1(tmp[3:0], out2);
endmodule
