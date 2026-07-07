`timescale 1ns/1ps

module data_memory_tb;

reg clk;

reg mem_read;
reg mem_write;

reg [3:0] address;
reg [31:0] write_data;

wire [31:0] read_data;

data_memory uut(

    .clk(clk),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .address(address),

    .write_data(write_data),
    .read_data(read_data)

);

// Clock
always #5 clk = ~clk;

initial begin

    clk = 0;

    mem_read = 0;
    mem_write = 0;

    address = 0;
    write_data = 0;

    $display("====================================");
    $display("Data Memory Test Started");
    $display("====================================");

    //---------------------------------
    // STORE 30 into Memory[0]
    //---------------------------------

    #10;
    mem_write = 1;
    address = 4'd0;
    write_data = 32'd30;

    #10;
    mem_write = 0;

    //---------------------------------
    // LOAD Memory[0]
    //---------------------------------

    mem_read = 1;
    address = 4'd0;

    #10;

    //---------------------------------
    // STORE 100 into Memory[5]
    //---------------------------------

    mem_read = 0;
    mem_write = 1;

    address = 4'd5;
    write_data = 32'd100;

    #10;

    mem_write = 0;

    //---------------------------------
    // LOAD Memory[5]
    //---------------------------------

    mem_read = 1;
    address = 4'd5;

    #10;

    //---------------------------------
    // Read Empty Location
    //---------------------------------

    address = 4'd10;

    #10;

    $display("====================================");
    $display("Data Memory Test Completed");
    $display("====================================");

    $stop;

end

initial begin

    $monitor("Time=%0t | Read=%b | Write=%b | Addr=%d | WriteData=%d | ReadData=%d",
             $time,
             mem_read,
             mem_write,
             address,
             write_data,
             read_data);

end

endmodule