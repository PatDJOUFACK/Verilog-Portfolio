`timescale 1ns/1ps

module tb_four_bit_adder;
    reg [3:0] a;
    reg [3:0] b;
    reg carry_in;
    wire [3:0] sum;
    wire carry_out;
    
    integer errors;

    four_bit_adder dut(
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin

        $dumpfile("four_bit_adder.vcd");
        $dumpvars(0, tb_four_bit_adder);

        errors = 0;

        // 5 + 3 = 8
        a = 4'b0101;
        b = 4'b0011;
        carry_in = 1'b0;
        #10;

        if ({carry_out, sum} !== 5'b01000) begin
            $display("ERROR: 5 + 3");
            errors = errors + 1;
        end    
        else
            $display("PASS: 5 + 3");
        

        // 7 + 1 = 8
        a = 4'b0111;
        b = 4'b0001;
        carry_in = 1'b0;
        #10;

        if ({carry_out, sum} !== 5'b01000) begin
            $display("ERROR: 7 + 1");
            errors = errors + 1;
        end    
        else
            $display("PASS: 7 + 1");


        // 15 + 1 = 16
        a = 4'b1111;
        b = 4'b0001;
        carry_in = 1'b0;
        #10;

        if ({carry_out, sum} !== 5'b10000) begin
            $display("ERROR: 15 + 1");
            errors = errors + 1;
        end    
        else
            $display("PASS: 15 + 1");

        // 10 + 5 = 15
        a = 4'b1010;
        b = 4'b0101;
        carry_in = 1'b0;
        #10;

        if ({carry_out, sum} !== 5'b01111) begin
            $display("ERROR: 10 + 5");
            errors = errors + 1;
        end    
        else
            $display("PASS: 10 + 5");

         // 10 + 5 + 1 = 16
        a = 4'b1010;
        b = 4'b0101;
        carry_in = 1'b1;
        #10;

        if ({carry_out, sum} !== 5'b10000) begin
            $display("ERROR: 10 + 5 + 1");
            errors = errors + 1;
        end    
        else
            $display("PASS: 10 + 5 + 1");
        
        // Total result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        $finish;

    end

endmodule