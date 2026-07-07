
`timescale 1ns/1ps

module alu_tb;

reg [31:0] operand_a;
reg [31:0] operand_b;
reg [3:0] alu_control;

wire [31:0] result;
wire zero;

alu uut(

    .operand_a(operand_a),
    .operand_b(operand_b),
    .alu_control(alu_control),
    .result(result),
    .zero(zero)

);

initial begin

    $display("========================================");
    $display("ALU Test Started");
    $display("========================================");

    $monitor("Time=%0t | A=%d | B=%d | CTRL=%b | RESULT=%d | ZERO=%b",
             $time, operand_a, operand_b,
             alu_control, result, zero);

    // ADD
    operand_a = 10;
    operand_b = 20;
    alu_control = 4'b0000;
    #10;

    // SUB
    operand_a = 50;
    operand_b = 20;
    alu_control = 4'b0001;
    #10;

    // AND
    operand_a = 12;
    operand_b = 10;
    alu_control = 4'b0010;
    #10;

    // OR
    operand_a = 12;
    operand_b = 10;
    alu_control = 4'b0011;
    #10;

    // XOR
    operand_a = 12;
    operand_b = 10;
    alu_control = 4'b0100;
    #10;

    // NOT
    operand_a = 12;
    operand_b = 0;
    alu_control = 4'b0101;
    #10;

    // SLT
    operand_a = 5;
    operand_b = 10;
    alu_control = 4'b0110;
    #10;

    // PASS A
    operand_a = 100;
    operand_b = 50;
    alu_control = 4'b0111;
    #10;

    // ZERO FLAG TEST
    operand_a = 20;
    operand_b = 20;
    alu_control = 4'b0001;
    #10;

    $display("========================================");
    $display("ALU Test Completed");
    $display("========================================");

    $stop;

end

endmodule