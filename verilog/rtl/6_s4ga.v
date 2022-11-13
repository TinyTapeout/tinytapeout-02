// Copyright (C) 2022, Gray Research LLC.
// Licensed under the Apache License, Version 2.0.

`default_nettype none

`define V(N)        [(N)-1:0]
`define SEGS(N,M)   (((N) + ((M)-1)) / (M))

// Receive a stream of LUTs' LUT config segments of SI_W bits per clock.
// When an entire LUT config is recevied, compute the next value of that LUT.
//
// LUT config:
// packed struct LUT_n_k {  // N K-LUTs
//  bit[$clog2(N)] input[K];    // indices of those LUT outputs which are this LUT's K inputs.
//  bit[2**K] mask;             // LUT mask
// };
// Each input[] and mask field rounded up to next multiple of SI_W bits.
//
// For N=16, K=4, SI_W=4, this is 32 bits:
// packed struct LUT_n16_k4 {   // N=16 K=4-LUTs
//  bit[4] input[4];            // 4 4b indices
//  bit[16] mask;               // LUT mask
// };
//
// For N=64, K=6, SI_W=4, this is 112 bits:
// struct LUT_n64_k6 {          // N=64 K=4-LUTs
//  bit[8] input[6];            // 6 6b indices padded to 6 8b indices
//  bit[64] mask;               // LUT mask
// };
module s4ga #(
    parameter N         = 71,   // # LUTs -- must not be multiple of LL (LUT latency) -- use a prime number
    parameter K         = 5,    // # LUT inputs
    parameter I         = 2,    // # FPGA inputs
    parameter O         = 8,    // # FPGA outputs
    parameter SI_W      = 4     // SI width
) (
    input  wire `V(8)   io_in,  // [0]:clk [1]:rst [5:2]:si [7:6]:inputs
    output reg  `V(8)   io_out  // [7:0] outputs
);
    localparam N_W      = $clog2(N);
    localparam K_W      = $clog2(K+1);  // k in [0,K]
    localparam MASK_W   = 2**K;
    localparam MAX_W    = (MASK_W >= N_W) ? MASK_W : N_W;
    localparam SR_W     = MAX_W - SI_W;
    localparam SEG_W    = $clog2(`SEGS(MAX_W, SI_W));
    localparam MASK_SEGS= `SEGS(MASK_W, SI_W);
    localparam IDX_SEGS = `SEGS(N_W, SI_W);
    localparam LL       = K*IDX_SEGS + MASK_SEGS;   // LUT (transmission) latency

    wire            clk;        // clock input
    wire            rst;        // sync reset input -- must assert rst for >N cycles
    wire `V(SI_W)   si;         // LUTs' configuration segments input stream
    reg  `V(N)      luts;       // last N LUT outputs; shuffling circular shift register

    wire `V(I)      inputs;     // FPGA inputs

    assign {inputs,si,rst,clk} = io_in;

    reg  `V(SR_W)   sr;         // input shift reg of LUT input index (k<K) or LUT mask (k==K)
    wire `V(MASK_W) mask    = {sr,si};  // current LUT mask
    wire `V(MASK_W/2) half  = {sr,si};  // current LUT half mask (LSBs)
    wire `V(N_W)    idx     = {sr,si};  // current input index
    reg  `V(K)      ins;        // LUT input values; shift register
    reg             q;          // previous half-LUT output register

    // control FSM
    reg  `V(N_W)    n;          // LUT counter; n in [0,N)
    reg  `V(K_W)    k;          // LUT input index counter; k in [0,K]: k<K => loading index; k==K => loading mask
    reg  `V(SEG_W)  seg;        // input segment counter

    reg/*comb*/     in;         // a LUT input; valid when k<K  && seg==IDX_SEGS-1
    reg/*comb*/     lut;        // LUT output (when LUT frame received), else prior LUT output, else 0 during reset
    reg/*comb*/`V(O) outputs;   // last O LUT outputs

    integer			i;

    always @* begin
        if (&idx)
            in = 1;             // index 11..11 => constant 1
        else if (&(idx|1'b1))
            in = q;             // index 11..10 => q register
        else
            in = luts[idx];     // select an input bit from the various LUT outputs

        if (rst) begin
            lut = '0;
        end else if (k == K && seg == MASK_SEGS-1) begin
            // LUT received
            if (n < I)
                lut = inputs[n];// ignore LUT mask, propagate FPGA input to LUT output
            else
                lut = mask[ins];// select LUT mask bit indexed by the input bit vector
        end else begin
            lut = luts[N-1];    // LUT not yet received: recirculate current LUT output
                                // (shuffling circular shift register area optimization -- saves N-1 mux2s)
        end

        // locate last O LUT outputs in the luts shuffling circular shift register (uses 0 gates)
        outputs[0] = lut;
        for (i = 1; i < O; i = i + 1) begin
            outputs[i] = luts[(LL*i-1) % N];
        end
    end

    always @(posedge clk) begin
        sr <= {sr,si};          // always collect input segments
        luts <= {luts,lut};     // always recirculate LUTs / load LUT updates -- area optimization

        if (rst) begin
            ins <= '0;
            n <= '0;
            k <= '0;
            seg <= '0;
            q <= '0;
            // serial reset (eventually luts=='0 and thus outputs=='0)
            io_out <= outputs;
        end else if (k != K) begin
            // LUT input index segment
            if (seg == IDX_SEGS-1) begin
                // fetch and shift in the next LUT input
                ins <= {ins,in};
                k <= k + 1'b1;
                seg <= '0;
            end else begin
                seg <= seg + 1'b1;
            end
        end else begin
            // mask segment
            if (seg == MASK_SEGS-1) begin
                // evaluate LUT and its half-LUT
                // luts <= {luts,lut}; -- see "always recirculates" above
                q <= half[ins[K-2:0]];

                // all LUTs evaluated: update FPGA outputs
                if (n == N-1)
                    io_out <= outputs;

                n <= (n == N-1) ? '0 : (n + 1'b1);
                k <= '0;
                seg <= '0;
            end else begin
                seg <= seg + 1'b1;
            end
        end
    end
endmodule
