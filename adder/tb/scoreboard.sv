class adder_scoreboard extends uvm_scoreboard;
  // `uvm_component_param_utils(adder_scoreboard)
  `uvm_component_utils(adder_scoreboard)

  // aport to receive tx from the monitor
  uvm_analysis_imp #(adder_seq_item, adder_scoreboard) item_collected_export;

  int pass_count = 0;
  int fail_count = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
  endfunction

  // Called whenever monitor sends an item
  virtual function void write(adder_seq_item pkt);
    logic [3:0] expected_s;
    logic       expected_cout;

    // Golden model
    {expected_cout, expected_s} = pkt.a + pkt.b + pkt.cin;

    // Check actual vs. expected
    if ((pkt.s === expected_s) && (pkt.cout === expected_cout)) begin
      `uvm_info("SCB_PASS", $sformatf("MATCH! A:%0d B:%0d Cin:%0d | Sum:%0d Cout:%0b", 
                pkt.a, pkt.b, pkt.cin, pkt.s, pkt.cout), UVM_LOW)
      pass_count++;
    end else begin
      `uvm_error("SCB_FAIL", $sformatf("MISMATCH! A:%0d B:%0d Cin:%0d | Exp: Sum=%0d Cout=%0b, Act: Sum=%0d Cout=%0b", 
                pkt.a, pkt.b, pkt.cin, expected_s, expected_cout, pkt.s, pkt.cout))
      fail_count++;
    end
  endfunction

  // Final scorecard
  virtual function void report_phase(uvm_phase phase);
    `uvm_info("SCB_REPORT",
      $sformatf("Final Results -> Passed: %0d, Failed: %0d",
        pass_count, fail_count),
      UVM_LOW)
  endfunction
endclass: adder_scoreboard
