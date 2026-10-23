# Verilog Portfolio

## Overview

This repository contains selected digital design projects implemented in classical Verilog HDL. The projects demonstrate fundamental RTL design techniques, structural modeling, sequential logic, finite state machines, simulation, and automated functional verification.

The designs are developed and simulated using Icarus Verilog, with GTKWave available for waveform inspection.

## Projects

### Arithmetic Units
- **[4-Bit Ripple-Carry Adder](arithmetic_units/four_bit_adder/README.md)** — A structural 4-bit unsigned adder built from reusable half-adder and full-adder modules. Includes a testbench with five test cases.

### Sequential Logic
- **[Timer Sequence Controller](sequential_logic/timer_sequence_controller/README.md)** - A timer and a finite state machine (FSM) implemented as separate, interconnected Verilog modules. Includes dedicated testbenches for the timer and the integrated controller.
- **[FSM Register Sequence](sequential_logic/fsm_register_controller/README.md)** - A six-state finite state machine controlling a 4-bit shift register. Includes synchronous reset and a testbench with automatic output checkes.

## Tools
- Verilog HDL (classical Verilog)
- Icarus Verilog (`iverilog` and `vvp`)
- GTKWave
- Git

## Repository Structure

```text

Verilog-Portfolio/
├── README.md
├── .gitignore
├── arithmetic_units/
│   └── four_bit_adder/
│       ├── README.md
│       ├── four_bit_adder.v
│       ├── tb_four_bit_adder.v
│       └── modules/
│           ├── full_adder.v
│           ├── half_adder.v
│           ├── or_gate.v
│           ├── and_gate.v
│           └── xor_gate.v
└── sequential_logic/
    ├── timer_sequence_controller/
    │   ├── README.md
    │   ├── timer.v
    │   ├── sequence_controller.v
    │   ├── tb_timer.v
    │   └── tb_sequence_controller.v
    └── fsm_register_sequence/
        ├── README.md
        ├── sequence_register.v
        └── tb_sequence_register.v
```

## Project Goals

The goal of this portfolio is to document practical digital design work, including RTL implementation, modular architecture, sequential logic, finite state machine design, testbench development, simulation, and version control.

Additional projects will be added as they are completed and verified.
