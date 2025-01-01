module control_v1 (contl, clk, jump2, jump1, ret1, push1, wen1);
input [3:0] contl;
input clk, jump2;
output jump1, ret1, push1, wen1;
reg jump1, ret1, push1, wen1;

initial begin
    jump1 = 1'b0; // 預設：不執行跳躍操作
    ret1 = 1'b0; // 預設：不執行回傳操作
    push1 = 1'b0; // 預設：不執行推入操作
    wen1 = 1'b0; // 預設：不啟用寫入
end
always @(posedge clk)
begin

    // 根據contl的值進行控制邏輯
    case (contl)
        4'b0001: begin
            // 情況1：RET（從子程序返回）
            jump1 <= ~jump2; // 傳遞條件非跳躍信號
            ret1 <= ~jump2;  // 設定回傳信號
            push1 <= push1;  // 保持推入信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b0010: begin
            // 情況2：JUMP（無條件跳躍）
            ret1 <= ret1;    // 保持回傳信號不變
            jump1 <= ~jump2;  // 傳遞條件非跳躍信號
            push1 <= push1;  // 保持推入信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b0011: begin
            // 情況3：CALL（函數呼叫，保存返回地址）
            push1 <= ~jump2;  // 啟用推入操作以保存地址
            jump1 <= ~jump2;  // 傳遞條件非跳躍信號
            ret1 <= ret1;    // 保持回傳信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b0100: begin
            // 情況4：JZ（運算結果為零跳躍）
            jump1 <= ~jump2;  // 傳遞條件非跳躍信號
            ret1 <= ret1;    // 保持回傳信號不變
            push1 <= push1;  // 保持推入信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b0101: begin
            // 情況5：JNZ（運算結果為非零跳躍）
            jump1 <= ~jump2;  // 傳遞條件非跳躍信號
            ret1 <= ret1;    // 保持回傳信號不變
            push1 <= push1;  // 保持推入信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b0110: begin
            // 情況6：JC（進位標誌為1跳躍）
            jump1 <= ~jump2;  // 傳遞條件非跳躍信號
            ret1 <= ret1;    // 保持回傳信號不變
            push1 <= push1;  // 保持推入信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b0111: begin
            // 情況7：JNC（進位標誌為0跳躍）
            jump1 <= ~jump2;  // 傳遞條件非跳躍信號
            ret1 <= ret1;    // 保持回傳信號不變
            push1 <= push1;  // 保持推入信號不變
            wen1 <= wen1;    // 保持寫入信號不變
        end
        4'b1xxx: begin
            // 情況8：資料運算指令
            wen1 <= ~jump2;   // 啟用條件非跳躍信號作為寫入
            ret1 <= ret1;    // 保持回傳信號不變
            push1 <= push1;  // 保持推入信號不變
            jump1 <= jump1;  // 保持跳躍信號不變
        end
        default: begin
            // 其他情況：不執行任何操作
            ret1 <= 1'b0;
            push1 <= 1'b0;
            wen1 <= 1'b0;
            jump1 <= 1'b0;
        end
    endcase
end

endmodule
