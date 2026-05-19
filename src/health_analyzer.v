`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 20:41:42
// Design Name: 
// Module Name: health_analyzer
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


`timescale 1ns / 1ps

module health_analyzer(

    input [7:0] valid,
    output reg [7:0] score,
    output reg [1:0] status   // 00=SAFE, 01=WARNING, 10=CRITICAL
);

// ============================
// ML WEIGHTS
// ============================
parameter W_TEMP   = 18;
parameter W_HR     = 26;
parameter W_SPO2   = 20;
parameter W_BP     = 20;   // combined BP
parameter W_RESP   = 12;
parameter W_ECG    = 30;
parameter W_EMERG  = 123;

// ============================
// INTERNAL SIGNALS
// ============================
wire bp_issue;
assign bp_issue = valid[3] & valid[4];

// ============================
// LOGIC
// ============================
always @(*) begin

    // Reset values
    score = 0;
    status = 2'b00;

    // ============================
    // SCORE CALCULATION
    // ============================
    if (valid[0]) score = score + W_TEMP;   // Temp
    if (valid[1]) score = score + W_HR;     // HR
    if (valid[2]) score = score + W_SPO2;   // SpO2
    if (bp_issue) score = score + W_BP;     // BP
    if (valid[5]) score = score + W_RESP;   // RR
    if (valid[6]) score = score + W_ECG;    // ECG
    if (valid[7]) score = score + W_EMERG;  // Emergency

    // ============================
    // DECISION LOGIC (UPDATED)
    // ============================

    // Emergency override
    if (valid[7]) begin
        status = 2'b10;  // CRITICAL
    end

    // Critical threshold (UPDATED)
    else if (score >= 30) begin
        status = 2'b10;  // CRITICAL
    end

    // Warning threshold
    else if (score >= 15) begin
        status = 2'b01;  // WARNING
    end

    // Safe
    else begin
        status = 2'b00;  // SAFE
    end

end

endmodule
