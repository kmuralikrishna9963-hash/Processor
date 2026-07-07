
`timescale 1ns/1ps

module processor(

    input clk,
    input reset

);

//==========================================================
// Internal Wires
//==========================================================

// Program Counter
wire [31:0] pc;

// Instruction
wire [31:0] instruction;

// Instruction Fields
wire [3:0] opcode;
wire [2:0] rd;
wire [2:0] rs1;
wire [2:0] rs2;
wire [18:0] immediate;

// Control Signals
wire reg_write;
wire mem_read;
wire mem_write;
wire alu_src;
wire mem_to_reg;
wire [3:0] alu_control;

// Register File
wire [31:0] read_data1;
wire [31:0] read_data2;

// ALU
wire [31:0] alu_operand_b;
wire [31:0] alu_result;
wire zero;

// Data Memory
wire [31:0] memory_data;

// Write Back
wire [31:0] write_back_data;

//==========================================================
// Decode Instruction
//==========================================================

assign opcode    = instruction[31:28];
assign rd        = instruction[27:25];
assign rs1       = instruction[24:22];
assign rs2       = instruction[21:19];
assign immediate = instruction[18:0];

//==========================================================
// Program Counter
//==========================================================

program_counter PC (

    .clk(clk),
    .reset(reset),
    .pc(pc)

);

//==========================================================
// Instruction Memory
//==========================================================

instruction_memory IM (

    .pc(pc),
    .instruction(instruction)

);

//==========================================================
// Control Unit
//==========================================================

control_unit CU (

    .opcode(opcode),

    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .mem_to_reg(mem_to_reg),
    .alu_control(alu_control)

);

//==========================================================
// Register File
//==========================================================

register_file RF (

    .clk(clk),
    .reset(reset),

    .read_addr1(rs1),
    .read_addr2(rs2),

    .read_data1(read_data1),
    .read_data2(read_data2),

    .write_enable(reg_write),
    .write_addr(rd),
    .write_data(write_back_data)

);

//==========================================================
// ALU Operand Selection
//==========================================================

// Immediate is zero-extended to 32 bits

assign alu_operand_b =
        (alu_src) ? {13'd0, immediate} :
                    read_data2;

//==========================================================
// ALU
//==========================================================

alu ALU (

    .operand_a(read_data1),
    .operand_b(alu_operand_b),
    .alu_control(alu_control),

    .result(alu_result),
    .zero(zero)

);

//==========================================================
// Data Memory
//==========================================================

data_memory DM (

    .clk(clk),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .address(alu_result[3:0]),

    .write_data(read_data2),

    .read_data(memory_data)

);

//==========================================================
// Write Back MUX
//==========================================================

assign write_back_data =
            (mem_to_reg) ?
            memory_data :
            alu_result;

endmodule