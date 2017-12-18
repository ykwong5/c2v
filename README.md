# c2v
A simple HLS compiler under development for converting most C99 syntax to synthesizable HDLs, VHDL or Verilog.

The goal of this project is to allow software engineers to develop hardware modules in any FPGA devices with C99 directly without including any custom made libraries. The traditional logic design flow in FPGA is as flow:

Logic design and constrains setting with HDL/Schematic(FPGA Engineers) -> Synthesis(IDE) -> Implementation(IDE) -> Timing Analysis(IDE) -> FPGA bit stream

The problem for the traditional flow is that the learning paths for any HDLs are much longer than any programming languages. HDLs also share a different concept with programming languages which cause software engineers hard to pick up usually. Moreover, it is hard to model a complex algorithm for video, AI applications, which inovlved many flowing point operations and data structures, with HDLs together with handling hardware constrains for FPGA engineers at the same time. By modeling complex designs with C with the usage of c2v HLS compiler, the design flow would become:

Logic design with C(Software Engineers) -> Constrains setting with HDL(FPGA Engineers) -> Synthesis(IDE) -> Implementation(IDE) -> Timing Analysis(IDE) -> FPGA bit stream

A complicated logic thus could be designed with C, in a much simpler way. This also results in a lower entry level for FPGA design and a shorter implementation time. The other advantage of this flow is that the HDL RTL is preserved. FPGA engineers can optimize the resource utilization and setting constrains afterwards.
