`default_nettype none

// This module generates a square wave with a period
// 2*MAX_COUNT times that of the input clock.

module tone_gen #(
    parameter MAX_COUNT = 5,
    parameter WIDTH_COUNTER = 10
) (
    input clk,
    input rst,
    output reg tone
);

  reg [WIDTH_COUNTER-1:0] count;

  always @(posedge clk) begin
    if (rst) begin
      count <= 0;
      tone  <= 0;
    end else if (count == (MAX_COUNT - 1)) begin
      count <= 0;
      tone  <= ~tone;
    end else begin
      count <= count + 1'b1;
    end
  end

endmodule
