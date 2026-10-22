# 4-BIT RIPPLE-CARRY ADDER

## 1. Project Overview

This project uses classical Verilog to implement a 4-bit ripple-carry adder. The implemented circuit adds two 4-bit unsigned inputs and an optional carry-in. The result is a 4-bit sum and a carry-out.

The design is built structurally from four full-adder modules.

## 2. Features

- 4-bit unsigned addition
- Carry-in and carry-out support
- Structural RTL design
- Reusable half-adder and full-adder modules
- Automated testbench with five test cases
- Simulation with Icarus Verilog

## 3. Architecture

The implemented adder consists of four cascaded full adders. Each stage calculates one sum bit and connects its carry-out to the carry-in of the next stage.
The LSB (least significant bit) is processed first. The carry then propagates through the four stages to yield the final carry-out.

## 4. Module Hierarchy

```text
four_bit_adder
└── full_adder (4 instances)
    ├── half_adder (2 instances per full adder)
    │   ├── xor_gate
    │   └── and_gate
    └── or_gate
```

## 5. File Structure

```text 
four_bit_adder/
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

## 6. Requirements

- Icarus Verilog (iverilog and vvp)
- GTKWave (optional, for waveform inspection)

## 7. Compilation

Run the following command from the project directory:

```bash
iverilog -g2005 -Wall -o four_bit_adder.vvp \
    four_bit_adder.v \
    tb_four_bit_adder.v \
    modules/full_adder.v \
    modules/half_adder.v \
    modules/or_gate.v \
    modules/and_gate.v \
    modules/xor_gate.v
```

## 8. Simulation

After compilation, run the following command to display the result of the simulation in the terminal:

```bash
vvp four_bit_adder.vvp
```

The testbench also generates four_bit_adder.vcd, which can optionally be inspected with GTKWave. For this inspection run the following command:

```bash
gtkwave four_bit_adder.vcd
```

## 9. Test Cases

| Test Case | Expected Result |
|---|---:|
| 5 + 3 | 8 |
| 7 + 1 | 8 |
| 15 + 1 | 16 |
| 10 + 5 | 15 |
| 10 + 5 + 1 | 16 |

All five test cases pass in simulation.

## 10. Hardware Design Notes

The design uses a ripple-carry architecture. Each full-adder stage passes its carry-out to the carry_in of the next stage, allowing the carry to propagate through all four stages.
The four bit sum and the final carry_out together represent the complete 5-bit addition result.
