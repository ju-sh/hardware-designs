interface arbiter_if #(
    parameter COUNT = 2
);

    logic clk;
    logic rst;
    // logic [COUNT-1:0] lock;
    logic [COUNT-1:0] req;   // requests
    logic [COUNT-1:0] grt;   // grant
    logic [COUNT-1:0] ack;   // acknowledgement

    modport arb_mp (
        input clk;
        input rst;
        input req;
        input ack;
        output grt;
    );

endinterface



