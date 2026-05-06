class adder_env extends uvm_env;
  `uvm_component_utils(adder_env)
  adder_agent agnt;
  adder_scoreboard scb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt = adder_agent::type_id::create("agnt", this);
    scb = adder_scoreboard::type_id::create("scb", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.aport.connect(scb.item_collected_export);
  endfunction: connect_phase
endclass: adder_env
