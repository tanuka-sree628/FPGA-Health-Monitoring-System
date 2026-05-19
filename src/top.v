`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 21:01:23
// Design Name: 
// Module Name: top
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

module top(
    input clk,           // 50 MHz clock
    input [7:0] sw,      // 8 switch inputs
    output [2:0] led,    // LED output
    output buzzer,       // buzzer output

    // LCD Outputs
    output rs,
    output en,
    output [7:0] lcd_data   // ? FIXED (8-bit)
);

wire tick;
wire [7:0] raw_signals;
wire [7:0] valid_signals;
wire [7:0] score;
wire [1:0] status;


// ============================
// 1. Timer (1-second tick)
// ============================
timer #(5) t1 (
    .clk(clk),
    .tick(tick)
);

// ============================
// 2. Input Handler (synchronizer)
// ============================
input_handler ih1 (
    .clk(clk),
    .sw(sw),
    .signals(raw_signals)
);

// ============================
// 3. Persistence Checker
// ============================
persistence_checker pc1 (
    .clk(clk),
    .tick(tick),
    .in_signals(raw_signals),
    .valid(valid_signals)
);

// ============================
// 4. Health Analyzer
// ============================
health_analyzer ha1 (
    .valid(valid_signals),
    .score(score),
    .status(status)
);

// ============================
// 5. Output Controller (LED + buzzer)
// ============================
output_controller oc1 (
    .clk(clk),
    .status(status),
    .led(led),
    .buzzer(buzzer)
);

// ============================
// 6. LCD Controller
// ============================
lcd_controller lcd1 (
    .clk(clk),
    .status(status),
    .rs(rs),
    .en(en),
    .data(lcd_data)
);

endmodule