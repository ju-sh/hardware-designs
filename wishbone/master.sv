interface master_if #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
);

    // Input signals
    logic clk_i;
    logic rst_i;
    logic [DATA_WIDTH-1:0] dat_i;
    logic tgd_i;

    logic ack_i;
    logic stall_i;
    logic err_i;
    logic rty_i;


    // Output signals
    logic [DATA_WIDTH-1:0] dat_o;
    logic tgd_o;

    logic [ADDR_WIDTH-1:0] adr_o;
    logic cyc_o;
    logic lock_o;
    logic [(DATA_WIDTH/8)-1:0] sel_o;
    logic stb_o;
    logic tga_o;
    logic tgc_o;
    logic we_o;

    modport master_mp (
        input clk_i;
        input rst_i;
        input dat_i;
        input tgd_i;
        input ack_i;
        input stall_i;
        input err_i;
        input rty_i;
       
        output dat_o;
        output tgd_o;
        output adr_o;
        output cyc_o;
        output lock_o;
        output sel_o;
        output stb_o;
        output tga_o;
        output tgc_o;
        output we_o;
    );

endinterface


