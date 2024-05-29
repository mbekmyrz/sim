`timescale 1ns / 1ps

module example ();

reg [3:0] counter = 0;

integer i;
initial begin
    for (i = 0; i < 10; i++) begin
        #10;
        counter = counter + 1;
    end
    #10 $finish;
end

always @(counter) begin
    if (counter % 2 == 0) begin
        $display("Hello, I'm an example counter=%0d", counter);
    end
end
    
endmodule