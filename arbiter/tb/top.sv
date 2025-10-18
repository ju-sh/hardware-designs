`timescale 1ns/1ps

// `include "arbiter.sv"

module arbiter_top;
    parameter int COUNT = 4;


    // Declare an arbiter interface
    // An interface is like a bunch of wires
    arbiter_if #(COUNT) arb_if ();

    arbiter #(
        .COUNT (COUNT)
    ) tb (
        .arb_if (arb_if)
    );

    // Set up a 10 ns clock
    initial arb_if.clk = 0;
    always #5 arb_if.clk = ~arb_if.clk;
  
    task automatic wait_cycles(input int cyc_count);
        // Wait for cyc_count clock cycles
        repeat (cyc_count) @(posedge arb_if.clk);
    endtask

    task automatic test_request(
        input logic [COUNT-1:0] req,
        input int wait_period = 1
    );
        arb_if.req = req;
        wait_cycles(wait_period);
    
        assert (arb_if.grt == req)
            else $error("ASSERTION FAILED: grt != %b at time %0t", req, $time);
    
        arb_if.ack = req;
        wait_cycles(wait_period);
        arb_if.ack = '0;
    
        assert (arb_if.grt == '0)
          else $error("ASSERTION FAILED (%b): grt != 0 at time %0t", arb_if.grt, $time);

      arb_if.req = '0;
      arb_if.ack = '0;

    endtask

    initial begin
        // Initialize
        arb_if.rst = 1;
        arb_if.req = '0;
        arb_if.ack = '0;

        wait_cycles(2);
        arb_if.rst = 0;
      
        test_request(4'b0100);
              wait_cycles(2);

        test_request(4'b0010);
        test_request(4'b0001);
      
        wait_cycles(2);
        arb_if.req = '0;
        arb_if.ack = '0;
        wait_cycles(2);
      
        //  arb_if.req = 4'b0100;
        //  wait_cycles(2);
        //  assert (arb_if.grt == 4'b0100)
        //      else $fatal("ASSERTION FAILED: grnt != 0100 at time %0t", $time);
        //  arb_if.ack = 4'b0100;
        //  wait_cycles(1);
        //  assert (arb_if.grt == '0)
        //      else $fatal("ASSERTION FAILED: grnt != 0 at time %0t", $time);
	// 
        //  arb_if.req = 4'b0010;
        //  wait_cycles(2);
        //  assert (arb_if.grt == 4'b0010)
        //      else $fatal("ASSERTION FAILED: grnt != 0010 at time %0t", $time);
        //  arb_if.ack = 4'b0010;
        //  wait_cycles(1);
        //  assert (arb_if.grt == '0)
        //      else $fatal("ASSERTION FAILED: grnt != 0 at time %0t", $time);

        //wait_cycles(2);
        $finish;
        //#100 $finish;

      
        /* #10 arb_if.req = 4'b0001; */
        /* #20 arb_if.req = 4'b1010; */
        /* #30 arb_if.req = 4'b0000; */
        /* #20 arb_if.req = 4'b0100; */
        //#80 $finish;
    end


    // Dump vcd for wave form
    initial begin
        $dumpfile("arbiter.vcd");
        $dumpvars(0, arbiter_top);
    end

endmodule
