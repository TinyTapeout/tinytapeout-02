module asinghani_beepboop (
    input [7:0] io_in,
    output [7:0] io_out
);

    wire clock = io_in[0];
    wire reset = io_in[1]; // active-high
    wire btn = io_in[2];

    logic red, yellow, green, walk, no_walk, the_beepbooper;
    logic chr_out, chr_out_valid;

    assign io_out = {chr_out_valid, chr_out, the_beepbooper, no_walk, walk, green, yellow, red};

    logic [15:0] counter; // 10ms interval

    // secret identifier message
    logic [0:191] beepboop = {"asinghani/tt02-beepboop", 8'h0};
    assign chr_out = beepboop[counter-1];
    assign chr_out_valid = (counter > 0) && (counter <= 192);

    // Counter
    always_ff @(posedge clock) begin
        if (reset) begin
            counter <= 0;
        end
        else begin
            if (counter != 0) begin
                counter <= counter + 1;
            end

            if (counter >= 2200) begin
                counter <= 0;
            end

            if ((counter == 0) && btn) begin
                counter <= 1;
            end
        end
    end

    // Control the outputs
    always_comb begin
        green = (counter == 0) || (counter >= 2200);
        yellow = (counter > 0) && (counter < 200);
        red = (counter >= 200) && (counter < 2200);

        walk = (counter > 300) && (counter < 1500);
        the_beepbooper = walk;

        no_walk = ((counter >= 1500) && (counter < 1600)) ||
                  ((counter >= 1700) && (counter < 1800)) ||
                  ((counter >= 1900) && (counter < 2000)) ||
                  ((counter >= 2100)) || (counter <= 300);
    end
    
endmodule : asinghani_beepboop
