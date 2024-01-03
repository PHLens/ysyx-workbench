module MuxKey #(N_KEY = 2, KEY_LEN = 1, DATA_LEN = 1) (
  output [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [N_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);
  MuxKeyInternal #(N_KEY, KEY_LEN, DATA_LEN, 0) i0 (out, key, {DATA_LEN{1'b0}}, lut);
endmodule
