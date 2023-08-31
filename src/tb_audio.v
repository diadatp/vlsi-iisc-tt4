`default_nettype none `timescale 100ns / 10ns

module tb ();

  // 1 MHz clock
  initial clk = 1'b0;
  always #5 clk = ~clk;

  reg [11:0] user_keys;
  assign {uio_in[3:0], ui_in} = user_keys;

  reg [3:0] octave;
  assign uio_in[7:4] = octave;

  integer i;
  integer j;
  initial begin
    octave = 4;
    user_keys = 12'b1000_0000_0000;
    ena = 1;

    //  assert reset for one clock cycle
    rst_n = 1'b0;
    #10 rst_n = 1'b1;

    for (i = 4; i < 9; i = i + 1) begin
      octave = i;
      for (j = 0; j < 12; j = j + 1) begin
        user_keys = user_keys >> 1;
        // wait for 500ms
        #5000000;
        $display("hmm");
      end
    end

    $finish;
  end

  initial begin
    $dumpvars(1, uo_out);
  end

  // wire up inputs and outputs. Use reg for inputs that will be driven by the testbench.
  reg clk;
  reg rst_n;
  reg ena;
  wire [7:0] ui_in;
  wire [7:0] uio_in;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  tt_um_simplepiano dut (
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
