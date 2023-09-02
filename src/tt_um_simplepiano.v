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

  // localparam SIMULTANEOUS_NOTES = 8;

  // reg note_output;

  // do decoding 12bit user_keys - > 4bit note
  // and key priority

  wire [11:0] user_keys;
  assign user_keys = {uio_in[3:0], ui_in};

  reg [3:0] note_decoded;
  always @(posedge clk) begin
    casez (user_keys)
      12'b1???_????_????: note_decoded <= 4'd0;
      12'b01??_????_????: note_decoded <= 4'd1;
      12'b001?_????_????: note_decoded <= 4'd2;
      12'b0001_????_????: note_decoded <= 4'd3;
      12'b0000_1???_????: note_decoded <= 4'd4;
      12'b0000_01??_????: note_decoded <= 4'd5;
      12'b0000_001?_????: note_decoded <= 4'd6;
      12'b0000_0001_????: note_decoded <= 4'd7;
      12'b0000_0000_1???: note_decoded <= 4'd8;
      12'b0000_0000_01??: note_decoded <= 4'd9;
      12'b0000_0000_001?: note_decoded <= 4'd10;
      12'b0000_0000_0001: note_decoded <= 4'd11;
      12'b0000_0000_0000: note_decoded <= 4'b1111;
    endcase
  end

  // // 12 nets will form an octave from
  // // the output of the tone generators
  // wire [11:0] notes;

  // // 12 notes from the 4th octave, C to B
  // // notes are calculated wrt A4 at 440Hz
  // genvar i;
  // generate
  //   for (i = 0; i < 12; i = i + 1) begin
  //     tone_gen #(
  //         .MAX_COUNT($rtoi(1000000 / (440 * $pow($pow(2, 1.0 / 12), i - 9)))),
  //         .WIDTH_COUNTER(16)
  //     ) note (
  //         .clk (clk),
  //         .rst (~rst_n),
  //         .tone(notes[i])
  //     );
  //   end
  // endgenerate


  wire note;

  wire [15:0] div;

  note_lut note_lut_dut (
      .clk(clk),
      .rstn(rst_n),
      .note(note_decoded),
      .octave(uio_in[7:4]),
      .div(div)
  );

  tone_gen #(
      .WIDTH_COUNTER(16)
  ) tone_gen_1 (
      .clk (clk),
      .rstn(rst_n),
      .div (div),
      .tone(note)
  );

  assign uo_out[7:1] = 0;

  assign uo_out[0] = (ena == 1) ? {note} : 0;
  assign uio_oe = 8'b0000_0000;
  assign uio_out = 0;

endmodule
