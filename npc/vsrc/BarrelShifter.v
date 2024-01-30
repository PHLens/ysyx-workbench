module BarrelShifter #(SHAMT_LEN = 3, DATA_LEN = 2 ** SHAMT_LEN) (
  input [DATA_LEN-1:0] din,
  input [SHAMT_LEN-1:0] shamt,
  input LR,
  input AL,
  output [DATA_LEN-1:0] dout
);
  localparam TMP_LEN = (SHAMT_LEN - 1) * DATA_LEN;
  wire sgn;
  wire tmp [TMP_LEN - 1:0];
  MuxKey #(2, 1, 1) mux(sgn, AL, {
    1'b0, 1'b0,    // logic shift
    1'b1, din[DATA_LEN-1]  // arithmetic shift
  });
  genvar i, j;
  generate
    for (i = 0; i < DATA_LEN; i = i + 1) begin: outter
      // // whether shift 1 bit.
      // MuxKey #(4, 2, 1) mux0 (tmp[i * (SHAMT_LEN - 1)], {LR, shamt[0]}, {
      //   2'b00, din[i],  // no shift
      //   2'b01, i + 1 < DATA_LEN ? din[i + 1] : sgn,  // Right shift
      //   2'b10, din[i],  // no shift
      //   2'b11, i - 1 >= 0 ? din[i - 1] : 1'b0     // Left shift
      // });
      // // whether shift 2 bit.
      // MuxKey #(4, 2, 1) mux1 (tmp[i * (SHAMT_LEN - 1) + 1], {LR, shamt[1]}, {
      //   2'b00, tmp[i * (SHAMT_LEN - 1)],  // no shift
      //   2'b01, i + 2 < DATA_LEN ? tmp[(i + 2) * (SHAMT_LEN - 1)] : sgn,  // Right shift
      //   2'b10, tmp[i * (SHAMT_LEN - 1)],  // no shift
      //   2'b11, i - 2 >= 0 ? tmp[(i - 2) * (SHAMT_LEN - 1)] : 1'b0     // Left shift
      // });
      // // whether shift 4 bit.
      // MuxKey #(4, 2, 1) mux2 (dout[i], {LR, shamt[2]}, {
      //   2'b00, tmp[i * (SHAMT_LEN - 1) + 1],  // no shift
      //   2'b01, i + 4 < DATA_LEN ? tmp[(i + 4) * (SHAMT_LEN - 1) + 1] : sgn,  // Right shift
      //   2'b10, tmp[i * (SHAMT_LEN - 1) + 1],  // no shift
      //   2'b11, i - 4 >= 0 ? tmp[(i - 4) * (SHAMT_LEN - 1) + 1] : 1'b0     // Left shift
      // });
      for (j = 0; j < SHAMT_LEN - 1; j = j + 1) begin: inner
        if (j == 0) begin: if_gen  // first mux's input is din[i].
          // whether shift 1 bit.
          MuxKey #(4, 2, 1) mux (tmp[i * (SHAMT_LEN - 1)], {LR, shamt[0]}, {
            2'b00, din[i],  // no shift
            2'b01, i + 1 < DATA_LEN ? din[i + 1] : sgn,  // Right shift
            2'b10, din[i],  // no shift
            2'b11, i - 1 >= 0 ? din[i - 1] : 1'b0     // Left shift
          });
        end
        else begin: elseif_gen  // inner mux connect to tmp[j].
          // whether shift 2**j bit. (0 < j < SHAMT_LEN - 1)
          MuxKey #(4, 2, 1) mux (tmp[i * (SHAMT_LEN - 1) + j], {LR, shamt[j]}, {
            2'b00, tmp[i * (SHAMT_LEN - 1) + j - 1],  // no shift
            2'b01, i + 2**j < DATA_LEN ? tmp[(i + 2**j) * (SHAMT_LEN - 1)] : sgn,  // Right shift
            2'b10, tmp[i * (SHAMT_LEN - 1) + j - 1],  // no shift
            2'b11, i - 2**j >= 0 ? tmp[(i - 2**j) * (SHAMT_LEN - 1)] : 1'b0     // Left shift
          });
        end
      end
      begin: last_gen  // the last mux output connect to dout[i].
        // j = SHAMT_LEN - 1
        // no shift: tmp[i * (SHAMT_LEN - 1) + j - 1]
        // Right shift: i + 2**j < DATA_LEN ? tmp[(i + 2**j) * (SHAMT_LEN - 1) + j - 1]
        // Left shift: i - 2**j >= 0 ? tmp[(i - 2**j) * (SHAMT_LEN - 1) + j - 1]
        MuxKey #(4, 2, 1) mux (dout[i], {LR, shamt[SHAMT_LEN - 1]}, {
          2'b00, tmp[i * (SHAMT_LEN - 1) + SHAMT_LEN-1 - 1],  // no shift
          2'b01, i + 2**(SHAMT_LEN-1) < DATA_LEN ? tmp[(i + 2**(SHAMT_LEN-1)) * (SHAMT_LEN - 1) + SHAMT_LEN-1 - 1] : sgn,  // Right shift
          2'b10, tmp[i * (SHAMT_LEN - 1) + SHAMT_LEN-1 - 1],  // no shift
          2'b11, i - 2**(SHAMT_LEN-1) >= 0 ? tmp[(i - 2**(SHAMT_LEN-1)) * (SHAMT_LEN - 1) + SHAMT_LEN-1 - 1] : 1'b0     // Left shift
        });
      end
    end
  endgenerate
endmodule
