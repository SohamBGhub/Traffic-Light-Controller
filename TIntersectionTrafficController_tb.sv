`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2024 08:58:38
// Design Name: 
// Module Name: TIntersectionTrafficController_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TIntersectionTrafficController_tb;

    logic clk;              
    logic reset;            
    logic main_red;         
    logic main_yellow;      
    logic main_green;       
    logic side_red;         
    logic side_yellow;      
    logic side_green;       

    TIntersectionTrafficController uut (
        .clk(clk),
        .reset(reset),
        .main_red(main_red),
        .main_yellow(main_yellow),
        .main_green(main_green),
        .side_red(side_red),
        .side_yellow(side_yellow),
        .side_green(side_green)
    );
    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    
    initial begin
        
        reset = 1;
        #20;        
        reset = 0;  
        #1000000000; 

        
        reset = 1;
        #20;
        reset = 0;

        
        #500000000;  
        $finish;
    end

    
    initial begin
        $display("Time\tMain_Red\tMain_Yellow\tMain_Green\tSide_Red\tSide_Yellow\tSide_Green");
        $monitor("%0t\t%b\t\t%b\t\t%b\t\t%b\t\t%b\t\t%b", 
                  $time, main_red, main_yellow, main_green, side_red, side_yellow, side_green);
    end

endmodule