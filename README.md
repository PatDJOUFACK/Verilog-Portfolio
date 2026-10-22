# Verilog Portfolio

## Overview

This repository contains selected digital design projects implemented in classical Verilog HDL. The projects demonstrate fundamental RTL design techniques, structural modeling, simulation, and automated functional verification.

The designs are developed and simulated using Icarus Verilog, with GTKWave available for waveform inspection.

## Projects

### Arithmetic Units
- **[4-Bit Ripple-Carry Adder](arithmetic_units/four_bit_adder/README.md)** — A structural 4-bit unsigned adder built from reusable half-adder and full-adder modules. Includes a testbench with five test cases.

## Tools
- Verilog HDL (classical Verilog)
- Icarus Verilog (iverilog and vvp)
- GTKWave
- Git

## Repository Structure
```text
Verilog-Portfolio/
├── README.md
├── .gitignore
└── arithmetic_units/
    └── four_bit_adder/
        ├── README.md
        ├── four_bit_adder.v
        ├── tb_four_bit_adder.v
        └── modules/
            ├── full_adder.v
            ├── half_adder.v
            ├── or_gate.v
            ├── and_gate.v
            └── xor_gate.v
```

## Project Goals

The goal of this portfolio is to document practical digital design work, including RTL implementation, modular architecture, testbench development, simulation, and version control.

Additional projects will be added as they are completed and verified.
