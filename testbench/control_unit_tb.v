`timescale 1ns/1ps

module control_unit_tb;

reg [3:0] opcode;

wire reg_write;
wire mem_read;
wire mem_write;
wire alu_src;
wire mem_to_reg;
wire [3:0] alu_control;

control_unit uut(

    .opcode(opcode),

    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .mem_to_reg(mem_to_reg),

    .alu_control(alu_control)

);

initial begin

    $display("========== Control Unit Test ==========");

    $monitor("Time=%0t | Opcode=%b | RegWrite=%b | MemRead=%b | MemWrite=%b | ALUSrc=%b | MemToReg=%b | ALUCtrl=%b",
             $time,
             opcode,
             reg_write,
             mem_read,
             mem_write,
             alu_src,
             mem_to_reg,
             alu_control);

    opcode = 4'b1000; #10; // MOVI
    opcode = 4'b0001; #10; // ADD
    opcode = 4'b0010; #10; // SUB
    opcode = 4'b0011; #10; // AND
    opcode = 4'b0100; #10; // OR
    opcode = 4'b0110; #10; // LOAD
    opcode = 4'b0111; #10; // STORE
    opcode = 4'b0000; #10; // NOP

    $display("========== Test Complete ==========");

    $stop;

end

endmodule