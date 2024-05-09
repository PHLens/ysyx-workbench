module RAM #(DATA_LEN=8, ADDR_LEN=4) (
  input [DATA_LEN-1:0] in,
  input [ADDR_LEN-1:0] in_addr,
  input [ADDR_LEN-1:0] out_addr,
  input we,
  input clk,
  output reg [DATA_LEN-1:0] out
);
  reg [DATA_LEN-1:0] ram_in [2**ADDR_LEN-1:0];
  initial
  begin
    $readmemh("/workspace/ysyx-workbench/npc/mem1.txt", ram_in, 0, 2**DATA_LEN-1);
  end
  always @(posedge clk)
    if (we)
      ram_in[in_addr] <= in;

  assign out = ram_in[out_addr];
endmodule
