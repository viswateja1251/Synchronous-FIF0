**Synchronous FIFO Design (Vivado)**
**Overview**

This project implements a Synchronous FIFO (First-In-First-Out) buffer using Verilog HDL in Xilinx Vivado.
A FIFO is a sequential memory storage element widely used in digital systems for buffering and data flow control. This design ensures reliable data transfer between modules operating on the same clock domain.

**Features**

Synchronous operation (single clock domain).

Configurable FIFO depth and data width.

Full and Empty flag generation.

Read and Write enable controls.

Reset functionality for safe initialization.

Testbench included for simulation and verification.

**Project Structure**
Synchronous_FIFO/
│── src/                 # Source HDL files
│   ├── fifo.v           # Synchronous FIFO RTL code
│   ├── fifo_tb.v        # Testbench
│
│── sim/                 # Simulation outputs
│   ├── waveforms.vcd    # Waveform dump (optional)
│
│── vivado/              # Vivado project files
│   ├── fifo.xpr         # Vivado project file
│   └── constraints.xdc  # Constraints (if required)
│
└── README.md            # Project documentation

**Design Details**

Write Operation: Data is written on wr_en when FIFO is not full.

Read Operation: Data is read on rd_en when FIFO is not empty.

**Flags:**

full → Asserted when FIFO is full.

empty → Asserted when FIFO is empty.

Pointers: Write and read pointers are maintained to track storage elements.

Clock: Single clock edge-triggered operation.

**Simulation & Verification**

Launch Vivado and open the project.

Run behavioral simulation.

Observe FIFO behavior in the waveform viewer:

Check correct data write and read sequence.

Verify proper flag assertion (full, empty).

Ensure reset clears FIFO.

**Synthesis & Implementation**

Open Vivado → Create Project → Add fifo.v.

**Run Synthesis and Implementation.**

Generate Bitstream if targeting FPGA deployment.

Use Hardware Manager to program FPGA (optional).

**Applications**

Data buffering in communication systems.

Pipelined processor design.

Interfacing between producer-consumer modules.

Real-time streaming applications.

**Requirements**

Xilinx Vivado 2020.2+ (or compatible).

Target FPGA board (optional for hardware testing).

Basic knowledge of Verilog HDL.

Author

Designed and tested by Mummaneedi Viswateja
B.Tech in Electronics and Communication Engineering, IIT (ISM) Dhanbad
