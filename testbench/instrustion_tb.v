`timescale 1ns/1ps

module instruction_memory_tb;

reg [31:0] pc;
wire [31:0] instruction;

instruction_memory uut (
    .pc(pc),
    .instruction(instruction)
);

initial begin

    $display("========================================");
    $display("Instruction Memory Test Started");
    $display("========================================");

    $monitor("Time=%0t ns | PC=%0d | Instruction=%h",
             $time, pc, instruction);

    pc = 0;   #10;
    pc = 4;   #10;
    pc = 8;   #10;
    pc = 12;  #10;
    pc = 16;  #10;
    pc = 20;  #10;
    pc = 24;  #10;
    pc = 28;  #10;
    pc = 32;  #10;
    pc = 36;  #10;
    pc = 40;  #10;
    pc = 44;  #10;
    pc = 48;  #10;
    pc = 52;  #10;
    pc = 56;  #10;
    pc = 60;  #10;

    $display("========================================");
    $display("Instruction Memory Test Completed");
    $display("========================================");

    $stop;

end
endmodule