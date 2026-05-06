# 4-bit Adder

A bare minimal demo to demonstrate basic workflow in a design using UVM testbench.

As used at edaplayground with:
 - Siemens Questa 2025.2
 - Options: `-voptargs=+acc=npr`

Originally had only two files, one each for the design and the testbench.
Split it up into smaller files for easier maintenance.

## Possible improvements

Got these warnings when compiling:

```
 ** Warning: (vsim-8637) A modport ('DRIVER') should not be used in a hierarchical path.
#    Time: 0 ps  Iteration: 0  Region: /uvm_pkg_sv_unit File: testbench.sv Line: 178
# ** Warning: (vsim-8637) A modport ('MONITOR') should not be used in a hierarchical path.
#    Time: 0 ps  Iteration: 0  Region: /uvm_pkg_sv_unit File: testbench.sv Line: 179
```
