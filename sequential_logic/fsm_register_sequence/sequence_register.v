`timescale 1ns/1ps

module sequence_register (
    input clk,
    input reset,
    input start,
    output reg [3:0] q,
    output reg [2:0] state
);

    localparam IDLE = 3'b000;
    localparam LOAD = 3'b001;
    localparam SHIFT1 = 3'b010;
    localparam SHIFT2 = 3'b011;
    localparam SHIFT3 = 3'b100;
    localparam DONE = 3'b101;

    reg [2:0] next_state;

    // Next_State_Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (start)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            end

            LOAD:
                next_state = SHIFT1;

            SHIFT1:
                next_state = SHIFT2;

            SHIFT2:
                next_state = SHIFT3;

            SHIFT3:
                next_state = DONE;

            DONE:
                next_state = IDLE;

            default:
                next_state = IDLE;
        endcase
    end

    // State Register and Data Register
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            q <= 4'b0000;
        end

        else begin
            state <= next_state;

            case (state)
                LOAD:
                    q <= 4'b0001;
                SHIFT1,
                SHIFT2,
                SHIFT3:
                    q <= {q[2:0], 1'b0};

                default:
                    q <= q;
            endcase
        end
    end
endmodule
