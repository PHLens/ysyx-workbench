module encoder83(
  input [7:0] h,
  input en,
  output reg [2:0] out
);
  int i;
  always @(h or en) begin
    if (en) begin
      out = 0;
      for (i = 0; i <= 7; i = i + 1) begin
          if (h[i] == 1) out = i[2:0];
      end
    end
    else out = 0;
  end
endmodule
