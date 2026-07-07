module memory(
    input [1:0] address,
    output reg [2:0] light
);

always @(*)
begin
    case(address)

        2'b00: light = 3'b001; // Green
        2'b01: light = 3'b010; // Yellow
        2'b10: light = 3'b100; // Red
        2'b11: light = 3'b111; // All ON

    endcase
end

endmodule