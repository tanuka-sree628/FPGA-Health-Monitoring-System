`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 20:24:11
// Design Name: 
// Module Name: input_handler
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


module input_handler(
    input clk,
    input [7:0] sw,          
    output reg [7:0] signals 
);
reg [7:0] sync_stage1;
reg [7:0] sync_stage2;

always @(posedge clk) begin
    // Stage 1: capture raw switch 
    sync_stage1 <= sw;

    // Stage 2: stabilize signal
    sync_stage2 <= sync_stage1;

    // Final output (stable)
    signals <= sync_stage2;
end

endmodule
