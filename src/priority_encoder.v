`default_nettype none

module priority_encoder #(
    parameter INPUTS = 3,
    parameter OUT_WIDTH = $clog2(INPUTS)
) (
    input wire [INPUTS-1:0] in,
    output reg [INPUTS-1:0] in_mask,
    output reg [OUT_WIDTH-1:0] out
);

  // Loop from lsb up to msb and at each bit that is
  // set, output the encoded value for that bit.

  // The last assignment to out wins. Combined
  // with the fact that the loop starts at lsb and
  // goes up to msb, the highest non zero index wins

  // note: this structure may not be synthesizable
  // in other tools. Yosys seems to accept it.

  reg [3:0] i;
  always @* begin
    out = 0;
    in_mask = in;
    for (i = 0; i < INPUTS; i = i + 1) begin
      if (in[i]) begin
        in_mask = in & ~(1 << i);
        out = (INPUTS - 1 - i);
        // out = {OUT_WIDTH{1'b0}} | (INPUTS - 1 - i);
      end
    end
  end

endmodule
