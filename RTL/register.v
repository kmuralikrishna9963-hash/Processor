`timescale 1ns/1ps

module register_file(

    input clk,
    input reset,

    // Read Port 1
    input [2:0] read_addr1,
    output [31:0] read_data1,

    // Read Port 2
    input [2:0] read_addr2,
    output [31:0] read_data2,

    // Write Port
    input write_enable,
    input [2:0] write_addr,
    input [31:0] write_data

);

//----------------------------------------
// Register Array
//----------------------------------------

reg [31:0] registers [0:7];

integer i;

//----------------------------------------
// Reset and Write
//----------------------------------------

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        for(i=0;i<8;i=i+1)
            registers[i] <= 32'd0;
    end

    else if(write_enable)
    begin
        registers[write_addr] <= write_data;
    end

end

//----------------------------------------
// Read Ports
//----------------------------------------

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

endmodule