`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 20:12:16
// Design Name: 
// Module Name: timer
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


module timer #(parameter CLK_FREQ = 5)(
    input clk,
    output reg tick
);

reg [31:0] count = 0;

always @(posedge clk) begin
    if (count == CLK_FREQ - 1) begin
        count <= 0;
        tick <= 1;
    end else begin
        count <= count + 1;
        tick <= 0;
    end
end

endmodule
