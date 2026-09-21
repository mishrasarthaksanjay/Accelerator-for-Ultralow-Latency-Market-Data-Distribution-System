`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2026 11:00:49 PM
// Design Name: 
// Module Name: vli_receiver
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


module vli_receiver(clk,rst,in_valid,in_byte,out_value,out_valid);
      input clk,rst,in_valid;
      input  [7:0]in_byte;
      output reg [63:0]out_value;
      output reg out_valid;
      reg [63:0]acc;
      always@(posedge clk)begin
       if(rst) begin
       acc<=64'd0;
       out_value<=64'd0;
       out_valid<=1'b0;
       end 
       else begin
       out_valid<=1'b0;
       if(in_valid) begin
        if(in_byte[7]) begin
          out_value<=(acc<<7|in_byte[6:0]);
          out_valid<=1'b1;
          end
          else begin
          out_value<=(acc<<7|in_byte[6:0]);
          out_valid<=1'b0;
          end
        end   
      end
  end
endmodule
