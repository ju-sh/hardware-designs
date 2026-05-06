class adder_monitor extends uvm_monitor;
  `uvm_component_utils(adder_monitor)

  uvm_analysis_port #(adder_seq_item) aport;
  virtual adder_if.monitor vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    aport = new("aport", this);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_if.monitor)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MON", "Could not get vif from config_db")
    end
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      adder_seq_item tx;
      tx = adder_seq_item::type_id::create("tx");

      // @(posedge vif.clk);
      @(vif.mon_cb);

      // Sample DUT inputs and outputs using monitor clocking block
      tx.a    = vif.mon_cb.a;
      tx.b    = vif.mon_cb.b;
      tx.cin  = vif.mon_cb.cin;
      tx.s    = vif.mon_cb.s;
      tx.cout = vif.mon_cb.cout;

      // Send out transaction via the analysis port
      aport.write(tx);

      `uvm_info(
        "MON",
        $sformatf(
          "Observed: a=%0d b=%0d cin=%0d -> s=%0d, cout=%0d",
          tx.a, tx.b, tx.cin, tx.s, tx.cout),
        UVM_LOW)
    end
  endtask: run_phase
endclass: adder_monitor
