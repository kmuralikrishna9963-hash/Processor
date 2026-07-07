
`timescale 1ns/1ps

module control_unit(

    input [3:0] opcode,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg mem_to_reg,

    output reg [3:0] alu_control

);

always @(*) begin

    // Default Values
    reg_write  = 0;
    mem_read   = 0;
    mem_write  = 0;
    alu_src    = 0;
    mem_to_reg = 0;
    alu_control = 4'b0000;

    case(opcode)

        // MOVI
        4'b1000:
        begin
            reg_write = 1;
            alu_src = 1;
            alu_control = 4'b0111; // PASS Immediate
        end

        // ADD
        4'b0001:
        begin
            reg_write = 1;
            alu_control = 4'b0000;
        end

        // SUB
        4'b0010:
        begin
            reg_write = 1;
            alu_control = 4'b0001;
        end

        // AND
        4'b0011:
        begin
            reg_write = 1;
            alu_control = 4'b0010;
        end

        // OR
        4'b0100:
        begin
            reg_write = 1;
            alu_control = 4'b0011;
        end

        // LOAD
        4'b0110:
        begin
            reg_write = 1;
            mem_read = 1;
            mem_to_reg = 1;
        end

        // STORE
        4'b0111:
        begin
            mem_write = 1;
        end

        default:
        begin
            // NOP: keep defaults
        end

    endcase

end

endmodule