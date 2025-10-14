`include "master.sv"
`include "slave_if.sv"

interface wishbone_if #(
    parameter int NUM_MASTERS = 4,
    parameter int NUM_SLAVES = 2,
    parameter int ADDR_WIDTH = 32,
    parameter int DATA_WIDTH = 32
);

    // Clock and reset
    logic clk;
    logic rst;

    // Master side (shared signals)
    logic                   cyc;
    logic                   stb;
    logic                   we;
    logic [ADDR_WIDTH-1:0]  adr;
    logic [DATA_WIDTH-1:0]  dat_o;
    logic [(DATA_WIDTH/8)-1:0] sel;

    logic [DATA_WIDTH-1:0]  dat_i;
    logic                   ack;
    logic                   err;
    logic                   rty;

    slave_if #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) slave[NUM_SLAVES] ();

    master_if #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) slave[NUM_MASTERS] ();

endinterface
