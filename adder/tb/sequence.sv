import uvm_pkg::*;

class adder_seq_item extends uvm_sequence_item;
  `uvm_object_utils(adder_seq_item)
  rand logic [3:0] a;
  rand logic [3:0] b;
  rand logic cin;
  logic [3:0] s;
  logic cout;

  function new (string name = "adder_txn");
    super.new(name);
  endfunction: new

  /* virtual function string convert2string(); */
  /*     return $sformatf( */
  /*       "a=%0h, b=%0h, cin=%b -> s=%0h, cout=%b", */
  /*       a, b, cin, s, cout); */
  /* endfunction: convert2string */
endclass: adder_seq_item

class adder_sequence extends uvm_sequence #(adder_seq_item);
  `uvm_object_utils(adder_sequence)

  function new(string name = "adder_sequence");
    super.new(name);
  endfunction: new

  task body;
    adder_seq_item tx;

    repeat (10)
    begin
      tx = adder_seq_item::type_id::create("tx");

      start_item(tx); // sync with sequencer ??
      assert(tx.randomize());
      finish_item(tx);  // send seq to driver
    end
  endtask: body
endclass: adder_sequence

typedef uvm_sequencer#(adder_seq_item) adder_sequencer;
