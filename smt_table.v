module smt_table(
    input      [2:0] field_index,
    output reg [6:0] field_width,
    output reg       field_signed,
    output reg [2:0] operator
);
    localparam NONE      = 3'd0,
               COPY      = 3'd1,
               CONSTANT  = 3'd2,
               INCREMENT = 3'd3,
               DELTA     = 3'd4;
    always @(*) begin
    case (field_index)
        3'd0: begin field_width = 7'd8;  field_signed = 1'b0; operator = 3'd0; end // MsgType
        3'd1: begin field_width = 7'd16; field_signed = 1'b0; operator = 3'd3; end // SeqNum
        3'd2: begin field_width = 7'd32; field_signed = 1'b1; operator = 3'd4; end // TradePrice
        3'd3: begin field_width = 7'd26; field_signed = 1'b0; operator = 3'd1; end // SecurityID
        3'd4: begin field_width = 7'd8;  field_signed = 1'b0; operator = 3'd2; end // Exchange
        default: begin field_width = 7'd0; field_signed = 1'b0; operator = 3'd0;end// Default case No operation done by us
        endcase
    end
endmodule