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

  tone_gen #(
      .MAX_COUNT(42),
      .WIDTH_COUNTER(10)
  ) tone_gen1 (
      .clk (clk),
      .rst (~rst_n),
      .tone(uo_out[0])
  );

  assign uio_oe = 8'b1111_1111;

endmodule
