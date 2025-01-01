module tcnd_v1(contl, aluo, tcnd);
input [3:0] contl;
input [8:0] aluo;
output tcnd;
reg tcnd;

always @(contl or aluo)
begin
    case (contl)
        1 : tcnd = 1'b1;                // 無條件回主程式 RET
        2 : tcnd = 1'b1;                // 無條件跳躍 JUMP
        3 : tcnd = 1'b1;                // 無條件呼叫 CALL
        4 : tcnd = ~|aluo[7:0];         // 計算結果為 0 時 JZ
        5 : tcnd = |aluo[7:0];          // 計算結果為非 0 時 JNZ
        6 : tcnd = aluo[8];             // 進位標誌為 1 時 JC
        7 : tcnd = ~aluo[8];            // 進位標誌為 0 時 JNC  // zero flag
        default : tcnd = 1'b0;          // 預設條件
    endcase
end

endmodule
