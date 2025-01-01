`timescale 1ps/1ps
module top_module ();
reg [11:0] PCounter, B;
reg jump;
wire [11:0] PCadd;

pcounter_v1 uut (
    .PCounter(PCounter),
    .B(B),
    .jump(jump),
    .PCadd(PCadd)
);


initial begin
    //case 1 jump==0
    PCounter = 12'd10;
    jump = 0;
    B = 12'd5;
    #1;
    if(PCadd == PCounter +1) 
    $display("passed! case 1: PCcounter = %d, jump = %d, B = %d, PCadd = %d", PCounter, jump, B, PCadd);
    else $display("fail at case 1 ! PCcounter = %d, jump = %d, B = %d, PCadd = %d", PCounter, jump, B, PCadd);

    //case 2 jump==1 w/ differ pc & b
    PCounter = 12'd20;
    jump = 1;
    B = 12'd10;
    #1;
    if(PCadd == PCounter +B) 
    $display("passed! case 2: PCcounter = %d, jump = %d, B = %d, PCadd = %d", PCounter, jump, B, PCadd);
    else $display("fail at case 2 ! PCcounter = %d, jump = %d, B = %d, PCadd = %d", PCounter, jump, B, PCadd);
    $finish;
end


endmodule