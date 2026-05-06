class adder_test extends uvm_test;
  `uvm_component_utils(adder_test)
  adder_env env;
  adder_sequence seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = adder_env::type_id::create("env", this);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = adder_sequence::type_id::create("seq");
    seq.start(env.agnt.sqr);
    phase.drop_objection(this);
  endtask: run_phase
endclass: adder_test
