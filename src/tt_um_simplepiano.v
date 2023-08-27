`default_nettype none

module tt_um_simplepiano (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // 12 nets will form an octave from
  // the output of the tone generators
  wire [11:0] notes;

  // 12 notes from the 4th octave, C to B
  // notes are calculated wrt A4 at 440Hz
  genvar i;
  generate
    for (i = 0; i < 12; i = i + 1) begin
      tone_gen #(
          .MAX_COUNT(440 * $pow($pow(2, 1.0 / 12), i - 9)),
          .WIDTH_COUNTER(10)
      ) note (
          .clk (clk),
          .rst (~rst_n),
          .tone(notes[i])
      );
    end
  endgenerate

  assign uo_out = notes[7:0];
  assign uio_out[3:0] = notes[11:8];

  // set the bidir signals to output mode and drive unused wires with 0 for now
  assign uio_oe = 8'b1111_1111;
  assign uio_out[7:4] = 4'b0000;

endmodule
