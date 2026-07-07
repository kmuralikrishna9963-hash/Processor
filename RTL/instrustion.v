
`timescale 1ns/1ps

module instruction_memory(

    input  [31:0] pc,
    output reg [31:0] instruction

);

//--------------------------------------------------
// 16 x 32-bit Instruction Memory (ROM)
//--------------------------------------------------

reg [31:0] memory [0:15];

//--------------------------------------------------
// Program Initialization
//--------------------------------------------------

initial begin

    // MOVI R1,10
    memory[0] = {4'b1000,3'b001,3'b000,3'b000,19'd10};

    // MOVI R2,20
    memory[1] = {4'b1000,3'b010,3'b000,3'b000,19'd20};

    // ADD R3,R1,R2
    memory[2] = {4'b0001,3'b011,3'b001,3'b010,19'd0};

    // STORE R3, Memory[0]
    memory[3] = {4'b0111,3'b011,3'b000,3'b000,19'd0};

    // LOAD R4, Memory[0]
    memory[4] = {4'b0110,3'b100,3'b000,3'b000,19'd0};

    // SUB R5,R4,R1
    memory[5] = {4'b0010,3'b101,3'b100,3'b001,19'd0};

    // AND R6,R1,R2
    memory[6] = {4'b0011,3'b110,3'b001,3'b010,19'd0};

    // OR R7,R1,R2
    memory[7] = {4'b0100,3'b111,3'b001,3'b010,19'd0};

    // Remaining locations = NOP
    memory[8]  = 32'd0;
    memory[9]  = 32'd0;
    memory[10] = 32'd0;
    memory[11] = 32'd0;
    memory[12] = 32'd0;
    memory[13] = 32'd0;
    memory[14] = 32'd0;
    memory[15] = 32'd0;

end

//--------------------------------------------------
// Read Instruction
//--------------------------------------------------

always @(*) begin
    instruction = memory[pc[5:2]];
end

endmodule