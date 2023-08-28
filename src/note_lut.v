`default_nettype none

module note_lut (
    input clk,
    input rstn,
    input [3:0] note,
    input [3:0] octave,
    output reg [15:0] div
);

  reg [15:0] div_pre;

  // the lut is formed by assuming a clock frequency of 1MHz
  // div is the clock dividier required to geenrate the required frequency
  // divs = [str(int(1e6 / (16.35 * (2 * 2**(i / 12))))) for i in range(12)]
  // print("\n".join(divs)) <- not working TODO

  always @(posedge clk) begin
    case (note)
      4'h0: div_pre = 16'd30581;
      4'h1: div_pre = 16'd28864;
      4'h2: div_pre = 16'd27244;
      4'h3: div_pre = 16'd25715;
      4'h4: div_pre = 16'd24272;
      4'h5: div_pre = 16'd22909;
      4'h6: div_pre = 16'd21624;
      4'h7: div_pre = 16'd20410;
      4'h8: div_pre = 16'd19264;
      4'h9: div_pre = 16'd18183;
      4'hA: div_pre = 16'd17163;
      4'hB: div_pre = 16'd16199;
      default: div_pre = 16'd0;
    endcase
  end

  always @(posedge clk) begin
    case (octave)
      4'd0: div = div_pre >> 0;
      4'd1: div = div_pre >> 1;
      4'd2: div = div_pre >> 2;
      4'd3: div = div_pre >> 3;
      4'd4: div = div_pre >> 4;
      4'd5: div = div_pre >> 5;
      4'd6: div = div_pre >> 6;
      4'd7: div = div_pre >> 7;
      4'd8: div = div_pre >> 8;
      default: div = div_pre;
    endcase
  end

endmodule
