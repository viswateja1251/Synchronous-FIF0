`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 21:08:55
// Design Name: 
// Module Name: SyncFIFO
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


module SyncFIFO #(parameter DEPTH_FIFO =8,parameter DATA_WIDTH = 32)
(input cs,
input rst_n, //Active low synchronous reset
input wr_en,
input rd_en,
input clk,
input [DATA_WIDTH-1:0]data_in,
output reg [DATA_WIDTH-1:0]data_out,
output reg Full,
output reg Empty)
;

localparam FIFO_Depth_log = $clog2(DEPTH_FIFO);//No of bits required to represent depth of fifo log2(8) = 3;

//FIFO ARRAY 2D
reg [DATA_WIDTH-1:0]fifo[DEPTH_FIFO-1:0];

//Write and Read pointers of length FIFO_Depth_log+1
reg [FIFO_Depth_log:0]Write;
reg [FIFO_Depth_log:0]Read;

//Write operation
always@(posedge clk or negedge rst_n)
begin
if(!rst_n)Write <= 0;
else if(cs && wr_en && !Full)begin
fifo[Write[FIFO_Depth_log-1:0]] <= data_in;
Write[FIFO_Depth_log:0] <= Write[FIFO_Depth_log:0] + 1'b1;
end
end

//Read operation
always@(posedge clk or negedge rst_n)
begin
if(!rst_n)begin Read <= 0; data_out<=0; end
else if(cs && rd_en && !Empty)begin
data_out <= fifo[Read[FIFO_Depth_log-1:0]];
Read[FIFO_Depth_log:0] <= Read[FIFO_Depth_log:0] + 1'b1;
end
end

always@(posedge clk or negedge rst_n)
begin
if(!rst_n)begin Full<=0; Empty<=1; end
else begin Empty<=(Read[FIFO_Depth_log:0] == Write[FIFO_Depth_log:0]);
Full<=(Read[FIFO_Depth_log:0] == {~Write[FIFO_Depth_log],Write[FIFO_Depth_log-1:0]});
end
end

endmodule
