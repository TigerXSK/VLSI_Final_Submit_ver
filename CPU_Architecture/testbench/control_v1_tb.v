`timescale 1ns/1ps

module top_module;

    reg [3:0] contl;
    reg clk, jump2;
    wire jump1, ret1, push1, wen1;


    control_v1 uut (
        .contl(contl),
        .clk(clk),
        .jump2(jump2),
        .jump1(jump1),
        .ret1(ret1),
        .push1(push1),
        .wen1(wen1)
    );


    always #5 clk = ~clk; 
    initial clk = 0;

    initial begin
        contl=0;
        jump2=1;
        #10;
        test_case(4'b0001, 1, ~jump2, ~jump2, 0, 0); // RET
        test_case(4'b0010, 1, ~jump2, 0, 0, 0);      // JUMP
        test_case(4'b0011, 1, ~jump2, 0, ~jump2, 0); // CALL
        test_case(4'b0100, 1, ~jump2, 0, 0, 0);      // JZ
        test_case(4'b0101, 1, ~jump2, 0, 0, 0);      // JNZ
        test_case(4'b0110, 1, ~jump2, 0, 0, 0);      // JC
        test_case(4'b0111, 1, ~jump2, 0, 0, 0);      // JNC
        test_case(4'b1000, 1, 0, 0, 0, ~jump2);      // 数据运算指令
        $finish;
    end

    task test_case;
        input [3:0] t_contl;
        input t_jump2;
        input exp_jump1, exp_ret1, exp_push1, exp_wen1;
        begin
            // 应用输入
            contl = t_contl;
            jump2 = t_jump2;
            #10; // 等待一个时钟周期

            // 检查输出是否正确
            if (jump1 === exp_jump1 && ret1 === exp_ret1 && push1 === exp_push1 && wen1 === exp_wen1) begin
                $display("Test Case Passed: contl = %b | jump1 = %b, ret1 = %b, push1 = %b, wen1 = %b", t_contl, jump1, ret1, push1, wen1);
            end else begin
                $display("Test Case Failed: contl = %b | jump1 = %b, ret1 = %b, push1 = %b, wen1 = %b | Expected: jump1 = %b, ret1 = %b, push1 = %b, wen1 = %b",
                         t_contl, jump1, ret1, push1, wen1, exp_jump1, exp_ret1, exp_push1, exp_wen1);
            end
        end
    endtask
endmodule
