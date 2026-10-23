# Timer Sequence Controller

## 1. Project Overview
This project implements a timer and a finite state machine (FSM) using classic Verilog. The sequence controller instantiates a timer module and uses its completion signal to control the execution sequence.

The project demonstrates sequential logic, module instantiation, state transitions, and testbench-based verification.

## 2. Features
- Classic Verilog compatible with Icarus Verilog
- A 2-bit timer counter
- A finite state machine with four states
- Hierarchical module instantiation
- Separate testbenches for the timer and the sequence controller
- Automated output checks and simulation waveforms

## 3. Architecture
The design consists of two RTL modules:

`timer.v` implements the timer counter and its completion signal.

`sequence_controller.v` implements the FSM and instantiates the timer.

The controller uses the timer's completion signal to determine when to leave the RUN state.

## 4. FSM States
The controller uses four states:

| State	| Description |
|---|---|
| `IDLE` | The controller waits for a start request. |
| `LOAD` | The controller prepares to start the timer. |
| `RUN` | The timer operates while the controller is running. |
| `DONE` | The controller indicates completion before returning to IDLE. |

## 5. File Structure

```text
timer_sequence_controller/
├── README.md
├── timer.v
├── sequence_controller.v
├── tb_timer.v
└── tb_sequence_controller.v
```

## 6. Requirements
- **Icarus Verilog** (`iverilog` and `vvp`)
- A terminal with access to the project directory
- GTKWave (optional, for waveform inspection)

## 7. Compilation
Run the following commands from the project directory:

Compile the timer testbench:

```bash
iverilog -g2005 -Wall -s tb_timer \
  -o /tmp/timer_check.vvp \
  timer.v tb_timer.v
```

Compile the controller testbench:

```bash
iverilog -g2005 -Wall -s tb_sequence_controller \
  -o /tmp/controller_check.vvp \
  timer.v sequence_controller.v tb_sequence_controller.v
```

## 8. Simulation
Run the timer testbench:

```bash
vvp /tmp/timer_check.vvp
```

Run the controller testbench:

```bash
vvp /tmp/controller_check.vvp
```

Both testbenches generate VCD waveform files in the current working directory.

## 9. Verification

The timer testbench checks reset, counter progression, timer completion, and disable behavior.

The controller testbench checks reset, the LOAD-to-RUN transition, controller operation, timer completion, the RUN-to-DONE transition, and the DONE-to-IDLE transition.

Both testbenches completed successfully in the verified simulation runs.

Expected completion messages:

```text
ALL TIMER TESTS PASSED
ALL TESTS PASSED
```

## 10. Design Notes

The timer and controller are separate modules to demonstrate hierarchical design and reuse.

The controller relies on the timer's completion signal to coordinate its state transitions. Separate testbenches make it possible to verify the timer and the integrated controller independently.

This project is intended as a practical exercise in classic Verilog RTL design, finite state machines, and simulation-based verification.
