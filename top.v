`timescale 1ns / 1ps

module top();

`TESTBENCH dut();

`ifdef TRACE
initial begin
    $dumpfile("trace.vcd");
    $dumpvars();
end
`endif

endmodule
