module Alu ( RESULT, DATA1, DATA2, SELECT);

// port declaration
input [31:0] DATA1, DATA2;
input [2:0] SELECT;
output reg [31:0] RESULT;





wire [31:0] ADD_OUT, FORWARD_OUT, AND_OUT, OR_OUT,SUB_OUT;


// module initialize
Forward fwd1(FORWARD_OUT, DATA2 );
Add add1(ADD_OUT, DATA1, DATA2 );
Sub sub1(SUB_OUT, DATA1, DATA2 );
And and1(AND_OUT, DATA1, DATA2 );
Or or1(OR_OUT, DATA1, DATA2 );





// assign ZERO = ~(|RESULT);


always @(*) begin //always @(*) begin
    
    
    
      
    case (SELECT)
        'b000:
            RESULT = ADD_OUT;
        'b001:
            RESULT = SUB_OUT; 
        'b010:
            RESULT = AND_OUT; 
        'b011:
            RESULT = OR_OUT; 
        'b100:
            RESULT = FORWARD_OUT; 
        default:
            RESULT = 'b00000000;

    endcase

end


endmodule

// arithmatic modules

module Forward (FORWARD_OUT, DATA2);
    input [31:0]  DATA2;
    output [31:0] FORWARD_OUT;
    assign #1 FORWARD_OUT =  DATA2; 
    
endmodule

module Add (ADD_OUT, DATA1, DATA2);
    input [31:0] DATA1, DATA2;
    output [31:0] ADD_OUT;
    assign #2  ADD_OUT =  DATA1+DATA2; 
    
endmodule

module Sub (ADD_OUT, DATA1, DATA2);
    input [31:0] DATA1, DATA2;
    output [31:0] ADD_OUT;
    assign #2  ADD_OUT =  DATA1-DATA2; 
    
endmodule

module And (AND_OUT, DATA1, DATA2);
    input [31:0] DATA1, DATA2;
    output [31:0] AND_OUT;
    assign #1 AND_OUT =  DATA1 & DATA2; 
    
endmodule

module Or (OR_OUT, DATA1, DATA2);
    input [31:0] DATA1, DATA2;
    output [31:0] OR_OUT;
    assign  #1 OR_OUT =  DATA1 | DATA2; 
    
endmodule
