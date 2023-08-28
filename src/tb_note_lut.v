`default_nettype none `timescale 1ns / 1ps

module tb ();

  initial clk = 1'b0;
  initial rstn = 1'b0;
  always #5 clk = ~clk;

  reg clk;
  reg rstn;
  reg [3:0] note;
  reg [3:0] octave;
  wire [15:0] div;

  note_lut note_lut_dut (
      .clk(clk),
      .rstn(rstn),
      .note(note),
      .octave(octave),
      .div(div)
  );

  integer i;
  integer j;

  initial begin
    note = 0;
    // octave = 0;
    for (i = 0; i < 9; i = i + 1) begin
      octave = i;
      for (j = 0; j < 12; j = j + 1) begin
        note = j;
        #40;
      end
    end
    $finish;
  end

  initial begin
    $dumpvars;
  end

endmodule
