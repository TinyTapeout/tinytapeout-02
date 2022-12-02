module pic10_core(input clock, reset, output [3:0] prog_adr, input [11:0] prog_data, input [3:0] gpi, output reg [7:0] gpo);
    wire [7:0] reg_rdata;
    reg [7:0] result;
    reg [7:0] w;
    reg [1:0] phase;
    reg [3:0] pc;
    reg [3:0] next_pc;
    reg skip, next_skip, next_skip_zero;
    reg reg_we, w_we;

    assign prog_adr = pc;

    always @(posedge clock, negedge reset)
    begin
        if (!reset) begin
            phase <= 2'b0;
        end else begin
            phase <= phase + 1'b1;
        end
    end

    always @(posedge clock, negedge reset)
    begin
        if (!reset) begin
            pc <= 1'b0;
            next_pc <= 1'b0;
            w <= 1'b0;
            next_skip <= 1'b0;
        end else begin
            if (phase == 0) begin
                skip <= next_skip;
                next_skip <= 1'b0;
                next_skip_zero <= 1'b0;
                reg_we <= 1'b0;
                w_we <= 1'b0;
                pc <= next_pc;
            end else if (phase == 1) begin
                next_pc <= prog_adr + 1'b1;
                if (prog_data[11:10] == 2'b00) begin
                    reg_we <= prog_data[5];
                    w_we <= ~prog_data[5];
                    case (prog_data[9:6])
                        4'b0000: result <= w;
                        4'b0001: result <= 0;
                        4'b0010: result <= reg_rdata - w;
                        4'b0011: result <= reg_rdata - 1;
                        4'b0100: result <= reg_rdata | w;
                        4'b0101: result <= reg_rdata & w;
                        4'b0110: result <= reg_rdata ^ w;
                        4'b0111: result <= reg_rdata + w;
                        4'b1000: result <= reg_rdata;
                        4'b1001: result <= ~reg_rdata;
                        4'b1010: result <= reg_rdata + 1;
                        4'b1011: begin result <= reg_rdata - 1; next_skip_zero <= 1'b1; end
                        4'b1111: begin result <= reg_rdata + 1; next_skip_zero <= 1'b1; end
                    endcase
                end else if (prog_data[11:10] == 2'b01) begin
                    reg_we <= 1'b1;
                    case (prog_data[9:8])
                        2'b00: result <= reg_rdata & ~(1 << prog_data[7:5]);
                        2'b01: result <= reg_rdata | (1 << prog_data[7:5]);
                        2'b10: begin result <= reg_rdata; next_skip <= ~reg_rdata[prog_data[7:5]]; end
                        2'b11: begin result <= reg_rdata; next_skip <= reg_rdata[prog_data[7:5]]; end
                    endcase
                end else if (prog_data[11:10] == 2'b10) begin
                    // no call, return
                    if (!skip)
                        next_pc <= prog_data[3:0];
                end else if (prog_data[11:10] == 2'b11) begin
                    w_we <= 1'b1;
                    case (prog_data[9:8])
                        2'b00: result <= prog_data[7:0];
                        2'b01: result <= prog_data[7:0] | w;
                        2'b10: result <= prog_data[7:0] & w;
                        2'b11: result <= prog_data[7:0] ^ w;
                    endcase
                end
            end else if (phase == 2) begin
                if (next_skip_zero) begin
                    next_skip <= (result == 0);
                end
                if (!skip) begin
                    if (w_we)
                        w <= result;
                end
            end else if (phase == 3) begin
                // ...
            end
        end
    end

    wire [2:0] reg_addr = prog_data[2:0];
    always @(posedge clock) begin
        if (reg_we && regf_we && (reg_addr == 7))
            gpo <= result;
    end

    wire [7:0] regf_data[0:7];
    assign regf_data[6] = {4'b0000, gpi};
    assign regf_data[7] = gpo;

    assign reg_rdata = regf_data[reg_addr];

    // register file
    wire regf_we = phase[1] & !skip;

    generate
        genvar ii, jj;
        for (ii = 0; ii < 6; ii = ii + 1'b1) begin:word
            wire word_we;
            sky130_fd_sc_hd__and3_1 word_we_i ( // make sure this is really glitch free
                .A(reg_addr[2:0] == ii),
                .B(regf_we),
                .C(reg_we),
                .X(word_we)
            );
            for (jj = 0; jj < 8; jj = jj + 1'b1) begin:bits
                sky130_fd_sc_hd__dlrtp_1 rfbit_i (
                    .GATE(word_we),
                    .RESET_B(reset),
                    .D(result[jj]),
                    .Q(regf_data[ii][jj])
                );
            end
        end
    endgenerate

endmodule

(* blackbox *)
module sky130_fd_sc_hd__dlrtp_1(input GATE, RESET_B, D, output reg Q);
    always @*
        if (~RESET_B)
            Q <= 0;
        else if (GATE)
            Q <= D;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__dlxtp_1(input GATE, D, output reg Q);
    always @*
        if (GATE)
            Q <= D;
endmodule

(* blackbox *)
module sky130_fd_sc_hd__and3_1(input A, B, C, output X);
    assign X = A & B & C;
endmodule

// latch based program memory
module pic_progmem(input clock, write_data, write_strobe, input [3:0] adr, output [11:0] rdata);
    localparam K = 16;

    // the program logic
    reg [27:0] write_sr;
    always @(posedge clock)
        write_sr <= {write_data, write_sr[27:1]};

    wire [11:0] data[0:K-1];
    generate
        genvar ii, jj;
        for (ii = 0; ii < K; ii = ii + 1'b1) begin:word
            for (jj = 0; jj < 12; jj = jj + 1'b1) begin:bits
                sky130_fd_sc_hd__dlxtp_1 rfbit_i (
                    .GATE(write_sr[ii + 12] && write_strobe),
                    .D(write_sr[jj]),
                    .Q(data[ii][jj])
                );
            end
        end
    endgenerate
    assign rdata = data[adr];
endmodule

module tiny_kinda_pic(input [7:0] io_in, output [7:0] io_out);
    wire clk = io_in[0];
    wire reset = io_in[1];

    wire [3:0] prog_adr;
    wire [11:0] prog_data;
    pic10_core pic_i (
        .clock(clk),
        .reset(reset),
        .prog_adr(prog_adr),
        .prog_data(prog_data),
        .gpi(io_in[7:4]),
        .gpo(io_out)
    );

    pic_progmem progmem_i (
        .clock(clk),
        .write_strobe(io_in[2]),
        .write_data(io_in[3]),
        .adr(prog_adr),
        .rdata(prog_data)
    );

endmodule
