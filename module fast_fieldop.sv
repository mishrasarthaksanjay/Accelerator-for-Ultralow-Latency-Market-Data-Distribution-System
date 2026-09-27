module fast_fieldop(
        input clk,
        input rst,
        input [2:0]field_index,
        input [2:0]operator,
        input [63:0]r_value,
        input fieldopst,
        output reg [63:0]out_value);
        reg [63:0]memr[0:4];
        reg[63:0]res;
        integer i;
        always @(*)begin
            case(operator)
            3'd0:begin
                res=r_value;
            end
            3'd1:begin
                res=memr[field_index];
            end
            3'd2:begin
                res=memr[field_index];
            end
            3'd3:
            begin
                res=memr[field_index]+64'd1;
            end
            3'd4:
            begin
                res=memr[field_index]+r_value;
            end
            default: begin
                res=64'd0;
            end
            endcase
        end
        always@(posedge clk) begin
            if(rst)begin
                out_value<=64'd0;
                for (i = 0; i < 5; i = i + 1)
                memr[i] <= 64'd0;
            end
            else
            if(fieldopst)
            begin
                out_value<=res;
                memr[field_index]<=res;
            end
        end       
endmodule