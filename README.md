# FPGA-Health-Monitoring-System

## Overview

A hardware-implemented health monitoring solution built in Verilog and deployed on the EDGE Artix-35T FPGA Development Board. The design acquires health-related input signals, classifies their severity in real time, and communicates outcomes through LEDs, a buzzer, and an LCD panel. Before any alert is raised, a dedicated persistence verification stage confirms that the abnormal condition is sustained rather than transient — reducing false positives and improving overall system reliability.

---

## Features

- Continuous real-time acquisition and classification of health parameters
- Persistence-based confirmation before alert escalation
- Two-tier alert detection: HELP and CRITICAL severity levels
- LCD panel integration for live status display
- LED array and buzzer for immediate multi-sensory notification
- Modular, maintainable Verilog HDL design
- Fully synthesized and validated on physical FPGA hardware

---

## Project Structure

```text
FPGA-Health-Monitoring-System/
│
├── constraint_file/
│   └── Constraints.xdc
│
├── documents/
│    ├── Implementation_reports
│        ├── top_clock_utilization_routed.rpt
│        ├── top_power_routed.rpt
│        ├── top_timing_summary_routed.rpt
│    ├── synthesis_report
│        ├── top_utilization_synth.rpt
│    └── Fpga_Health_Monitoring_System_report.pdf
│
├── results/
│   ├── fpga_block_diagram.jpeg
│   ├── schematic_design.jpeg
│   ├── simulation_waveform.jpeg
│   ├── hardware_setup.jpeg
│   └── output_states/
│       ├── normal_state.jpeg
│       ├── help_state.jpeg
│       └── critical_state.jpeg
│
├── simulation/
│   └── top_tb.v
│
├── src/
│   ├── top.v
│   ├── timer.v
│   ├── input_handler.v
│   ├── persistence_checker.v
│   ├── health_analyzer.v
│   ├── output_controller.v
│   └── lcd_controller.v
│
├── ml_model/
│   └── FPGA_Vitals.ipynb
│
└── README.md
```

---

## Module Descriptions

### `top.v`
Root integration module that connects all subsystems and is responsible for end-to-end system operation.

### `timer.v`
Produces the timing pulses and synchronization signals that coordinate activity across every module in the design.

### `input_handler.v`
Receives and conditions raw sensor inputs, preparing them for reliable downstream analysis.

### `persistence_checker.v`
Tracks whether an anomalous reading is sustained over a defined window before allowing an alert to propagate — filtering out momentary spikes.

### `health_analyzer.v`
Classifies conditioned inputs against health thresholds and determines the appropriate system response level.

### `output_controller.v`
Drives the LED array and buzzer in accordance with the active alert classification output by the health analyzer.

### `lcd_controller.v`
Formats and renders system state and alert messages onto the connected LCD display module.

---

## Hardware Used

| Component | Details |
|-----------|---------|
| FPGA Board | EDGE Artix-35T Development Board |
| Display | LCD Display Module |
| Visual Indicators | LED Array |
| Audio Indicator | Buzzer |
| Peripherals | External Interface Modules |

---

## Software & Tools

| Tool | Role |
|------|------|
| Verilog HDL | Hardware description and design |
| Xilinx Vivado | Synthesis, implementation, and bitstream generation |
| FPGA Simulation Tools | Functional verification and waveform analysis |

---

## FPGA Block Diagram

![FPGA Block Diagram](results/fpga_block_diagram.jpeg)

---

## RTL / Schematic Design

![Schematic Design](results/schematic_design.jpeg)

---

## Simulation Waveform

The waveform demonstrates the CRITICAL alert condition where all monitored abnormal inputs are activated (`sw[7:0] = 11111111`). The system generates a high health-risk score, activates the buzzer, and triggers the CRITICAL warning state.

![Simulation Waveform](results/simulation_waveform.jpeg)

---

## Hardware Implementation

The complete design was synthesized, programmed, and tested on the EDGE Artix-35T FPGA Development Board. All hardware interfaces — including the LCD panel, LEDs, and buzzer — were connected and verified under real operating conditions.

---

## Machine Learning Assisted Weight Optimization

A supporting machine learning model was used for weight optimization in the persistence checker module.

Notebook:
`ml_model/FPGA_Vitals.ipynb`

## Output States

### Normal State
All monitored parameters fall within acceptable ranges; the system operates without generating any alerts.

![Normal State](results/output_states/normal_state.jpeg)

### HELP Alert State
Activated when a moderately abnormal reading persists beyond the configured verification window, prompting a moderate-level alert response.

![HELP State](results/output_states/help_state.jpeg)

### CRITICAL Alert State
Triggered by severe or dangerous parameter values that persist, resulting in full activation of all warning outputs — LEDs, buzzer, and LCD notification.

![CRITICAL State](results/output_states/critical_state.jpeg)

---

## Simulation

Functional verification was performed using the `top_tb.v` testbench. The simulation suite covers:

- Correct processing of sensor input signals
- Accurate triggering of HELP and CRITICAL alerts
- Persistence logic behavior under both sustained and short-lived anomalies
- LCD output correctness and timing
- State transition integrity across all operating modes

---

## Results

- Synthesis completed without critical violations
- SAFE,HELP and CRITICAL alerts triggered correctly under defined health conditions
- LCD display maintained stable, accurate output throughout all test scenarios
- Simulation waveforms match expected behavior across every test case
- Full hardware functionality confirmed on the target FPGA board.

---

