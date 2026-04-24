module adder (
  adder_if.dut ifc
);
  assign {ifc.cout, ifc.s} = ifc.a + ifc.b + ifc.cin;
endmodule: adder
