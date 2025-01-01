module stk_v1 (pcx, Clk, push, sp, stko);
input [11:0] pcx;
input Clk, push;
input [1:0] sp;
output [11:0] stko;
reg [11:0] Q0, Q1, Q2, Q3;
reg [11:0] stko;

always @(posedge Clk) begin
    if (push) begin
        case (sp)
            2'b00: Q0 <= pcx;
            2'b01: Q1 <= pcx;
            2'b10: Q2 <= pcx;
            2'b11: Q3 <= pcx;
        endcase
    end

    case (sp)
        2'b00: stko <= Q0;
        2'b01: stko <= Q1;
        2'b10: stko <= Q2;
        2'b11: stko <= Q3;
    endcase
end

endmodule
