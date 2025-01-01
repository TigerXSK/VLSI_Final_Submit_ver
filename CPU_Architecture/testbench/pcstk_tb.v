`timescale 1ps/1ps

module top_module ();
reg [11:0] jnumber, stko, pc_in;
reg clk, jump, ret;
wire [11:0] pc;

pcstk_v1 uut(
    .pc_in (pc_in),
    .jnumber(jnumber),
    .stko(stko),
    .clk(clk),
    .jump(jump),
    .ret(ret),
    .pc(pc)
);

always #5 clk = ~clk;
initial clk = 0;

initial begin
    //case 1 ret = 0, jump = 0
    jump = 0;
    jnumber = 12'd5;
    ret = 0;
    stko = 12'd10;
    pc_in = 12'd20;

    @(posedge clk); #1;
    if(pc == pc_in +1 ) $display ("Passed case 1! , pc_in = %d, pc = %d, stko = %d, jnumber = %d",pc_in, pc,stko,jnumber) ;
    else $display ("Failed at case 1! , pc_in = %d, pc = %d, ret = %d, jump = %d",pc_in, pc, ret, jump) ;
    
    //case 2 ret = 0, jump = 1
    @(negedge clk);
    jump = 1;

    @(posedge clk); #1;
    if(pc == pc_in + jnumber) $display ("Passed case 2! , pc_in = %d, pc = %d, stko = %d, jnumber = %d",pc_in, pc,stko,jnumber) ;
    else $display ("Failed at case 2! , pc_in = %d, pc = %d, ret = %d, jump = %d, jnumber = %d ",pc_in, pc, ret, jump, jnumber) ;

    //case 3 ret = 1
    @(negedge clk); 
    ret = 1; jump = 1;
    
    @(posedge clk); #1;
    if(pc == stko) $display ("Passed case 3! , pc_in = %d, pc = %d, stko = %d, jnumber = %d",pc_in, pc,stko,jnumber) ;
    else $display ("Failed at case 3! , pc_in = %d, pc = %d, ret = %d, stko = %d ",pc_in, pc, ret, stko) ;

$finish;
end

endmodule