`timescale 1ps/1ps

module top_module();
reg [7:0] Da, Db, romx;
reg clk, direct;
wire [7:0] dataa, datab;

direct_v1 uut (
    .Da(Da),
    .Db(Db),
    .romx(romx),
    .clk(clk),
    .direct(direct),
    .dataa(dataa),
    .datab(datab)
);

always #5 clk = ~clk;
initial clk = 0;

initial begin
    //case 1 direct = 0
    direct = 0;
    Da = 8'd10;
    Db = 8'd20;
    romx = 8'd5;
    #5;
    #1;
    if(dataa == Da && datab == Db) 
    $display ("Time = %0t | direct = %d, Da = %d, Db= %d, romx= %d, dataa= %d, datab= %d, passed!", $time, direct, Da, Db, romx, dataa, datab);
    else $display ("Time = %0t | direct = %d, Da = %d, Db= %d, romx= %d, dataa= %d, datab= %d, failed at case 1 !", $time, direct, Da, Db, romx, dataa, datab);
    
    #5;
    direct = 1;
    Da = 8'd15;
    Db = 8'd20;
    romx = 8'd10;
    
    #5;
    if(dataa == Da && datab == romx)
    $display ("Time = %0t | direct = %d, Da = %d, Db= %d, romx= %d, dataa= %d, datab= %d, passed at case 2 !", $time, direct, Da, Db, romx, dataa, datab);
    else $display ("Time = %0t | direct = %d, Da = %d, Db= %d, romx= %d, dataa= %d, datab= %d, failed at case 2 !", $time, direct, Da, Db, romx, dataa, datab);
    $stop;
    end

endmodule