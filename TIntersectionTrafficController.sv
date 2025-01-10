`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 14:36:17
// Design Name: 
// Module Name: TIntersectionTrafficController
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

module TIntersectionTrafficController (
    input logic clk,             
    input logic reset,            
    output logic main_red,        
    output logic main_yellow,     
    output logic main_green,      
    output logic side_red,        
    output logic side_yellow,     
    output logic side_green       
);
    typedef enum logic [1:0] {
        MAIN_GREEN = 2'b00,
        MAIN_YELLOW = 2'b01,
        SIDE_GREEN = 2'b10,
        SIDE_YELLOW = 2'b11
    } state_t;

    state_t state, next_state;    
    logic [27:0] timer;           

    
    localparam int MAX_COUNT = 250_000_000; 

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= MAIN_GREEN;   
            timer <= 0;            
        end else begin
            if (timer == MAX_COUNT - 1) begin
                
                case (state)
                    MAIN_GREEN: state <= MAIN_YELLOW;
                    MAIN_YELLOW: state <= SIDE_GREEN;
                    SIDE_GREEN: state <= SIDE_YELLOW;
                    SIDE_YELLOW: state <= MAIN_GREEN;
                    default: state <= MAIN_GREEN;
                endcase
                timer <= 0;        
            end else begin
                timer <= timer + 1; 
            end
        end
    end

    
    always_comb begin
        
        main_red = 1;
        main_yellow = 0;
        main_green = 0;
        side_red = 1;
        side_yellow = 0;
        side_green = 0;

        case (state)
            MAIN_GREEN: begin
                main_red = 0;
                main_green = 1;
                side_red = 1;
            end
            MAIN_YELLOW: begin
                main_red = 0;
                main_yellow = 1;
                side_red = 1;
            end
            SIDE_GREEN: begin
                main_red = 1;
                side_red = 0;
                side_green = 1;
            end
            SIDE_YELLOW: begin
                main_red = 1;
                side_red = 0;
                side_yellow = 1;
            end
        endcase
    end

endmodule