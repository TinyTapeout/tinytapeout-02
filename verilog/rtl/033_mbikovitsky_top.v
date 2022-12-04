module mbikovitsky_top #(
    parameter CLOCK_HZ = 625,
    parameter BAUD = 78,
    parameter ROM_WORDS = 4
) (
    input [7:0] io_in,
    output [7:0] io_out
);

    localparam LFSR_BITS = 5;

    wire clk = io_in[0];

    wire mode_cpu = reset_lfsr & reset_taps;

    assign io_out = mode_cpu ? cpu_io_out[7:0] : segments;

    //
    // LFSR
    //

    wire reset_lfsr = io_in[1];
    wire reset_taps = io_in[2];
    wire [LFSR_BITS-1:0] data_in = io_in[3+LFSR_BITS-1:3];

    wire [7:0] segments;

    seven_segment seven_segment (
        .value_i(lfsr_out),
        .segments_o(segments)
    );

    wire [LFSR_BITS-1:0] lfsr_out;

    lfsr #(.BITS(LFSR_BITS), .TICKS(CLOCK_HZ)) lfsr(
        .clk(clk),

        .reset_lfsr_i(reset_lfsr),
        .initial_state_i(data_in),

        .reset_taps_i(reset_taps),
        .taps_i(data_in),

        .state_o(lfsr_out)
    );

    //
    // CPU
    //

    wire cpu_reset  = (!mode_cpu) || (mode_cpu && io_in[3]);
    wire mem_reset  = (!mode_cpu) || (mode_cpu && io_in[4]);
    wire uart_reset = (!mode_cpu) || (mode_cpu && io_in[6]);
    wire uart_rx    = io_in[5];

    CPU cpu (
        .clk(clk),
        .reset(cpu_reset),
        .instruction(instruction),
        .next_instruction_addr_o(next_instruction_addr),
        .memory_we_o(memory_we),
        .memory_i(cpu_io_out),
        .memory_o(cpu_memory_out)
    );

    wire [15:0] instruction;
    wire [14:0] next_instruction_addr;

    wire        memory_we;
    wire [15:0] cpu_memory_out;

    // All memory reads and writes always go to (cpu_io_out), regardless
    // of the address output by the CPU.

    // I/O output
    reg [15:0] cpu_io_out;
    always @(posedge clk) begin
        if (mem_reset) begin
            cpu_io_out <= 0;
        end else begin
            if (!cpu_reset && memory_we) begin
                cpu_io_out <= cpu_memory_out;
            end
        end
    end

    // PROM

    reg [16-1:0] prom [ROM_WORDS];

    assign instruction = prom[next_instruction_addr[$clog2(ROM_WORDS)-1:0]];

    // UART to fill the PROM

    UART #(
        .CLOCK_HZ(CLOCK_HZ),
        .BAUD(BAUD)
    ) uart(
        .reset(uart_reset),
        .clk(clk),
        .rx_i(uart_rx),
        .rx_data_o(rx_data),
        .rx_ready_o(rx_ready),
        .rx_ack_i(1'b1)
    );

    wire [7:0] rx_data;
    wire       rx_ready;

    reg [$clog2(ROM_WORDS)-1:0] uart_write_address;
    reg [0:0]                   uart_state;

    localparam  UART_RECEIVE_LOW    = 2'd0,
                UART_RECEIVE_HIGH   = 2'd1;

    always @(posedge clk) begin
        if (uart_reset) begin
            uart_write_address <= 0;
            uart_state <= UART_RECEIVE_LOW;
        end else begin
            case (uart_state)
                UART_RECEIVE_LOW: begin
                    if (rx_ready) begin
                        prom[uart_write_address][7:0] <= rx_data;
                        uart_state <= UART_RECEIVE_HIGH;
                    end
                end
                UART_RECEIVE_HIGH: begin
                    if (rx_ready) begin
                        prom[uart_write_address][15:8] <= rx_data;
                        uart_state <= UART_RECEIVE_LOW;

                        if (uart_write_address == ROM_WORDS - 1) begin
                            uart_write_address <= 0;
                        end else begin
                            uart_write_address <= uart_write_address + 1;
                        end
                    end
                end
            endcase
        end
    end

endmodule
