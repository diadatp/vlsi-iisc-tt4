`default_nettype none

module multi_stage_priority_encoder #(
    parameter INPUTS = 12,
    parameter STAGES = 7
) (
    input wire [INPUTS-1:0] in,
    output reg [($clog2(INPUTS)*STAGES)-1:0] out
);

  localparam WIDTH_OUT = $clog2(INPUTS);

  wire [INPUTS-1:0] in_stage[STAGES:0];

  assign in_stage[0] = in;

  generate
    genvar i;
    for (i = 0; i < STAGES; i = i + 1) begin
      priority_encoder #(
          .INPUTS(INPUTS)
      ) priority_encoder_dut (
          .in(in_stage[i]),
          .in_mask(in_stage[i+1]),
          .out(out[((i+1)*WIDTH_OUT-1):(i*WIDTH_OUT)])
      );
    end
  endgenerate

endmodule
