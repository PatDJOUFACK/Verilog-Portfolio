# FSM Register Sequence

## 1. Project Overview

This project implements a finite state machine (FSM) and a 4-bit shift register using classic Verilog HDL.

The FSM controls the loading and shifting of a single logic 1 through the register. The design demonstrates sequential logic, state transitions, register updates, and simulation-based verification.

## 2. Features
- Classic Verilog compatible with Icarus Verilog
- Six-state finite state machine
- 4-bit shift register
- Synchronous reset
- Start-controlled sequence
- Testbench with automatic output checks
- VCD waveform generation for simulation analysis

## 3. Architecture

The design consists of two main parts within `sequence_register.v`:

- **Next-state logic:** Determines the next FSM state based on the current state and the start input.
- **State and data registers:** Update the current state and the 4-bit output register `q` on the rising edge of the clock.

When the controller reaches `LOAD`, the register loads `0001`. During the subsequent shift states, the single 1 moves left through the register.

## 4. FSM States

| State | Encoding | Description |
|---|---|---|
| `IDLE` | `000` | Waits for a start request. |
| `LOAD` | `001` | Loads `0001` into the register. |
| `SHIFT1` | `010` | Shifts the register left once. |
| `SHIFT2` | `011` | Shifts the register left again. |
| `SHIFT3` | `100` | Performs the final shift. |
| `DONE` | `101` | Completes the sequence before returning to `IDLE`. |

## 5. File Structure
```text
fsm_register_sequence/
├── README.md
├── sequence_register.v
└── tb_sequence_register.v
```

## 6. Requirements
- **Icarus Verilog** (`iverilog` and `vvp`)
- A terminal with access to the project directory
- GTKWave (optional, for waveform inspection)

## 7. Compilation

Run the following commands from the project directory:

```bash
mkdir -p /tmp/verilog_checks/fsm_register_sequence

iverilog -g2005 -Wall -s tb_sequence_register \
  -o /tmp/verilog_checks/fsm_register_sequence/sequence_register_check.vvp \
  sequence_register.v tb_sequence_register.v
```

## 8. Simulation

Run the simulation from the temporary output directory:

```bash
cd /tmp/verilog_checks/fsm_register_sequence
vvp sequence_register_check.vvp
```

The testbench generates `sequence_register.vcd` in the current working directory. The temporary directory keeps simulation artifacts out of the project source directory.

## 9. Verification

The testbench checks the expected FSM state and register value at seven points:

- `Reset`
- `LOAD`
- `SHIFT1`
- `SHIFT2`
- `SHIFT3`
- `DONE`
- `Return to IDLE`

Each check uses conditional statements to compare the actual outputs with the expected values. The testbench counts errors and prints a final summary.

Successful simulation output:

```text
ALL TESTS PASSED
```

## 10. Design Notes

The FSM uses separate next-state logic and sequential logic for state and register updates.

The register retains its value when the FSM returns to IDLE. The testbench also displays signal values and simulation times to help inspect the sequence.

This project is a practical exercise in classic Verilog, finite state machines, shift registers, and simulation-based verification.
