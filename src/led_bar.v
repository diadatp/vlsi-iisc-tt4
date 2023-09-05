`default_nettype none

module led_bar #(
    parameter BAR_HEIGHT = 7
) (
    input clk,
    input rstn,
    input [3:0] note,
    output reg [BAR_HEIGHT-1:0] led
);

  // TICK_MAX_COUNT = 1e6/7 to count 1/7 sec using tick_counter
  // tick_counter is set to 0 at TICK_MAX_COUNT or if the note changes
  reg [3:0] prev_note;
  localparam TICK_MAX_COUNT = 142857; 
  reg [19:0] tick_counter;
  always @(posedge clk) begin
    if (!rstn) begin
      tick_counter <= 0;
    end else begin
      prev_note <= note;
      if (prev_note !== note) begin
        tick_counter <= 0;
      end else if (tick_counter == TICK_MAX_COUNT) begin
        tick_counter <= 0;
      end else begin
        tick_counter <= tick_counter + 1;
      end
    end
  end

  reg [2:0] prev_level;
  reg [2:0] new_level;

  always @(posedge clk) begin
    if (!rstn) begin
      led <= 0;
      new_level <= 0;
      prev_level <= 0;
    end else begin
      case (note)
        4'h0: new_level <= 1;
        4'h1: new_level <= 1;
        4'h2: new_level <= 2;
        4'h3: new_level <= 3;
        4'h4: new_level <= 4;
        4'h5: new_level <= 4;
        4'h6: new_level <= 5;
        4'h7: new_level <= 5;
        4'h8: new_level <= 6;
        4'h9: new_level <= 6;
        4'hA: new_level <= 7;
        4'hB: new_level <= 7;
        default: new_level <= 0;
      endcase
      if (tick_counter == TICK_MAX_COUNT) begin
        if (prev_level < new_level) begin
          // increase bar height
          led <= {1'b1, led[BAR_HEIGHT-1:1]};
          prev_level <= prev_level + 1;
        end else if (prev_level > new_level) begin
          // decrease bar height
          led <= {led[BAR_HEIGHT-2:0], 1'b0};
          prev_level <= prev_level - 1;
        end
      end
    end
  end

endmodule
