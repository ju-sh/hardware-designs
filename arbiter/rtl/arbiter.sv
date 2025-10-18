`timescale 1ns/1ps

// `include "arbiter_if.sv"

module arbiter #(parameter int COUNT = 4) (
    arbiter_if.dut arb_if
);

    typedef enum logic [1:0] {
        IDLE,
        BUSY
    } state_t;

    // Assumptions:
    // - Only one IP has access at a time
    // - Round-robin

    logic [$clog2(COUNT)-1:0] cur_idx;
    logic [COUNT-1:0] nxt_idx;
    state_t state;

    always_comb begin
        // Avoid inferred latch
        nxt_idx = '0;

        for(int i=0; i<COUNT; ++i) begin
            automatic int idx = (cur_idx + i + 1) %  COUNT;
            if(arb_if.req[idx]) begin
                nxt_idx = 1 << idx;
                break;
            end
        end
    end

    always_ff @(posedge arb_if.clk or posedge arb_if.rst) begin
        if (arb_if.rst) begin
            cur_idx <= '0;
            //nxt_idx <= '0;
            state <= IDLE;
        end else begin
            unique case(state)
                IDLE: begin
                    if (|arb_if.req) begin
                        // At least one request access
                        arb_if.grt <= nxt_idx;
                        cur_idx <= $clog2(nxt_idx);
                        state <= BUSY;
                    end else begin
                        // No one needs access
                        arb_if.grt <= '0;
                    end
                end
                BUSY: begin
                    if (|(arb_if.grt & arb_if.ack)) begin
                    /* if (|((arb_if.grt >> cur_idx) & 1)) begin */
                        if(!(|nxt_idx)) begin
                            // No other requests
                            arb_if.grt <= '0;
                            state <= IDLE;
                        end else begin
                            arb_if.grt <= nxt_idx;
                            cur_idx <= $clog2(nxt_idx);
                        end
                    end
                end
                /* default: begin */
                /*     state <= IDLE; */
                /* end */
            endcase
        end
    end
endmodule
