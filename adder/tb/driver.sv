class adder_driver extends uvm_driver#(adder_seq_item);
  `uvm_component_utils(adder_driver)
  virtual adder_if.driver vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_if.driver)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "Could not get vif from config_db")
    end
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    forever begin
      adder_seq_item tx;

      seq_item_port.get_next_item(tx);
      @(vif.drv_cb);
      vif.drv_cb.a <= tx.a;
      vif.drv_cb.b <= tx.b;
      vif.drv_cb.cin <= tx.cin;
      // @(posedge vif.clk);
      seq_item_port.item_done();
    end
  endtask: run_phase
endclass: adder_driver
