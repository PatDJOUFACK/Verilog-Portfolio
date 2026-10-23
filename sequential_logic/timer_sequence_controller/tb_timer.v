`timescale 1ns/1ps
module tb_timer ;
    reg clk;
    reg reset;
    reg enable;

    wire [1:0] count;
    wire done;

    integer errors;

    timer dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("timer.vcd");
        $dumpvars(0, tb_timer);

        clk = 1'b0;
        reset = 1'b1;
        enable = 1'b0;
        errors = 0;

        //Check reset
        @(posedge clk);
        #1;

        if (count !== 2'b00 || done !== 1'b0) begin
            $display("ERROR: Reset");
            errors = errors + 1;
        end
        else
            $display("PASS: Reset");

        reset = 1'b0;
        enable = 1'b1;

        //Count 00 -> 01
        @(posedge clk);
        #1;
        if (count !== 2'b01 || done !== 1'b0) begin
            $display("ERROR: Count 01");
            errors = errors + 1;
        end
        else
            $display("PASS: Count 01");

        //Count 01 -> 10
        @(posedge clk);
        #1;
        if(count !== 2'b10 || done !== 1'b0) begin
            $display("ERROR: Count 10");
            errors = errors + 1;
        end
        else
            $display("PASS: Count 10");

        // Count 10 -> 11
        @(posedge clk);
        #1;
        if(count !== 2'b11 || done !== 1'b0) begin
            $display("ERROR: Count 11");
            errors = errors + 1;
        end
        else
            $display("PASS: Count 11");

        //Next clock edge: Timer is done
        @(posedge clk);
        #1;
        if (count !== 2'b11 || done !==1'b1) begin
            $display("ERROR: Timer done");
            errors = errors + 1;
        end
        else
            $display("PASS: Timer done");

        // Check Disable
        enable = 1'b0;
        @(posedge clk);
        #1;
        if (count !== 2'b00 || done !== 1'b0) begin
            $display("ERROR: Disable");
            errors = errors + 1;
        end
        else
            $display("PASS: Disable");


        // Total result
        if (errors == 0)
            $display("ALL TIMER TESTS PASSED");
        else
            $display ("TIMER TESTS FAILED: %0d error(s)", errors);

        $finish;
    end
endmodule