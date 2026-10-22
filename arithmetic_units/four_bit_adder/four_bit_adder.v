`timescale 1ns/1ps

module four_bit_adder(
    input [3:0] a,
    input [3:0] b,
    input carry_in,
    output [3:0] sum,
    output carry_out
);

    // Intermediate carry signals between full adders
    wire carry1;
    wire carry2;
    wire carry3;

    // Least significant bit
    full_adder fa0(
        .a(a[0]),
        .b(b[0]),
        .carry_in(carry_in),
        .sum(sum[0]),
        .carry_out(carry1)
    );

    // Second bit
    full_adder fa1(
        .a(a[1]),
        .b(b[1]),
        .carry_in(carry1),
        .sum(sum[1]),
        .carry_out(carry2)
    );

    // Third bit
    full_adder fa2(
        .a(a[2]),
        .b(b[2]),
        .carry_in(carry2),
        .sum(sum[2]),
        .carry_out(carry3)
    );

    // Most significant bit
    full_adder fa3(
        .a(a[3]),
        .b(b[3]),
        .carry_in(carry3),
        .sum(sum[3]),
        .carry_out(carry_out)
    );

endmodule