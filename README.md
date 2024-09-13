# Seven-Segment Hexadecimal Display Driver

This C program implements a software-multiplexed 7-segment display driver for a PICOSOC RISC-V processor instantiated on an FPGA.

## Authors

- CEO: Samuel Cacnio
- PM: Tyson Aramaki
- Dev: Frank Veldhuizen
- Test: Rodolfo Lopez

## Date

11/6/22

## Overview

The program drives a 4-digit 7-segment display connected to GPIO pins. It implements the following key features:

- Software multiplexing to drive 4 digits with shared segment lines
- Hexadecimal digit decoding
- 1 second timer using a millisecond delay function
- Debug LED output

## Key Functions

- `spin_wait_ms()` - Implements a millisecond delay using a busy-wait loop
- `segment_decode()` - Decodes a hex digit to 7-segment display pattern
- `main()` - Main program loop that handles display multiplexing and timing

## GPIO Usage

The program uses the following GPIO mappings:

- `gpio[3:0]` - Debug LEDs
- `gpio[7:4]` - Digit select lines
- `gpio[31:25]` - 7-segment lines (active low)

## Operation

The program displays an incrementing 4-digit hexadecimal counter, updating once per second. The current digit being driven is indicated on the debug LEDs.

## Building

This program is designed to be compiled for the PICOSOC RISC-V core. Use the appropriate RISC-V toolchain to compile.

## Hardware Setup

Requires a 4-digit common cathode 7-segment display connected to the FPGA GPIO pins as defined in the `top.v` file.

## Acknowledgements

The starter code was writtern by Professor Chuck Pateros. Our team:

- Debugged the 4 DBG LEDs to follow the `upduino3.pcf` file specification
- Mapped the COMM and SEG signals to the GPIO bits/pins in both the hardware `top.v` and software `firmware.c`
- Applied a multiplexer for the SEG signals
- Updated COMM signals in `firmware.c` to reflect our assigned pattern (0,3,2,1)
