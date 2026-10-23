`timescale 1ns/1ps

module tb_sequence_register ;
    reg clk;
    reg reset;
    reg start;
    wire [3:0] q;
    wire [2:0] state;

    integer errors;

    sequence_register uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .q(q),
        .state(state)
    );

    // Clock: period = 10 ns
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sequence_register.vcd");
        $dumpvars(0, tb_sequence_register);

        clk = 0;
        reset = 1;
        start = 0;
        errors = 0;

        // Check Reset
        @(posedge clk);
        #1;
        if (state == 3'b000 && q == 4'b0000)
            $display("PASS: Reset");
        else begin
            $display("FAIL: Reset, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        reset = 0;
        start = 1;

        // Check LOAD state
        @(posedge clk);
        #1;
        if (state == 3'b001 && q == 4'b0000)
            $display("PASS: LOAD");
        else begin
            $display("FAIL: LOAD, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        start = 0;

        // Check SHIFT1
        @(posedge clk);
        #1;
        if (state == 3'b010 && q == 4'b0001)
            $display("PASS: SHIFT1");
        else begin
            $display("FAIL: SHIFT1, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        // Check SHIFT2
        @(posedge clk);
        #1;
        if (state == 3'b011 && q == 4'b0010)
            $display("PASS: SHIFT2");
        else begin
            $display("FAIL: SHIFT2, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        // Check SHIFT3
        @(posedge clk);
        #1;
        if (state == 3'b100 && q == 4'b0100)
            $display("PASS: SHIFT3");
        else begin
            $display("FAIL: SHIFT3, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        // Check DONE
        @(posedge clk);
        #1;
        if (state == 3'b101 && q == 4'b1000)
            $display("PASS: DONE");
        else begin
            $display("FAIL: DONE, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        // Check return to IDLE
        @(posedge clk);
        #1;
        if (state == 3'b000 && q == 4'b1000)
            $display("PASS: Return to IDLE");
        else begin
            $display("FAIL: Return to IDLE, state=%b q=%b", state, q);
            errors = errors + 1;
        end

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

    // Display signal values in the terminal for observation
    always @(posedge clk) begin
        #1;
        $display(
            "t=%0t state=%b start=%b q=%b",
            $time,
            uut.state,
            start,
            q
        );
    end

endmodule
