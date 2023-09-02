`default_nettype none `timescale 100ns / 1ps

module tb ();

  // clock with period #10 = 10*100ns = 1MHz
  initial clk = 1'b0;
  always #5 clk = ~clk;

  // assign IOs to easy to understand names
  reg [11:0] user_keys;
  reg [ 3:0] octave;
  assign {uio_in[3:0], ui_in} = user_keys;
  assign uio_in[7:4] = octave;

  integer i;
  integer j;
  initial begin
    // set all initial inputs once and
    // assert reset for one clock cycle
    ena = 1;
    user_keys = 12'b0000_0000_0000;
    octave = 4'b0000;

    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;

    // // test 1
    // // cycle through all keys including no keys pressed
    // // repeat for all octaves
    // for (i = 0; i < 9; i = i + 1) begin
    //   octave = i;

    //   // no keys pressed
    //   user_keys = 12'b0000_0000_0000;
    //   // wait for 500ms
    //   #500_000_0;

    //   // all keys pressed separately
    //   for (j = 0; j < 12; j = j + 1) begin
    //     user_keys = 12'b1000_0000_0000 >> j;
    //     // wait for 500ms
    //     #5000000;

    //     $display("hmm");
    //   end
    // end

    // // test 2
    // // all keys pressed
    // // repeat for all octaves
    // for (i = 0; i < 9; i = i + 1) begin
    //   octave = i;
    //   user_keys = 12'b1111_1111_1111;

    //   // wait for 500ms
    //   #5000000;

    //   $display("hmm");
    // end

    // // test 3
    // // keys and octave pressed randomly
    // octave = 0;
    // user_keys = 12'b0000_0001_0000;
    // #2500000;
    // octave = 1;
    // #2500000;

    // octave = 2;
    // user_keys = 12'b0000_0001_0000;
    // #2500000;
    // user_keys = 12'b0000_1001_0000;
    // #2500000;

    // test 4
    // rtttl
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 2;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 11;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 8;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 8;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 11;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 2;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 2;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 11;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 8;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 8;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 11;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 9;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 2;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 4;
    user_keys = 12'b1000_0000_0000 >> 12;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 6;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;
    octave = 5;
    user_keys = 12'b1000_0000_0000 >> 4;
    #1875000.0;

    #100;
    $finish;
  end

  initial begin
    // $dumpvars;
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
