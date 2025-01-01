`timescale 1ps/1ps

module top_module();
    reg clk, direct;
    reg [3:0] D0, D1;
    wire [3:0] addr;


    addr_v1 uut(
        .clk(clk),
        .direct(direct),
        .D0(D0),
        .D1(D1),
        .addr(addr)
    );

   
    always #5 clk = ~clk;
    initial clk = 0;  

    initial begin
        direct = 0;
        D0 = $random % 16;
        D1 = $random % 16; 
        @(posedge clk);
        test;

        repeat (4) begin
            @(negedge clk);  
                D0 = $random % 16;
                D1 = $random % 16;
                direct = ~direct; 
            @(posedge clk);
                test;
                 
        end
        $finish;  
    end


    task test;
        begin
            #10;
            #1;
            if ((direct == 0 && addr == D0) || (direct == 1 && addr == D1)) begin
                $display("passed! Time = %0t | direct = %d, addr = %d, D0 = %d, D1 = %d", $time, direct, addr, D0, D1);
            end else begin
                $display("Time = %0t | direct = %d, addr = %d,  D0 = %d, D1 = %d, failed! Expected = %d", $time, direct, addr, D0, D1, (direct ? D1 : D0));
            end
        end
    endtask
endmodule
