`timescale 1ns / 1ps

module lcd_controller(
    input clk,
    input [1:0] status,
    output reg rs,
    output reg en,
    output reg [7:0] data
);

// ============================
// REGISTERS
// ============================
reg [23:0] counter = 0;
reg [3:0] state = 0;
reg [1:0] prev_status = 2'b11;

reg [7:0] message [0:3];

// ============================
// MESSAGE SELECTION
// ============================
always @(*) begin
    case (status)

        // SAFE
        2'b00: begin
            message[0] = "S";
            message[1] = "A";
            message[2] = "F";
            message[3] = "E";
        end

        // WARNING
        2'b01: begin
            message[0] = "W";
            message[1] = "A";
            message[2] = "R";
            message[3] = "N";
        end

        // CRITICAL ? HELP
        2'b10: begin
            message[0] = "H";
            message[1] = "E";
            message[2] = "L";
            message[3] = "P";
        end

        default: begin
            message[0] = " ";
            message[1] = " ";
            message[2] = " ";
            message[3] = " ";
        end
    endcase
end

// ============================
// STATE CONTROL + STATUS CHANGE
// ============================
always @(posedge clk) begin
    counter <= counter + 1;

    // Restart LCD if status changes
    if (status != prev_status) begin
        state <= 0;
        prev_status <= status;
        counter <= 0;
    end

    // Slow progression for LCD timing
    if (counter == 1_000_000) begin
        counter <= 0;
        if (state < 9)
            state <= state + 1;
    end
end

// ============================
// ENABLE PULSE GENERATION
// ============================
always @(posedge clk) begin
    en <= (counter < 500_000) ? 1 : 0;  // proper wide pulse
end

// ============================
// LCD OUTPUT LOGIC
// ============================
always @(*) begin

    case (state)

        // ===== INITIALIZATION =====
        0: begin rs = 0; data = 8'h38; end  // 8-bit mode
        1: begin rs = 0; data = 8'h0C; end  // display ON
        2: begin rs = 0; data = 8'h01; end  // clear display
        3: begin rs = 0; data = 8'h06; end  // entry mode
        4: begin rs = 0; data = 8'h80; end  // cursor to start

        // ===== DISPLAY MESSAGE =====
        5: begin rs = 1; data = message[0]; end
        6: begin rs = 1; data = message[1]; end
        7: begin rs = 1; data = message[2]; end
        8: begin rs = 1; data = message[3]; end

        default: begin
            rs = 1;
            data = 8'h20;
        end

    endcase
end

endmodule
