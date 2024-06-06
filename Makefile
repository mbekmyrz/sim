SRC = $(shell cat src.f)
TB ?= example
GUI ?= 0
TRACE ?= 0
TIMING ?= 1
VFLAGS := --build --exe --cc --no-std --unroll-count 1024
VFLAGS += -Wno-COMBDLY -Wno-width
CFLAGS :=
XFLAGS :=
XVFLAGS :=
IVFLAGS := -g2005 -Wall

ifeq (${TIMING}, 1)
VFLAGS += --timing
CFLAGS += -CFLAGS -fcoroutines
else
VFLAGS += --no-timing
endif

ifeq (${TRACE}, 1)
VFLAGS += --trace
VFLAGS += -DTRACE
XVFLAGS += -d TRACE
IVFLAGS += -DTRACE
endif

ifeq (${GUI}, 1)
XFLAGS += -gui
endif

ifeq (${SRC},)
$(error src.f is empty. Please fill it with Verilog source file names before running make)
endif

xsim: ${SRC}
	echo "set GUI ${GUI}" > args.tcl
	xvlog -d TESTBENCH=${TB} ${XVFLAGS} -sv top.v ${SRC}
	xelab -O3 -debug typical top -s top
	xsim top ${XFLAGS} -t xsim.tcl
	make clean

vcompile: ${SRC}
	verilator ${VFLAGS} ${CFLAGS} \
		--top top top.v ${SRC} \
		-DTESTBENCH=${TB} \
		--Mdir ${shell pwd}/verilator \
		-o test \
		test.cpp

verilator: vcompile
	./verilator/test
	make clean

icompile: ${SRC}
	iverilog $(IVFLAGS) \
		-s top top.v ${SRC} \
		-DTESTBENCH=${TB} \
		-o test

iverilog: icompile
	./test
	make clean

wave: trace.vcd
	gtkwave trace.vcd

clean:
	rm -rf .Xil xsim.dir verilator
	rm -rf test args.tcl *.jou *.log *.str *.wdb *.pb

make reallyclean:
	rm -rf *.vcd *.fst
