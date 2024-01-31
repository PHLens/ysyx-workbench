module ResetFF #(DATA_LEN = 1) (
  input clk,
  input reset,
  input [DATA_LEN - 1:0] state_in,
  output reg [DATA_LEN - 1:0] state_out
);
  always @(posedge clk) begin
    if (reset) state_out <= 0;
    else state_out <= state_in;
  end
endmodule
