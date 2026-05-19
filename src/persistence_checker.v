`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 20:25:50
// Design Name: 
// Module Name: persistence_checker
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


module persistence_checker(
    input clk,
    input tick,
    input [7:0] in_signals,
    output reg [7:0] valid
);

// Counters
reg [3:0] count [7:0];

// ML-based thresholds (in seconds)
reg [3:0] threshold [7:0];

integer i;

// ============================
// INITIALIZATION
// ============================
initial begin
    // ML persistence times
    threshold[0] = 5;  // Temp
    threshold[1] = 8;  // HR
    threshold[2] = 4;  // SpO2
    threshold[3] = 5;  // SysBP
    threshold[4] = 4;  // DiaBP
    threshold[5] = 5;  // RR
    threshold[6] = 4;  // ECG
    threshold[7] = 1;  // Emergency (instant)

    for (i = 0; i < 8; i = i + 1)
        count[i] = 0;

    valid = 0;
end

// ============================
// LOGIC
// ============================
always @(posedge clk) begin
    if (tick) begin
        for (i = 0; i < 8; i = i + 1) begin

            if (in_signals[i]) begin
                if (count[i] < threshold[i])
                    count[i] <= count[i] + 1;
            end else begin
                count[i] <= 0;
            end

            if (count[i] >= threshold[i])
                valid[i] <= 1;
            else
                valid[i] <= 0;

        end
    end
end

endmodule
