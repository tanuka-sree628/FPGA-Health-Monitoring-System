`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 20:55:03
// Design Name: 
// Module Name: output_controller
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

module output_controller(
    input clk,
    input [1:0] status,
    output reg [2:0] led,
    output reg buzzer
);

// Counter for blinking buzzer
reg [23:0] counter = 0;

// ============================
// CLOCK-BASED COUNTER
// ============================
always @(posedge clk) begin
    counter <= counter + 1;
end

// ============================
// OUTPUT LOGIC
// ============================
always @(*) begin

    case (status)

        // SAFE ? Green LED
        2'b00: begin
            led = 3'b001;
            buzzer = 0;
        end

        // WARNING ? Yellow LED
        2'b01: begin
            led = 3'b010;
            buzzer = 0;
        end

        // CRITICAL ? Red LED + Blinking buzzer
        2'b10: begin
            led = 3'b100;
            buzzer = counter[3];  // blinking signal
        end

        // Default (safety)
        default: begin
            led = 3'b000;
            buzzer = 0;
        end

    endcase

end

endmodule