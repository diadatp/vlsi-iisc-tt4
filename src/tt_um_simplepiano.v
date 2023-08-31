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

  localparam STAGES = 4;

  reg [11:0] keys;
  reg [ 3:0] octave;

  always @(posedge clk) begin
    if (!rst_n) begin
      keys   <= 0;
      octave <= 0;
    end else begin
      keys   <= {uio_in[3:0], ui_in};
      octave <= uio_in[7:4];
    end
  end

  wire [11:0] keys_stages[STAGES:0];
  wire [15:0] div[STAGES-1:0];
  wire [STAGES-1:0] note;

  assign keys_stages[0] = keys;

  generate
    genvar i;
    for (i = 0; i < STAGES; i = i + 1) begin

      pri_enc i_pri_enc (
          .keys(keys_stages[i]),
          .octave(octave),
          .keys_masked(keys_stages[i+1]),
          .div(div[i])
      );

      tone_gen #(
          .WIDTH_COUNTER(16)
      ) i_tone_gen (
          .clk (clk),
          .rstn(rst_n),
          .div (div[i]),
          .tone(note[i])
      );
    end
  endgenerate

  assign uo_out[8:STAGES] = 0;
  assign uo_out[STAGES-1:0] = (ena == 1) ? {note} : 0;
  assign uio_oe = 8'b1111_0000;
  assign uio_out = 8'b0000_0000;

endmodule
