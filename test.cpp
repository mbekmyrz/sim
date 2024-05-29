#include <memory>
#include <iostream>
#include <verilated.h>
#ifdef TRACE
#include "verilated_vcd_c.h"
#endif
#include <Vtop.h>


constexpr vluint64_t maxtime = 10e10;

int main(int argc, char* argv[]) {
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};

    contextp->debug(0);
#ifdef TRACE
    contextp->traceEverOn(true);
#else
    contextp->traceEverOn(false);
#endif
    contextp->commandArgs(argc, argv);

    const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), "top"}};

    // top->clk = 0;
    // top->rst = 1;

    while (!contextp->gotFinish() && contextp->time() < maxtime) {
        contextp->timeInc(1);
        // top->clk = !top->clk;

        // if (!top->clk) {
        //     if (contextp->time() > 1 && contextp->time() < 3) {
        //         top->rst = 1;
        //     } else {
        //         top->rst = 0;
        //     }
        // }

        top->eval();
    }

    top->final();

    if (contextp->time() >= maxtime) {
        std::cerr << "Error: Timed out!";
        return -1;
    }

    return 0;
}

