`timescale 1ns/1ps

module register_file_tb;

reg clk;
reg reset;

reg [2:0] read_addr1;
reg [2:0] read_addr2;

wire [31:0] read_data1;
wire [31:0] read_data2;

reg write_enable;
reg [2:0] write_addr;
reg [31:0] write_data;

register_file uut(

    .clk(clk),
    .reset(reset),

    .read_addr1(read_addr1),
    .read_addr2(read_addr2),

    .read_data1(read_data1),
    .read_data2(read_data2),

    .write_enable(write_enable),
    .write_addr(write_addr),
    .write_data(write_data)

);

// Clock Generation
always #5 clk = ~clk;

initial
begin

    clk = 0;

    reset = 1;

    write_enable = 0;

    read_addr1 = 0;
    read_addr2 = 0;

    #10;
    reset = 0;

    //---------------------------------
    // Write R1 = 10
    //---------------------------------

    write_enable = 1;
    write_addr = 3'd1;
    write_data = 32'd10;

    #10;

    //---------------------------------
    // Write R2 = 20
    //---------------------------------

    write_addr = 3'd2;
    write_data = 32'd20;

    #10;

    //---------------------------------
    // Write R3 = 30
    //---------------------------------

    write_addr = 3'd3;
    write_data = 32'd30;

    #10;

    //---------------------------------
    // Stop Writing
    //---------------------------------

    write_enable = 0;

    //---------------------------------
    // Read R1 and R2
    //---------------------------------

    read_addr1 = 3'd1;
    read_addr2 = 3'd2;

    #10;

    //---------------------------------
    // Read R3 and R1
    //---------------------------------

    read_addr1 = 3'd3;
    read_addr2 = 3'd1;

    #10;

    //---------------------------------
    // Read R2 and R3
    //---------------------------------

    read_addr1 = 3'd2;
    read_addr2 = 3'd3;

    #10;

    $stop;

end

initial
begin

    $monitor("Time=%0t | WE=%b | WA=%d | WD=%d | RA1=%d RD1=%d | RA2=%d RD2=%d",
              $time,
              write_enable,
              write_addr,
              write_data,
              read_addr1,
              read_data1,
              read_addr2,
              read_data2);

end

endmodule