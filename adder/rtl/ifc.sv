interface adder_if(
  input logic clk
);
  logic [3:0] a;
  logic [3:0] b;
  logic       cin;
  logic [3:0] s;
  logic       cout;

  clocking drv_cb @(posedge clk);
    output a, b, cin;
    // input  s, cout;
  endclocking

  clocking mon_cb @(posedge clk);
    input a, b, cin, s, cout;
  endclocking
  
  modport driver  (clocking drv_cb, input clk);
  modport monitor (clocking mon_cb, input clk);
  modport dut (
    input clk,
    input a,
    input b,
    input cin,
    output s,
    output cout
  );

  property adder_correct;
    @(posedge clk)
    // {cout, s} == (a + b + cin);
    !$isunknown({a,b,cin}) |-> 
      (!$isunknown({cout,s}) && ({cout, s} == (a + b + cin)));
  endproperty
  assert property(adder_correct);
endinterface
