module top;
  logic clk;
  initial clk = 0;
  always #5 clk = ~clk;  // 100MHz clock if one time step is 1ns

  // Instantiate the interface
  adder_if vif(clk);

  // DUT instantiation
   adder dut (vif);

  initial begin
    uvm_config_db #(virtual adder_if)::set(null, "*", "vif", vif);
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
    uvm_top.finish_on_completion = 1;
    run_test("adder_test");
  end
endmodule: top 
