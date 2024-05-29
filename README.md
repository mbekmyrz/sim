# sim
Verilog Simulation Scripts: xsim, verilator, icarus verilog

## How to run simulation
1. Clone the repo:
```
git clone https://github.com/mbekmyrz/sim.git
```
2. Copy your Verilog source files into this repo.
3. Fill in `src.f` with the names of your Verilog source files.
4. Specify your testbench module name along with make rule:

For xsim:
```
make xsim TB=example
```

For verilator:
```
make verilator TB=example
```

For icarus verilog:
```
make iverilog TB=example
```

## How to see waveforms
Only for xsim, GUI can be launched by providing `GUI=1`:
```
make xsim TB=example GUI=1
```

For xsim, verilator, and iverilog, `trace.vcd` can be generated by prodiving `TRACE=1` and then open it with gtkwave:

For xsim:
```
make xsim TB=example TRACE=1
```

For verilator:
```
make verilator TB=example TRACE=1
```

For icarus verilog:
```
make iverilog TB=example TRACE=1
```

Then:

```
make wave
```