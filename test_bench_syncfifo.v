`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2025 17:37:58
// Design Name: 
// Module Name: test_bench_syncfifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_bench_syncfifo();
parameter FIFO_DEPTH = 8;
parameter DATA_WIDTH = 32;
reg clk;
reg rst_n;
reg wr_en;
reg rd_en;
reg cs;
reg [DATA_WIDTH-1:0]data_in;
wire [DATA_WIDTH-1:0]data_out;
wire Full;
wire Empty;

SyncFIFO inst(.clk(clk),.cs(cs),.rst_n(rst_n),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.Full(Full),.Empty(Empty));

initial clk = 0; 

always #5 clk = ~clk; //Clock

//task based stimulus generation

//Write operation
task write_data(input [DATA_WIDTH-1:0]d_in);
begin
@(posedge clk)
cs = 1; wr_en =1;
data_in <= d_in;
$display ($time , "write_data data_in = %d",d_in);
@(posedge clk)
cs = 1; wr_en = 0;
end
endtask

//Read operation
task read_data;
begin
@(posedge clk)
cs = 1; rd_en =1 ;
@(posedge clk)
$display($time, "read_data data is = %d",data_out);
cs = 1; rd_en = 0;
end
endtask

initial 
begin 
#1 rst_n = 0; rd_en = 0; wr_en = 0;

@(posedge clk)
rst_n = 1;
$display($time,"\n SCENARIO 1");
write_data(1);
write_data(100);
write_data(1000);
read_data();
read_data();
read_data();

$display($time, "\n SCENARIO 2");
for(integer i=0;i<FIFO_DEPTH;i= i+1) begin
write_data(2**i);
read_data();
end

$display($time,"\n SCENARIO 3");
for(integer i=0;i<FIFO_DEPTH;i=i+1)begin
write_data(2**i);
end

for(integer i=0;i<FIFO_DEPTH;i=i+1)begin
read_data();
end
#40 $finish;
end


endmodule
