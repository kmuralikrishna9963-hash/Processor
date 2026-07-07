`timescale 1ns/1ps

module program_counter_tb;

reg clk;
reg reset;

wire [31:0] pc;

// Instantiate the Program Counter
program_counter uut (
    .clk(clk),
    .reset(reset),
    .pc(pc)
);

// Generate a 10 ns clock
always #5 clk = ~clk;

initial begin
    $display("====================================");
    $display("Program Counter Simulation Started");
    $display("====================================");

    $monitor("Time=%0t ns | Reset=%b | PC=%d", $time, reset, pc);

    // Initialize
    clk = 0;
    reset = 1;

    // Hold reset for one clock period
    #10;
    reset = 0;

    // Allow the PC to count
    #50;

    // Apply reset again
    reset = 1;
    #10;
    reset = 0;

    // Count again
    #50;

    $display("====================================");
    $display("Program Counter Simulation Finished");
    $display("====================================");

    $stop;
end

endmodule