# MachX02Breakout
Repository for Lattice MachX02 Breakout Board Examples in VHDL

# Prerequisites
Hardware:
* [Lattice MachX02 Breakout Board](https://www.latticesemi.com/en/Products/DevelopmentBoardsAndKits/MachXO2BreakoutBoard)

Software:
* [Lattice Diamond 3.11](http://www.latticesemi.com/latticediamond)
* [VHDL Style Guide 2.0.0](https://github.com/jeremiah-c-leary/vhdl-style-guide)
* [Doxygen 1.8.18](https://www.doxygen.nl/index.html)

# Projects
This repository currently contains two projects:
* Basic
* Pll

## Basic Project
This project demonstrates blinking the 8 LEDs. It is configured as follows:
* Internal oscillator for clock at 9.85MHz
* Toggle process counts 1/2 second (4.925 million clocks) then toggles LEDs

## PLL Project
This project demonstrates blinking the 8 LEDs. It is configured as follows:
* Internal oscillator at 9.85MHz
* PLL created by IPexpress
  * Driven by 9.85MHz oscillator
  * Outputs 98.5MHz clock
* Toggle process counts 1/2 second (49.25 million clocks) then toggles LEDs

# Scripts
Both projects contain the following scripts
* style.bat   - command line style checker using VSG
* docs.bat    - command line documentation builder
* build.bat   - command line build of project jedec (.jed) files
* program.bat - command line programmer
