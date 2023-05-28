`include "reg.v"
`include "alu.v"
`include "multiplexer32.v"
`include "controlUnit.v"





module cpu (PC, INSTRUCTION, CLK, RESET );

    // port declaration
    input CLK, RESET;
    input [18:0] INSTRUCTION;
    output reg [31:0] PC ;
    
    // wires for internal implementation
    wire  IMM_SELECT, WRITE_ENABLE, ZERO,BRANCH,BRAZ,BRANZ,BRAUNCOND, AND_OUT, OR_OUT, AND_OUT2, MOV_SELECT;

    wire [2:0] ALUOP;
    wire [31:0] NEXTPC,B_MUX_OUT, ADDR_OUT, NEXTPC2, ALU_OUT,  OUT1, OUT2, IMM_RESULT, SIGN_EXTENDED_IMM,PC_PLUS_IMM, REG_IN;
    
    //  initiating the modules    
    controlUnit mucu(ALUOP, WRITE_ENABLE, IMM_SELECT,BRAZ,BRANZ,BRAUNCOND, INSTRUCTION[18:15],MOV_SELECT);
    reg_file myregfile(REG_IN, OUT1, OUT2, INSTRUCTION[14:10],INSTRUCTION[9:5], INSTRUCTION[4:0],  WRITE_ENABLE, CLK, RESET);
   
    signExtend signex(SIGN_EXTENDED_IMM, INSTRUCTION[14:0]);

    mux32 immediate_or_reg(IMM_RESULT, OUT2, SIGN_EXTENDED_IMM, IMM_SELECT);

    Alu alu(ALU_OUT, OUT1, IMM_RESULT, ALUOP);  
    addr adr(NEXTPC, PC, 'd1);
    addr adr2(PC_PLUS_IMM, PC, SIGN_EXTENDED_IMM);

    andgate a1(AND_OUT, BRAZ, ZERO);
    andgate a2(AND_OUT2, BRANZ, ~ZERO);
    orgate or1(OR_OUT,AND_OUT, AND_OUT2, BRAUNCOND);
 
    mux32 jump_mux (NEXTPC2 ,NEXTPC, PC_PLUS_IMM,OR_OUT);
    mux32 move_mux (REG_IN ,ALU_OUT, { {22{INSTRUCTION[9]}}, INSTRUCTION[9:0] },MOV_SELECT);

    
    // pc update with clock
    always @(posedge CLK) begin
        if(RESET) PC = 0;
        else #1 PC = NEXTPC2;
    end

endmodule

// adder
module addr (NEXTPC, PC, ONE);

    input [31:0] PC, ONE ;
    output [31:0] NEXTPC;
    assign  #1 NEXTPC =  PC + ONE;
    
endmodule

// adder
module signExtend (NEW_VAL, CURRENT_VAL);

    input[14:0] CURRENT_VAL;
    output [31:0] NEW_VAL;
    assign NEW_VAL = { {17{CURRENT_VAL[31]}}, CURRENT_VAL };
   
    
endmodule

// AND GATE
module andgate (OUTPUT, INPUT1, INPUT2);
    input INPUT1, INPUT2;
    output OUTPUT;
    assign OUTPUT = INPUT1 & INPUT2;
endmodule

// OR GATE
module orgate (OUTPUT, INPUT1, INPUT2, INPUT3);
    input INPUT1, INPUT2, INPUT3;
    output OUTPUT;
    assign OUTPUT = INPUT1 | INPUT2 | INPUT3;
endmodule