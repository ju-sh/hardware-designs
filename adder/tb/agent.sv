class adder_agent extends uvm_agent;
  `uvm_component_utils(adder_agent)

  adder_sequencer sqr;
  adder_driver dvr;
  adder_monitor mon;

  virtual adder_if vif;
  uvm_analysis_port #(adder_seq_item) aport;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("AGENT", "Could not get virtual interface from config DB")
    end

    aport = new("aport", this);
    sqr = adder_sequencer::type_id::create("sqr", this);
    dvr = adder_driver::type_id::create("dvr" , this);
    mon = adder_monitor::type_id::create("mon" , this );

    // Pass the virtual interface to components
    uvm_config_db#(virtual adder_if.driver)::set(this, "dvr", "vif", vif.driver);
    uvm_config_db#(virtual adder_if.monitor)::set(this, "mon", "vif", vif.monitor);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    dvr.seq_item_port.connect(sqr.seq_item_export);
    mon.aport.connect(aport);
  endfunction: connect_phase
endclass: adder_agent
