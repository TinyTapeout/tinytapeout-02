module recepsaid_euclidean_algorithm(
    input  [7:0] io_in,
    output [7:0] io_out
);

wire        clk;
wire        num_okey;
wire        rst;
wire [3:0]  number;
reg  [3:0]  num1;
reg  [3:0]  num2;
reg  [6:0]  ssd_out;

reg  [2:0]  state = S0;
reg         start;
wire [3:0]  gcd;
wire [6:0]  decoder_out;

assign num_okey    = io_in[7];
assign rst         = io_in[6];
assign number      = io_in[4:1];
assign clk         = io_in[0];
assign io_out[6:0] = ssd_out;

localparam 	S0 = 3'd0,
			S1 = 3'd1,
			S2 = 3'd2,
			S3 = 3'd3,
			S4 = 3'd4;      

always @(posedge clk)
    begin
        if(rst) begin
            //ssd_out idle state
            state    <= S0;
            ssd_out  <= 7'b1000000; 
        end
        else begin            
            case(state)          
            S0:
                begin
                    //ssd_out idle state
                    start   <= 1'b0;
                    ssd_out <= 7'b1000000;
                    
                    if(num_okey) begin
                        state <= S1;
                    end
                    else begin
                        state <= S0;
                    end                
                end
                
            S1:
                begin
                    //ssd_out okey state
                    num1    <= number;
                    start   <= 1'b0;
                    ssd_out <= 7'b1011100;
                    
                    if(~num_okey) begin    
                        state <= S2;
                    end
                    else begin
                        state <= S1;
                    end
                end
                
            S2:
                begin
                    //ssd_out next state
                    start   <= 1'b0;
                    ssd_out <= 7'b1010100;
                    
                    if(num_okey) begin
                        state <= S3;
                    end
                    else begin
                        state <= S2;
                    end
                end                
                
            S3:
                begin
                    //ssd_out okey state
                    num2    <= number;
                    start   <= 1'b0;
                    ssd_out <= 7'b1011100;
                    
                    if(~num_okey) begin
                        state <= S4;
                    end
                    else begin
                        state <= S3;
                    end
                end
          
                
            S4:
                begin
                    //ssd_out result state
                    start    <= 1'b1;
                    ssd_out  <= decoder_out;                        
                    
                    if(rst) begin
                        state <= S0;
                    end
                    else begin
                        state <= S4; 
                    end              
                end
                                                           
            default:
                begin
                    ssd_out      <= 7'b1000000;
                    num1         <= 4'b0000;
                    num2         <= 4'b0000;
                    start        <= 1'b0;            
                end            
            endcase      
        end  
    end
   
gcd_top #(.DATA_BITS_TOP(4)) gcdtop(
                                    .okey_i   (start),     
                                    .rst_i    (rst),     
                                    .clk_i    (clk),      
                                    .x_i      (num1),
                                    .y_i      (num2),    
                                    .result_o (gcd)
                                    );

ssd_decoder decoder(
                    .ssd_i  (gcd),
                    .rst_i  (rst),
                    .ssd_o  (decoder_out)
                    );
                                    
endmodule
