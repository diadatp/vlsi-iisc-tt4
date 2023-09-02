`default_nettype none

// This module generates a square wave with a period
// 2*div times that of the input clock.

module tone_gen #(
    parameter WIDTH_COUNTER = 10
) (
    input clk,
    input rstn,
    input [WIDTH_COUNTER-1:0] div,
    output reg tone
);

  reg [WIDTH_COUNTER-1:0] div_hold;
  always @(posedge clk) begin
    if (!rstn) begin
      div_hold <= 0;
    end else begin
      div_hold <= div;
    end
  end

  reg [WIDTH_COUNTER-1:0] count;

  always @(posedge clk) begin
    if (!rstn) begin
      count <= 0;
      tone  <= 0;
    end else if (div !== div_hold) begin
      count <= 1;
    end else if (div == 0) begin
      count <= 1;
      tone  <= 0;
    end else if (count == div) begin
      count <= 1;
      tone  <= ~tone;
    end else begin
      count <= count + 1'b1;
    end
  end

endmodule
