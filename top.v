module Top(
    input wire clk,              // Clock signal
    input wire [3:0] col,        // Keypad column inputs
    output reg [3:0] row,        // Keypad row scan outputs
    output reg [6:0] seg         // 7-segment display output
);

reg [3:0] key_val;
reg [3:0] keypad_map [0:3][0:3];
reg [1:0] row_counter;

// 7-Segment Display Decoder (Active-low/Active-high mapping)
always @(*) begin
    case (key_val)
        4'b0000: seg = 7'b0000001; // 0
        4'b0001: seg = 7'b1001111; // 1
        4'b0010: seg = 7'b0010010; // 2
        4'b0011: seg = 7'b0000110; // 3
        4'b0100: seg = 7'b1001100; // 4
        4'b0101: seg = 7'b0100100; // 5
        4'b0110: seg = 7'b0100000; // 6
        4'b0111: seg = 7'b0001111; // 7
        4'b1000: seg = 7'b0000000; // 8
        4'b1001: seg = 7'b0000100; // 9
        4'b1010: seg = 7'b0001000; // A
        4'b1011: seg = 7'b1100000; // B
        4'b1100: seg = 7'b0110001; // C
        4'b1101: seg = 7'b1000010; // D
        4'b1110: seg = 7'b0110000; // E
        4'b1111: seg = 7'b0111000; // F
        default: seg = 7'b1111111; // Display OFF
    endcase
end

// Keypad Matrix Mapping
initial begin
    keypad_map[0][0] = 4'b0001; // Row 1: 1
    keypad_map[1][0] = 4'b0010; // Row 1: 2
    keypad_map[2][0] = 4'b0011; // Row 1: 3
    keypad_map[3][0] = 4'b1010; // Row 1: A

    keypad_map[0][1] = 4'b0100; // Row 2: 4
    keypad_map[1][1] = 4'b0101; // Row 2: 5
    keypad_map[2][1] = 4'b0110; // Row 2: 6
    keypad_map[3][1] = 4'b1011; // Row 2: B

    keypad_map[0][2] = 4'b0111; // Row 3: 7
    keypad_map[1][2] = 4'b1000; // Row 3: 8
    keypad_map[2][2] = 4'b1001; // Row 3: 9
    keypad_map[3][2] = 4'b1100; // Row 3: C

    keypad_map[0][3] = 4'b1110; // Row 4: E
    keypad_map[1][3] = 4'b0000; // Row 4: 0
    keypad_map[2][3] = 4'b1111; // Row 4: F
    keypad_map[3][3] = 4'b1101; // Row 4: D

    row = 4'b0001;
    key_val = 4'b0000;
    row_counter = 2'b00;
end

// Row Scanning FSM
always @(posedge clk) begin
    row_counter <= row_counter + 1'b1;
    case (row_counter)
        2'b00: row <= 4'b0001;
        2'b01: row <= 4'b0010;
        2'b10: row <= 4'b0100;
        2'b11: row <= 4'b1000;
        default: row <= 4'b0001;
    endcase
end

// Key Press Detection
always @(posedge clk) begin
    case (row)
        4'b0001: begin
            if (col[0]) key_val <= keypad_map[0][0];
            else if (col[1]) key_val <= keypad_map[0][1];
            else if (col[2]) key_val <= keypad_map[0][2];
            else if (col[3]) key_val <= keypad_map[0][3];
        end
        4'b0010: begin
            if (col[0]) key_val <= keypad_map[1][0];
            else if (col[1]) key_val <= keypad_map[1][1];
            else if (col[2]) key_val <= keypad_map[1][2];
            else if (col[3]) key_val <= keypad_map[1][3];
        end
        4'b0100: begin
            if (col[0]) key_val <= keypad_map[2][0];
            else if (col[1]) key_val <= keypad_map[2][1];
            else if (col[2]) key_val <= keypad_map[2][2];
            else if (col[3]) key_val <= keypad_map[2][3];
        end
        4'b1000: begin
            if (col[0]) key_val <= keypad_map[3][0];
            else if (col[1]) key_val <= keypad_map[3][1];
            else if (col[2]) key_val <= keypad_map[3][2];
            else if (col[3]) key_val <= keypad_map[3][3];
        end
        default: key_val <= 4'b0000;
    endcase
end

endmodule
