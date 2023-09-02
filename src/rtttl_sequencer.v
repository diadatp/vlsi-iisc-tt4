module rtttl_sequencer (
    input clk,
    input rstn,
    input start,
    output reg [3:0] octave,
    output reg [15:0] note
);

  reg [15:0] required_key;
  reg [15:0] address;

  localparam BPM = 160;

  // calculate the counter value at which one sixty fourth of a note's
  // worth of time has passed.
  localparam integer SIXF_MAX_COUNT = (1e6 / (BPM * 64 / 4 / 60));

  reg [15:0] sixf_counter;
  reg [ 5:0] note_counter;

  always @(posedge clk) begin
    if (!rstn) begin
      sixf_counter <= 0;
      note_counter <= 6'b111111;
    end else begin
      if (note_counter != 6'b111111) begin
        if (sixf_counter == SIXF_MAX_COUNT) begin
          sixf_counter <= 0;
          note_counter <= note_counter - 1;
        end else begin
          sixf_counter <= sixf_counter + 1;
        end
      end else if (start) begin
        note_counter <= 0;
      end
    end
  end

  always @(posedge clk) begin
    if (!rstn) begin
      address <= 0;
      required_key <= 0;
      octave <= 0;
    end else begin
      if (note_counter == 0) begin
        case (address)
          0: begin
            note_counter <= 8;
            octave <= 5;
            required_key <= 6;
            address <= address + 1;
          end
          1: begin
            note_counter <= 4;
            octave <= 6;
            required_key <= 2;
            address <= address + 1;
          end
          default: begin
            note_counter <= 6'b111111;
            octave <= 0;
            required_key <= 0;
            address <= 0;
          end
        endcase
      end
    end
  end

endmodule
