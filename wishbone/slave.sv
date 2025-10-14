interface slave_if #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
);

    // Input signals
    logic clk_i;
    logic rst_i;
    logic [DATA_WIDTH-1:0] dat_i;
    logic tgd_i;

    logic [ADDR_WIDTH-1:0] adr_i;
    logic cyc_i;
    logic lock_i;
    logic [(DATA_WIDTH/8)-1:0] sel_i;
    logic stb_i;
    logic tga_i;
    logic tgc_i;
    logic we_i;

    // Output signals
    logic [DATA_WIDTH-1:0] dat_o;
    logic tgd_o;

    logic ack_o;
    logic stall_o;
    logic err_o;
    logic rty_i;

    modport slave_mp (
        input clk_i;
        input rst_i;
        input dat_i;
        input tgd_i;
        input adr_i;
        input cyc_i;
        input lock_i;
        input sel_i;
        input stb_i;
        input tga_i;
        input tgc_i;
        input we_i;

        output dat_o;
        output tgd_o;
        output ack_o;
        output stall_o;
        output err_o;
        output rty_i;
    );

endinterface

