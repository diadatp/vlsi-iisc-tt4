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

  // 12 piano keys
  wire [11:0] user_keys;
  assign user_keys = {uio_in[3:0], ui_in};

  // octave selection
  wire [3:0] user_octave;
  assign user_octave = {1'b0, uio_in[6:4]};

  // mode selection where piano = 0, demo = 1
  wire mode;
  assign mode = uio_in[7];

  // priority encoding 12bit user_keys - > 4bit note
  // special value for no key press

  reg [3:0] note_encoded;
  always @(posedge clk) begin
    casez (user_keys)
      12'b1???_????_????: note_encoded <= 4'd0;
      12'b01??_????_????: note_encoded <= 4'd1;
      12'b001?_????_????: note_encoded <= 4'd2;
      12'b0001_????_????: note_encoded <= 4'd3;
      12'b0000_1???_????: note_encoded <= 4'd4;
      12'b0000_01??_????: note_encoded <= 4'd5;
      12'b0000_001?_????: note_encoded <= 4'd6;
      12'b0000_0001_????: note_encoded <= 4'd7;
      12'b0000_0000_1???: note_encoded <= 4'd8;
      12'b0000_0000_01??: note_encoded <= 4'd9;
      12'b0000_0000_001?: note_encoded <= 4'd10;
      12'b0000_0000_0001: note_encoded <= 4'd11;
      12'b0000_0000_0000: note_encoded <= 4'b1111;
    endcase
  end

  wire [3:0] octave_rtttl;
  wire [3:0] note_rtttl;
  rtttl_sequencer rtttl_sequencer_dut (
      .clk(clk),
      .rstn(rst_n),
      .start(mode),
      .octave(octave_rtttl),
      .note(note_rtttl)
  );

  wire [3:0] note_sel;
  assign note_sel = (mode == 0) ? note_encoded : note_rtttl;

  wire [3:0] octave_sel;
  assign octave_sel = (mode == 0) ? user_octave : octave_rtttl;

  wire [15:0] div;
  note_lut note_lut_dut (
      .clk(clk),
      .rstn(rst_n),
      .note(note_sel),
      .octave(octave_sel),
      .div(div)
  );

  wire tone;
  tone_gen #(
      .WIDTH_COUNTER(16)
  ) tone_gen_1 (
      .clk (clk),
      .rstn(rst_n),
      .div (div),
      .tone(tone)
  );

  reg [6:0] r_led;
  led_bar i_led_bar (
      .clk (clk),
      .rstn(rst_n),
      .note(note_sel),
      .led (r_led)
  );

  assign uo_out[7:1] = r_led;

  assign uo_out[0] = (ena == 1) ? {tone} : 0;
  assign uio_oe = 8'b0000_0000;
  assign uio_out = 0;

endmodule
