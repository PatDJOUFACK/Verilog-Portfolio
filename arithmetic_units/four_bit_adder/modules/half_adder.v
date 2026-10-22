`timescale 1ns/1ps

module half_adder(
    input a, 
    input b,
    output sum,
    output carry
);  

   xor_gate xor1(
    .a(a),
    .b(b),
    .y(sum)
   );

   and_gate and1(
    .a(a),
    .b(b),
    .y(carry)
   );

endmodule