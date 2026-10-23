`timescale 1ns/1ps

module sequence_controller (
    input clk,
    input reset,
    input start,

    output reg running,
    output reg done
);

    localparam IDLE = 2'b00;
    localparam LOAD = 2'b01;
    localparam RUN  = 2'b10;
    localparam DONE = 2'b11;

    reg [1:0] state;
    reg [1:0] next_state;

    reg timer_enable;
    wire timer_done;

    timer timer_inst (
        .clk(clk),
        .reset(reset),
        .enable(timer_enable),
        .count(),
        .done(timer_done)
    );

    // Zustandsregister
    always @(posedge clk) begin

        if (reset)
            state <= IDLE;
        else
            state <= next_state;

    end

    // FSM
    always @(*) begin

        next_state  = state;
        timer_enable = 1'b0;

        case (state)

            IDLE: begin
                if (start)
                    next_state = LOAD;
            end

            LOAD: begin
                next_state = RUN;
            end

            RUN: begin
                timer_enable = 1'b1;

                if (timer_done)
                    next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase

    end

    // Ausgangslogik
    always @(*) begin

        running = 1'b0;
        done    = 1'b0;

        case (state)

            RUN: begin
                running = 1'b1;
            end

            DONE: begin
                done = 1'b1;
            end

            default: begin
                running = 1'b0;
                done    = 1'b0;
            end

        endcase

    end

endmodule