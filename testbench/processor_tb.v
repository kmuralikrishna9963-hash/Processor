
`timescale 1ns/1ps

module processor_tb;

reg clk;
reg reset;

// Instantiate Processor
processor uut (
    .clk(clk),
    .reset(reset)
);

// Clock Generation (10 ns period)
always #5 clk = ~clk;

initial begin

    $display("========================================");
    $display("Processor Simulation Started");
    $display("========================================");

    // Initialize
    clk = 0;
    reset = 1;

    // Hold reset for one clock cycle
    #10;
    reset = 0;

    // Run the processor for enough cycles
    #200;

    $display("========================================");
    $display("Processor Simulation Finished");
    $display("========================================");

    $stop;

end

endmodule