`timescale 1ns/1ps

interface arbiter_if #(
    parameter COUNT = 2
);

    logic clk;
    logic rst;
    // logic [COUNT-1:0] lock;
    logic [COUNT-1:0] req;   // requests
    logic [COUNT-1:0] ack;   // acknowledgement

    logic [COUNT-1:0] grt;   // grant

    modport dut (
        input clk,
        input rst,
        input req,
        input ack,
        output grt
    );

  
    modport tb (
        output clk,
        output rst,
        output req,
        output ack,
        input grt
    );

endinterface



