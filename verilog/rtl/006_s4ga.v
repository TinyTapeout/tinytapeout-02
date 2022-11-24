// Copyright (C) 2022, Gray Research LLC.
// Licensed under the Apache License, Version 2.0.

`default_nettype none

`define V(N)        [(N)-1:0]
`define SEGS(N,M)   (((N) + ((M)-1)) / (M))
`define MAX(A,B)    ((A) >= (B) ? (A) : (B))
`define comb        reg /* combinational: assigned in an always @* block */

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
    parameter N         = 283,  // # LUTs -- must not be multiple of LL (LUT latency) -- use a prime number
    parameter K         = 5,    // # LUT inputs
    parameter I         = 2,    // # FPGA inputs
    parameter O         = 7,    // # FPGA outputs
    parameter SI_W      = 4     // SI width
) (
    input  wire `V(8)   io_in,  // [0]:clk [1]:rst [5:2]:si [7:6]:inputs
    output reg  `V(8)   io_out  // [6:0] outputs [7]:debug
);
    localparam N_W      = $clog2(N);
    localparam K_W      = $clog2(K + 1);        // k in [0,K]
    localparam IDX_W    = $clog2(3 + I + N);    // index selects a special index, an FPGA input, or a LUT output
    localparam SR_W     = `MAX(IDX_W - SI_W, 1);
    localparam MASK_W   = 2**K;
    localparam MAX_W    = `MAX(MASK_W, IDX_W);
    localparam SEGS_W   = `MAX($clog2(`SEGS(MAX_W, SI_W)), 1);
    localparam MASK_SEGS= `SEGS(MASK_W, SI_W);
    localparam IDX_SEGS = `SEGS(IDX_W, SI_W);
    localparam LL       = K*IDX_SEGS + MASK_SEGS;   // LUT (transmission) latency

    wire            clk;        // clock input
    reg             rst;        // sync reset input -- must assert rst for >N cycles
    reg  `V(SI_W)   si;         // sync LUTs' configuration segments input stream
    reg  `V(I)      inputs;     // sync FPGA inputs

    // register the core inputs for best timing margins and least surprise
    assign clk = io_in[0];
    always @(posedge clk)
        {inputs,si,rst} <= io_in[7:1];

    `comb`V(O)      outputs;    // last O LUT outputs, clocked into io_out[O-1:0] once per N LUTs * LL cycles/LUT
    `comb           debug;      // debug output -- stream of evaluated LUT inputs and outputs

    reg  `V(N)      luts;       // last N LUT outputs; shuffling circular shift register
    reg             q;          // Q: most recent half LUT output

    reg  `V(SR_W)   sr;         // input shift reg of LUT input index (k!=K)
    wire `V(IDX_W)  idx = {sr,si};  // current input index, received big-endian
    reg  `V(K)      ins;        // LUT input values; shift register
    reg             lut_q;      // LUT output register
    reg             half_q;     // half-LUT output register

    // control FSM
    reg  `V(N_W)    n;          // LUT counter; n in [0,N)
    reg  `V(K_W)    k;          // LUT input index counter; k in [0,K]: k!=K => receiving an index; k==K => receiving a LUT mask
    reg  `V(SEGS_W) seg;        // input segment counter; [0,IDX_SEGS) if k!=K; [0,MASK_SEGS) if k==K

    `comb`V(N+I+3)  all_in;     // all possibe LUT inputs: special inputs, FPGA inputs, recent LUT outputs
    `comb           in;         // a LUT input; valid when k!=K && seg==IDX_SEGS-1
    `comb           lut_ce;     // LUT evaluation performed this cycle
    `comb           lut;        // LUT output
    `comb           half_ce;    // half-LUT evaluation performed this cycle
    `comb           half;       // half-LUT output
    `comb           lut_in;     // 'luts' shift register input

    integer         j;

    always @* begin
        // evaluate a LUT input; 0 => 0; 1 => 1; 2 => Q; 3 => inputs[0]; ...; N prior LUT outputs
        all_in = {luts,inputs,q,1'b1,1'b0};
        in = all_in[idx];

        // evaluate a LUT output and/or half output
        lut_ce  = 1'b0;
        half_ce = 1'b0;
        lut     = lut_q;
        half    = half_q;
        if (!rst && k == K) begin
            // Received a mask segment.
            // Check if this segment is addressed by the inputs vector 'ins'.
            //
            // In comparisons below, we complement the LUT mask segment counter (i.e., ~seg),
            // because segments are numbered 0, 1, ..., MASK_SEGS-1, whereas the
            // LUT mask segments are received on 'si'in big-endian order.

            if (ins[K-1:$clog2(SI_W)] == ~seg) begin
                // ins selects a LUT mask bit in this segment
                lut_ce = 1'b1;
                lut = si[ins[$clog2(SI_W)-1:0]];
            end
            if ({1'b0,ins[K-2:$clog2(SI_W)]} == ~seg) begin
                // ins[] selects a lower half LUT mask bit in this segment
                half_ce = 1'b1;
                half = si[ins[$clog2(SI_W)-1:0]];
            end
        end

        lut_in = rst ? 1'b0 : (k == K && seg == MASK_SEGS-1) ? lut : luts[N-1];

        // locate last O LUT outputs in the luts shuffling circular shift register (uses 0 gates)
        outputs[0] = lut;
        for (j = 1; j < O; j = j + 1) begin
            outputs[j] = luts[(LL*j-1) % N];
        end

        // output evaluated LUT inputs, evaluated LUT outputs, or prior LUT shift register outputs
        if (rst)
            debug = 1'b0;
        else if (k != K && seg == IDX_SEGS-1)
            debug = in;         // LUT input, valid this cycle
        else if (k == K && seg == MASK_SEGS-1)
            debug = lut;        // LUT output, valid this cycle
        else
            debug = 1'b0;
    end

    always @(posedge clk) begin
        sr <= {sr,si};          // always collect input segments
        luts <= {luts,lut_in};  // always shuffle / inject LUT outputs

        io_out[7] <= debug;

        // Retain most recently seen LUT and half-LUT output values;
        // these are used (as combinational signals 'lut' and 'half')
        // as the last segment of the LUT mask is finally received
        // (i.e. when k == K && seg == MASK_SEGS-1).
        lut_q  <= rst ? 1'b0 : lut_ce  ? lut  : lut_q;
        half_q <= rst ? 1'b0 : half_ce ? half : half_q;

        if (rst) begin
            ins <= '0;
            n <= '0;
            k <= '0;
            seg <= '0;
            q <= 1'b0;
            // serial reset (eventually luts=='0 and thus outputs=='0)
            io_out[O-1:0] <= outputs;
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
            // LUT mask segment
            if (seg == MASK_SEGS-1) begin
                // final LUT mask segment -- "evaluate" the LUT and half-LUT.
                // luts <= {luts,lut_in}; -- see above "always shuffle ..."
                q <= half;

                // all LUTs evaluated: update FPGA outputs
                if (n == N-1)
                    io_out[O-1:0] <= outputs;

                n <= (n == N-1) ? '0 : (n + 1'b1);
                k <= '0;
                seg <= '0;
            end else begin
                seg <= seg + 1'b1;
            end
        end
    end
endmodule
