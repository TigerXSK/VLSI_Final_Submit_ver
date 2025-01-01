module io_v1 (D, B1, B2, addr, cha, chb, clk, WE, B0, B3, Da, Db);
    input [7:0] D;
    input [7:0] B1, B2;
    input [1:0] addr, cha, chb;
    input clk, WE;
    output [7:0] B0, B3, Da, Db;

    reg [7:0] Q3, Q2, Q1, Q0;
    wire [7:0] K1, K2;
    reg [1:0] choicetema, choicetemb;
    reg [7:0] Da, Db;

    // Decoder + Data register
    always @(posedge clk) begin
        if (WE) begin
            case (addr)
                2'b00: Q0 <= D;
                2'b01: Q1 <= D;
                2'b10: Q2 <= D;
                2'b11: Q3 <= D;
            endcase
        end else begin
            Q0 <= Q0;
            Q1 <= Q1;
            Q2 <= Q2;
            Q3 <= Q3;
        end
    end

    // Tristate buffer and I/O
    buffif1 t1_0(.y(K1[0]), .a(Q1[0]), .en(Q0[0]));
    buffif1 t1_1(.y(K1[1]), .a(Q1[1]), .en(Q0[0]));
    buffif1 t1_2(.y(K1[2]), .a(Q1[2]), .en(Q0[0]));
    buffif1 t1_3(.y(K1[3]), .a(Q1[3]), .en(Q0[0]));
    buffif1 t1_4(.y(K1[4]), .a(Q1[4]), .en(Q0[0]));
    buffif1 t1_5(.y(K1[5]), .a(Q1[5]), .en(Q0[0]));
    buffif1 t1_6(.y(K1[6]), .a(Q1[6]), .en(Q0[0]));
    buffif1 t1_7(.y(K1[7]), .a(Q1[7]), .en(Q0[0]));

    buffif1 t2_0(.y(K2[0]), .a(Q2[0]), .en(Q0[1]));
    buffif1 t2_1(.y(K2[1]), .a(Q2[1]), .en(Q0[1]));
    buffif1 t2_2(.y(K2[2]), .a(Q2[2]), .en(Q0[1]));
    buffif1 t2_3(.y(K2[3]), .a(Q2[3]), .en(Q0[1]));
    buffif1 t2_4(.y(K2[4]), .a(Q2[4]), .en(Q0[1]));
    buffif1 t2_5(.y(K2[5]), .a(Q2[5]), .en(Q0[1]));
    buffif1 t2_6(.y(K2[6]), .a(Q2[6]), .en(Q0[1]));
    buffif1 t2_7(.y(K2[7]), .a(Q2[7]), .en(Q0[1]));

    assign B0 = Q0; // Data output
    assign B1 = K1; // I/O
    assign B2 = K2; // I/O
    assign B3 = Q3; // Data output

    // Address register and I/O
    always @(posedge clk) begin
        choicetema <= cha;
        choicetemb <= chb;
    end
    always @(choicetema or Q3 or K2 or K1 or Q0) begin
        case (choicetema)
            2'b00: Da <= Q0;
            2'b01: Da <= K1;
            2'b10: Da <= K2;
            2'b11: Da <= Q3;
        endcase
    end
    // Data register and I/O
    always @(choicetemb or Q3 or K2 or K1 or Q0) begin
        case (choicetemb)
            2'b00: Db <= Q0;
            2'b01: Db <= K1;
            2'b10: Db <= K2;
            2'b11: Db <= Q3;
        endcase
    end

endmodule

module buffif1 (
    y,
    a,
    en
);
    output reg y;
    input wire a;
    input wire en;

    always @(*) begin
        if (en) begin
            y = a;
        end else begin
            y = 1'bz;
        end
    end
endmodule