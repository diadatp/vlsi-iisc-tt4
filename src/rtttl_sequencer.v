`default_nettype none

module rtttl_sequencer (
    input clk,
    input rstn,
    input start,
    input [1:0] demo,
    output reg [3:0] octave,
    output reg [3:0] note
);

  // localparam BPM = 160;

  // calculate the counter value at which one sixty fourth of a note's
  // worth of time has passed.
  // localparam integer SIXF_MAX_COUNT = (1e6 / (BPM * 64 / 4 / 60));
  localparam SIXF_MAX_COUNT = 23810;

  reg [15:0] sixf_counter;

  // sixf_counter is a free running counter that
  // starts when the chip is reset and wraps around
  // every 1/64th of a note.
  // the wrap around condition is
  // (sixf_counter == SIXF_MAX_COUNT)
  // TODO investigate if SIXF_MAX_COUNT or SIXF_MAX_COUNT-1
  always @(posedge clk) begin
    if (!rstn) begin
      sixf_counter <= 0;
    end else begin
      if (sixf_counter == SIXF_MAX_COUNT) begin
        sixf_counter <= 0;
      end else begin
        sixf_counter <= sixf_counter + 1;
      end
    end
  end

  // The section below traverses through the addresses to generates rtttl based frequency
  // Value of note and octave is outputted at fixed intervals(governed by note_counter)
  // to generate required tone frequencies

  // note_counter is used to track how many 1/64ths
  // of a note each part of the rtttl sentence lasts

  reg [5:0] note_counter;
  reg [7:0] address;
  reg in_demo;  // variable used to signify that the user is in demo mode
  reg which_demo;

  always @(posedge clk) begin
    if (!rstn) begin
      address <= 0;
      note_counter <= 0;
      in_demo <= 0;
      which_demo <= 0;
    end else begin
      if (start) begin
        in_demo <= 1;
        which_demo <= demo[1] == 1 ? 1 : 0;
      end
      if ((in_demo == 1) && (sixf_counter == SIXF_MAX_COUNT)) begin
        if (note_counter != 0) begin
          note_counter <= note_counter - 1;
        end else begin
          if (which_demo == 1) begin
            case (address)
              0: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              1: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              2: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              3: begin
                note_counter <= 8;
                octave <= 5;
                note <= 2;
                address <= address + 1;
              end
              4: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              5: begin
                note_counter <= 8;
                octave <= 4;
                note <= 11;
                address <= address + 1;
              end
              6: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              7: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              8: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              9: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              10: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              11: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              12: begin
                note_counter <= 8;
                octave <= 5;
                note <= 8;
                address <= address + 1;
              end
              13: begin
                note_counter <= 8;
                octave <= 5;
                note <= 8;
                address <= address + 1;
              end
              14: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              15: begin
                note_counter <= 8;
                octave <= 5;
                note <= 11;
                address <= address + 1;
              end
              16: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              17: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              18: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              19: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              20: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              21: begin
                note_counter <= 8;
                octave <= 5;
                note <= 2;
                address <= address + 1;
              end
              22: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              23: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              24: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              25: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              26: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              27: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              28: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              29: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              30: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              31: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              32: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              33: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              34: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              35: begin
                note_counter <= 8;
                octave <= 5;
                note <= 2;
                address <= address + 1;
              end
              36: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              37: begin
                note_counter <= 8;
                octave <= 4;
                note <= 11;
                address <= address + 1;
              end
              38: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              39: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              40: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              41: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              42: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              43: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              44: begin
                note_counter <= 8;
                octave <= 5;
                note <= 8;
                address <= address + 1;
              end
              45: begin
                note_counter <= 8;
                octave <= 5;
                note <= 8;
                address <= address + 1;
              end
              46: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              47: begin
                note_counter <= 8;
                octave <= 5;
                note <= 11;
                address <= address + 1;
              end
              48: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              49: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              50: begin
                note_counter <= 8;
                octave <= 5;
                note <= 9;
                address <= address + 1;
              end
              51: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              52: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              53: begin
                note_counter <= 8;
                octave <= 5;
                note <= 2;
                address <= address + 1;
              end
              54: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              55: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              56: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              57: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              58: begin
                note_counter <= 8;
                octave <= 4;
                note <= 12;
                address <= address + 1;
              end
              59: begin
                note_counter <= 8;
                octave <= 5;
                note <= 6;
                address <= address + 1;
              end
              60: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              61: begin
                note_counter <= 8;
                octave <= 5;
                note <= 4;
                address <= address + 1;
              end
              default: begin
                in_demo <= 0;
                note_counter <= 0;
                octave <= 0;
                note <= 0;
                address <= 0;
              end
            endcase
          end else begin
            case (address)
              0: begin
                note_counter <= 16;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              1: begin
                note_counter <= 16;
                octave <= 4;
                note <= 9;
                address <= address + 1;
              end
              2: begin
                note_counter <= 16;
                octave <= 4;
                note <= 11;
                address <= address + 1;
              end
              3: begin
                note_counter <= 16;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              4: begin
                note_counter <= 16;
                octave <= 6;
                note <= 2;
                address <= address + 1;
              end
              5: begin
                note_counter <= 16;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              6: begin
                note_counter <= 16;
                octave <= 6;
                note <= 5;
                address <= address + 1;
              end
              7: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              8: begin
                note_counter <= 8;
                octave <= 4;
                note <= 0;
                address <= address + 1;
              end
              9: begin
                note_counter <= 8;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              10: begin
                note_counter <= 8;
                octave <= 4;
                note <= 4;
                address <= address + 1;
              end
              11: begin
                note_counter <= 8;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              12: begin
                note_counter <= 8;
                octave <= 7;
                note <= 0;
                address <= address + 1;
              end
              13: begin
                note_counter <= 8;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              14: begin
                note_counter <= 8;
                octave <= 6;
                note <= 9;
                address <= address + 1;
              end
              15: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              16: begin
                note_counter <= 8;
                octave <= 4;
                note <= 0;
                address <= address + 1;
              end
              17: begin
                note_counter <= 8;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              18: begin
                note_counter <= 8;
                octave <= 4;
                note <= 4;
                address <= address + 1;
              end
              19: begin
                note_counter <= 8;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              20: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              21: begin
                note_counter <= 8;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              22: begin
                note_counter <= 8;
                octave <= 6;
                note <= 5;
                address <= address + 1;
              end
              23: begin
                note_counter <= 8;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              24: begin
                note_counter <= 8;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              25: begin
                note_counter <= 8;
                octave <= 6;
                note <= 5;
                address <= address + 1;
              end
              26: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              27: begin
                note_counter <= 8;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              28: begin
                note_counter <= 8;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              29: begin
                note_counter <= 8;
                octave <= 6;
                note <= 2;
                address <= address + 1;
              end
              30: begin
                note_counter <= 8;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              31: begin
                note_counter <= 8;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              32: begin
                note_counter <= 8;
                octave <= 4;
                note <= 0;
                address <= address + 1;
              end
              33: begin
                note_counter <= 4;
                octave <= 4;
                note <= 4;
                address <= address + 1;
              end
              34: begin
                note_counter <= 16;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              35: begin
                note_counter <= 16;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              36: begin
                note_counter <= 16;
                octave <= 4;
                note <= 9;
                address <= address + 1;
              end
              37: begin
                note_counter <= 16;
                octave <= 4;
                note <= 11;
                address <= address + 1;
              end
              38: begin
                note_counter <= 16;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              39: begin
                note_counter <= 16;
                octave <= 6;
                note <= 2;
                address <= address + 1;
              end
              40: begin
                note_counter <= 16;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              41: begin
                note_counter <= 16;
                octave <= 6;
                note <= 5;
                address <= address + 1;
              end
              42: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              43: begin
                note_counter <= 8;
                octave <= 4;
                note <= 0;
                address <= address + 1;
              end
              44: begin
                note_counter <= 8;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              45: begin
                note_counter <= 8;
                octave <= 4;
                note <= 4;
                address <= address + 1;
              end
              46: begin
                note_counter <= 8;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              47: begin
                note_counter <= 8;
                octave <= 7;
                note <= 0;
                address <= address + 1;
              end
              48: begin
                note_counter <= 8;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              49: begin
                note_counter <= 8;
                octave <= 6;
                note <= 9;
                address <= address + 1;
              end
              50: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              51: begin
                note_counter <= 8;
                octave <= 4;
                note <= 0;
                address <= address + 1;
              end
              52: begin
                note_counter <= 8;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              53: begin
                note_counter <= 8;
                octave <= 4;
                note <= 4;
                address <= address + 1;
              end
              54: begin
                note_counter <= 8;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              55: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              56: begin
                note_counter <= 8;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              57: begin
                note_counter <= 8;
                octave <= 6;
                note <= 5;
                address <= address + 1;
              end
              58: begin
                note_counter <= 8;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              59: begin
                note_counter <= 8;
                octave <= 6;
                note <= 4;
                address <= address + 1;
              end
              60: begin
                note_counter <= 8;
                octave <= 6;
                note <= 5;
                address <= address + 1;
              end
              61: begin
                note_counter <= 8;
                octave <= 6;
                note <= 7;
                address <= address + 1;
              end
              62: begin
                note_counter <= 8;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              63: begin
                note_counter <= 8;
                octave <= 4;
                note <= 5;
                address <= address + 1;
              end
              64: begin
                note_counter <= 8;
                octave <= 6;
                note <= 2;
                address <= address + 1;
              end
              65: begin
                note_counter <= 8;
                octave <= 4;
                note <= 7;
                address <= address + 1;
              end
              66: begin
                note_counter <= 4;
                octave <= 6;
                note <= 0;
                address <= address + 1;
              end
              default: begin
                in_demo <= 0;
                note_counter <= 0;
                octave <= 0;
                note <= 0;
                address <= 0;
              end
            endcase
          end
        end
      end
    end
  end

endmodule
