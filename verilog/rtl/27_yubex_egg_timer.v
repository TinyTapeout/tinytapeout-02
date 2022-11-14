
/*
tiny egg timer
*/

module yubex_egg_timer (
    input [7:0] io_in,
    output reg [7:0] io_out
    );
  
 wire clk;
 localparam clk_frequency = 14'd10000; // frequency in Hz
 wire rst;
 wire start;
  
  
 assign clk = io_in[0];
 assign rst = io_in[1];
 assign start = io_in[2];
 
 reg [1:0] state;
 localparam idle    = 2'b00;
 localparam waiting = 2'b01;
 localparam alarm   = 2'b10;
 
  reg [13:0] clk_cycle_cnt;
  reg [5:0]  second_cnt;
  reg [4:0]  minute_cnt;
  
  always @(posedge clk or posedge rst)
  begin
	if(rst) begin
        	state <= idle;
    	    end 
    else begin
        case(state)
            idle: 
                begin
                if (start == 1'b1)
                    state <= waiting;
                else
                    state <= idle;
                end
            waiting: 
                begin
                  if (second_cnt == 6'b0 && minute_cnt == 5'b0 && clk_cycle_cnt == 14'b0)
                    state <= alarm;
                else 
                    state <= waiting;
                end
            alarm: 
                begin
                if (start == 1'b0)
                    state <= idle;
                else
                    state <= alarm;
                end
            default: state <= idle;
        endcase
    end
  end  
  
  always @(posedge clk or posedge rst)
  begin
    if (rst) begin
      minute_cnt 	<= 5'b1;
      second_cnt    <= 6'd59;
      clk_cycle_cnt <= clk_frequency - 1;
    end
    else begin
        if (state == idle) begin
            //load wait time from io_in
            minute_cnt    <= io_in[7:3] - 1;
            second_cnt    <= 6'd59;
            clk_cycle_cnt <= clk_frequency - 1;
        end
        if (state == waiting) begin
            if (clk_cycle_cnt == 14'b0) begin
                clk_cycle_cnt <= clk_frequency - 1;
                if (second_cnt == 6'b0) begin
                    second_cnt <= 6'd59;
                  if (minute_cnt != 5'b0) begin
                        minute_cnt <= minute_cnt - 1;
                    end
                end
                else begin
                    second_cnt <= second_cnt - 1;
                end
            end
            else begin
                clk_cycle_cnt <= clk_cycle_cnt - 1;
            end
        end 
    end
  end
  
  // 7 segment display
  always @(posedge clk or posedge rst)
  begin
	if(rst) begin
        	io_out <= 8'b0;
    	end else begin
        case(state)
              idle: 
                  begin
                    io_out <= 8'b01000000;
                  end
              waiting: 
                  begin
                    io_out [6:0] <= 7'b0;
                    if (clk_cycle_cnt == 14'b0)
                    	io_out[7]<=~io_out[7];
                  end
              alarm: 
                  begin
	                io_out <= 8'b11110111;
                  end
              default:;
          endcase
        end
  end

endmodule
