module ShiftRegister #(DATA_LEN = 8) (
  input [DATA_LEN-1:0] Q,
  input a,
  input [2:0] ctrl,
  input clk,
  output reg [DATA_LEN-1:0] out
);
  always @(posedge clk)
    case(ctrl)
      3'b000: out <= 0;              // set zero.
      3'b001: out <= Q;              // set num.
      3'b010: out <= {1'b0, Q[DATA_LEN-1:1]}; // Logic Right shift.
      3'b011: out <= {Q[DATA_LEN-2:0], 1'b0}; // Logic Left shift.
      3'b100: out <= {Q[DATA_LEN-1], Q[DATA_LEN-1:1]}; // Arithmetic Right shift.
      3'b101: out <= {a, Q[DATA_LEN-1:1]};    // a is define by user.
      3'b110: out <= {Q[0], Q[DATA_LEN-1:1]}; // Rotate Right shift.
      3'b111: out <= {Q[6:0], Q[DATA_LEN-1]}; // Rotate Left shift.
    endcase
endmodule
