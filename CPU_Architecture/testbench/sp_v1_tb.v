`timescale 1ps/1ps

module top_module ();
reg Clk, pop, push;
reg [1:0]sp_in;
wire [1:0] sp;

sp_v1 uut(
    .Clk(Clk),
    .pop(pop),
    .push(push),
    .sp_in(sp_in),
    .sp(sp)
);

always #5 Clk = ~Clk;
initial Clk = 0;

initial begin
    //case 1 pop=1 push =0
    sp_in =2'd0; 
    pop = 1;
    push = 0;
    @(posedge Clk);
    #1;
    if(sp == sp_in+1) 
    $display ("pass case 1, pop = %d , push = %d , sp_in =%d , sp =%d", pop, push, sp_in, sp);
    else $display ("Failed!, pop = %d , push = %d , sp_in =%d , sp =%d", pop, push, sp_in, sp);

    //case 2 pop=0, push=1
    @(negedge Clk);
        sp_in =2'd1; 
        pop = 0;
        push = 1;

    @(posedge Clk);
    #1;
        if(sp == sp_in-1) 
        $display ("pass case 2, pop = %d , push = %d , sp_in =%d , sp =%d", pop, push, sp_in, sp);
        else $display ("Fail case 2, pop = %d , push = %d , sp_in = %d ,sp = %d", pop, push, sp_in, sp);
    

    //case 3 pop = 0 , push = 0;
    @(negedge Clk);
        sp_in =2'd2; 
        pop = 0;
        push = 0;
    
    @(posedge Clk);
    #1;
        if(sp == sp_in) 
        $display ("pass case 3, pop = %d , push = %d , sp_in =%d , sp =%d", pop, push, sp_in, sp);
        else $display ("Fail case 3, pop = %d , push = %d , sp_in = %d ,sp = %d", pop, push, sp_in, sp);

$finish;
end

endmodule