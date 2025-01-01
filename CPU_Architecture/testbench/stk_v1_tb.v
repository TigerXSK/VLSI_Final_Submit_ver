`timescale 1ns/1ps

module top_module();
    reg [11:0] pcx;
    reg Clk, push;
    reg [1:0] sp;
    wire [11:0] stko;

    stk_v1 uut (
        .pcx(pcx),
        .Clk(Clk),
        .push(push),
        .sp(sp),
        .stko(stko)
    );

    always #5 Clk = ~Clk;
    initial Clk = 0;


    initial begin
        
        push = 0; sp = 2'b00; pcx = 12'd0;

        // Case 1: push = 1, sp = 0
        @(negedge Clk); push = 1; sp = 2'd0; pcx = 12'd100;
        @(posedge Clk); 
        #10;
        #1;
        if (stko == 12'd100)
            $display("Test Case 1 passed: stko = %d", stko);
        else
            $display("Test Case 1 failed: stko = %d", stko);

        // Case 2: push = 1, sp = 1
        @(negedge Clk); sp = 2'd1; pcx = 12'd200;
        @(posedge Clk); 
        #10;
        #1;
        if (stko == 12'd200)
            $display("Test Case 2 passed: stko = %d", stko);
        else
            $display("Test Case 2 failed: stko = %d", stko);

        // Case 3: push = 1, sp = 2
        @(negedge Clk); sp = 2'd2; pcx = 12'd300;
        @(posedge Clk); 
        #10;
        #1;
        if (stko == 12'd300)
            $display("Test Case 3 passed: stko = %d", stko);
        else
            $display("Test Case 3 failed: stko = %d", stko);

        // Case 4: push = 1, sp = 3
        @(negedge Clk); sp = 2'd3; pcx = 12'd400;
        @(posedge Clk); 
        #10;
        #1;
        if (stko == 12'd400)
            $display("Test Case 4 passed: stko = %d", stko);
        else
            $display("Test Case 4 failed: stko = %d", stko);

        // Case 5: push = 0 (保持 stko)
        @(negedge Clk); push = 0; sp = 2'd3;
        @(posedge Clk); 
        #10;
        #1;
        if (stko == 12'd400)
            $display("Test Case 5 passed: stko = %d", stko);
        else
            $display("Test Case 5 failed: stko = %d", stko);

        // Case 6: 多次写入和读取
        @(negedge Clk); push = 1; sp = 2'd0; pcx = 12'd500;
        @(posedge Clk); #1;
        @(negedge Clk); sp = 2'd1; pcx = 12'd600;
        @(posedge Clk); #1;
        @(negedge Clk); sp = 2'd0;
        @(posedge Clk); 
        #1;
        if (stko == 12'd500)
            $display("Test Case 6 passed: stko = %d", stko);
        else
            $display("Test Case 6 failed: stko = %d", stko);

        $finish;
    end
endmodule
