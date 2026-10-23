`timescale 1ns/1ps

module timer (
    input clk,
    input reset,
    input enable,
    output reg [1:0] count,
    output reg done
);
    always @(posedge clk) begin

        if (reset) begin
            count <= 2'b00;
            done  <= 1'b0;
        end

        else if (enable) begin

            if (count == 2'b11) begin
                done <= 1'b1;
            end

            else begin
                count <= count + 1'b1;
                done  <= 1'b0;
            end

        end

        else begin
            count <= 2'b00;
            done  <= 1'b0;
        end

    end

endmodule