module ps2_keyboard(
  input clk, clrn, ps2_clk, ps2_data,
  input nextdata_n,
  output [7:0] data,
  output reg ready,
  output reg sampling_out,
  output reg overflow
);
  // internal signal
  reg [9:0] buffer;       // ps2_data bits
  reg [7:0] fifo[7:0];    // data fifo
  reg [2:0] w_ptr, r_ptr; // fifo write/read pointers
  reg [3:0] count;        // count ps2_data bits

  // record ps2_clk history and detect falling edge of ps2_clk
  reg [2:0] ps2_clk_sync;

  always @(posedge clk) begin
    ps2_clk_sync <= {ps2_clk_sync[1:0], ps2_clk};
  end

  wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1]; // detect falling edge

  assign sampling_out = sampling;
  always @(posedge clk) begin
    if (clrn == 0) begin // reset
      count <= 0; w_ptr <= 0; r_ptr <= 0; overflow <= 0; ready <= 0;
    end
    else begin
      if (ready) begin // ready to output next data
        if (nextdata_n == 1'b0) begin  // start bit '0'
          r_ptr <= r_ptr + 3'b1;
          if (w_ptr == (r_ptr + 1'b1)) // empty
            ready <= 1'b0;
        end
      end
      if (sampling) begin
        if (count == 4'd10) begin  // reach data length, check for valid data
          if ((buffer[0] == 0) &&  // start bit '0'
              (ps2_data) &&        // stop bit '1'
              (^buffer[9:1])) begin    // odd parity
            fifo[w_ptr] <= buffer[8:1];
            w_ptr <= w_ptr + 3'b1;
            ready <= 1'b1;
            overflow <= overflow | (r_ptr == (w_ptr + 3'b1));
          end
          count <= 0;  // for next
        end
        else begin
          buffer[count] <= ps2_data; // cache ps2_data
          count <= count + 3'b1;
        end
      end
    end
  end
  assign data = fifo[r_ptr]; // set output data

endmodule
