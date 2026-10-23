`timescale 1ns/1ps

module tb_sequence_controller;

    reg clk;
    reg reset;
    reg start;

    wire running;
    wire done;

    integer errors;

    sequence_controller uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .running(running),
        .done(done)
    );

    always #5 clk = ~clk;

    task check_outputs;
        input expected_running;
        input expected_done;
        input [8*40-1:0] test_name;
        begin
            if (running !== expected_running || done !== expected_done) begin
                $display("FAIL: %0s", test_name);
                $display("  Expected: running=%b done=%b", expected_running, expected_done);
                $display("  Actual:   running=%b done=%b", running, done);
                errors = errors + 1;
            end
            else begin
                $display("PASS: %0s", test_name);
            end
        end
    endtask


    initial begin

        $dumpfile("sequence_controller.vcd");
        $dumpvars(0, tb_sequence_controller);

        clk   = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        errors = 0;

        // Check Reset
        @(posedge clk);
        #1;
        check_outputs(1'b0, 1'b0, "reset");

        reset = 1'b0;

        // Start the sequence
        start = 1'b1;
        @(posedge clk);
        #1;
        start = 1'b0;

        // Check transition from LOAD to RUN
        @(posedge clk);
        #1;
        check_outputs(1'b1, 1'b0, "LOAD to RUN");

        // Check that the Controller remains in RUN
        repeat (3) begin
            @(posedge clk);
            #1;
            check_outputs(1'b1, 1'b0, "Controller running");
        end


        // Verify timer completion before the controller transition
    @(posedge clk);
    #1;

    if (uut.timer_inst.done !== 1'b1) begin
        $display("FAIL: Timer completion");
        $display("  Expected timer_done=1");
        $display("  Actual:   timer_done=%b", uut.timer_inst.done);
        errors = errors + 1;
    end
    else begin
        $display("PASS: Timer completion");
    end

    check_outputs(1'b1, 1'b0, "Timer completion pending");

        // Check completion
        @(posedge clk);
        #1;
        check_outputs(1'b0, 1'b1, "RUN to DONE");

        // Check return to IDLE
        @(posedge clk);
        #1;
        check_outputs(1'b0, 1'b0, "DONE to IDLE");

        // Report final result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        #10;
        $finish;
    end
endmodule