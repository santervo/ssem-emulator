# SSEM emulator

Emulator of Manchester Small Scale Experimental machine.

Usage: ruby ssem.rb [source file]

Source file should contain the initial memory contents. Each line contains one 32-bit word. Words are given as hex numbers. Program execution starts from the first word (memory address 0).

As of now only JMP, LDN, STO, SUB and STP are implemented.


