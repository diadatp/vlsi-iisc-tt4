`default_nettype none `timescale 100ns / 1ps

module tb;

  reg clk = 0;
  reg rstn = 0;
  reg start;
  wire [3:0] octave;
  wire [15:0] note;

  rtttl_sequencer rtttl_sequencer_dut (
      .clk(clk),
      .rstn(rstn),
      .start(start),
      .octave(octave),
      .note(note)
  );

  initial begin
    begin
      start = 0;
      rstn  = 0;
      #10;
      rstn = 1;
      #5000;
      start = 1;
      #5000;
      start = 0;
      #5000000;
      $finish;
    end
  end

  initial begin
    $dumpvars;
  end

  always #5 clk = !clk;

endmodule
