`timescale 1ns / 1ps

module top_tb;

reg clk;
reg [7:0] sw;

wire [2:0] led;
wire buzzer;

// DUT
top uut (
    .clk(clk),
    .sw(sw),
    .led(led),
    .buzzer(buzzer)
);

// Clock (50 MHz)
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

// Test sequence
initial begin

    sw = 8'b00000000;
    #100;

    // SAFE
    sw = 8'b00000000;
    #5000;

    // WARNING
    sw = 8'b00000011;
    #5000;

    // CRITICAL (SpO2)
    sw = 8'b00000100;
    #5000;

    // BP issue
    sw = 8'b00011000;
    #5000;

    // ECG
    sw = 8'b01000000;
    #5000;

    // EMERGENCY
    sw = 8'b10000000;
    #5000;

    // ALL
    sw = 8'b11111111;
    #5000;

    $stop;

end

endmodule