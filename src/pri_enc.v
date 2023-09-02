`default_nettype none

module pri_enc (
    input  wire [11:0] keys,
    input  wire [ 3:0] octave,
    output reg  [11:0] keys_masked,
    output reg  [15:0] div
);

  always @* begin
    casez (keys)
      12'b1???_????_????: begin
        div = 16'd30581 >> octave;
        keys_masked = {1'b0, keys[10:0]};
      end
      12'b01??_????_????: begin
        div = 16'd28864 >> octave;
        keys_masked = {2'b0, keys[9:0]};
      end
      12'b001?_????_????: begin
        div = 16'd27244 >> octave;
        keys_masked = {3'b0, keys[8:0]};
      end
      12'b0001_????_????: begin
        div = 16'd25715 >> octave;
        keys_masked = {4'b0, keys[7:0]};
      end
      12'b0000_1???_????: begin
        div = 16'd24272 >> octave;
        keys_masked = {5'b0, keys[6:0]};
      end
      12'b0000_01??_????: begin
        div = 16'd22909 >> octave;
        keys_masked = {6'b0, keys[5:0]};
      end
      12'b0000_001?_????: begin
        div = 16'd21624 >> octave;
        keys_masked = {7'b0, keys[4:0]};
      end
      12'b0000_0001_????: begin
        div = 16'd20410 >> octave;
        keys_masked = {8'b0, keys[3:0]};
      end
      12'b0000_0000_1???: begin
        div = 16'd19264 >> octave;
        keys_masked = {9'b0, keys[2:0]};
      end
      12'b0000_0000_01??: begin
        div = 16'd18183 >> octave;
        keys_masked = {10'b0, keys[1:0]};
      end
      12'b0000_0000_001?: begin
        div = 16'd17163 >> octave;
        keys_masked = {11'b0, keys[0]};
      end
      12'b0000_0000_0001: begin
        div = 16'd16199 >> octave;
        keys_masked = 12'b0;
      end
      12'b0000_0000_0000: begin
        div = 16'hffff;
        keys_masked = 12'b0;
      end
      default: begin
        div = 16'hffff;
        keys_masked = 12'b0;
      end
    endcase
  end

endmodule
