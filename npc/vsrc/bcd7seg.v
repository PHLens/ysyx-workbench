module bcd7seg(
  input [2:0] b,
  output reg [6:0] h
);
  always @(b)
    case(b)
      3'h0: h = 7'b0000001;
      3'h1: h = 7'b1001111;
      3'h2: h = 7'b0010010;
      3'h3: h = 7'b0000110;
      3'h4: h = 7'b1001100;
      3'h5: h = 7'b0100100;
      3'h6: h = 7'b0100000;
      3'h7: h = 7'b0001111;
      default: h = 7'b0000001;
    endcase
endmodule
