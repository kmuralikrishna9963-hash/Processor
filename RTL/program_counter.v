`timescale 1ns/1ps

module program_counter (

    input clk,
    input reset,
    output reg [31:0] pc

);

always @(posedge clk or posedge reset)
begin
    if (reset)
        pc <= 32'd0;          // Start execution from address 0
    else
        pc <= pc + 32'd4;     // Move to the next 32-bit instruction
end

endmodule