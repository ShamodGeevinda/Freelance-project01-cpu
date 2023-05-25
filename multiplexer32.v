// 32 bit 2 into 1 mux
module mux32 (OUTPUT, INPUT1, INPUT2, SELECT);
    input SELECT;
    input[31:0] INPUT1, INPUT2;
    output reg [31:0] OUTPUT;
    always @(*) begin
        if (SELECT==0) OUTPUT = INPUT1;
        else if (SELECT ==1) OUTPUT = INPUT2;
    end
    
endmodule