module   controlUnit(ALUOP, WRITEENABLE, MUXIMM,BRAZ,BRANZ,BRAUNCOND, OPCODE, MOV_SELECT);
    input [3:0] OPCODE;
    output reg WRITEENABLE, MUXIMM, BRAZ,BRANZ,BRAUNCOND, MOV_SELECT;
    output reg [2:0] ALUOP;

    always @(*) begin
        #1
        case (OPCODE)   /// INSTRUCTION[31:24]
            
            'b0000: begin // add
                MUXIMM = 'b0 ;
                ALUOP = 3'b000;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                MOV_SELECT = 'b0;
            end 

            'b0001: begin // addi
                MUXIMM = 'b1 ;
                ALUOP = 3'b000;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end

            'b0010: begin // sub
                MUXIMM = 'b0 ;
                ALUOP = 3'b001;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end 

            'b0011: begin // subi
                MUXIMM = 'b1 ;
                ALUOP = 3'b001;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end 

             'b0100: begin // and
                MUXIMM = 'b0 ;
                ALUOP = 3'b010;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end 

            'b0101: begin // andi
                MUXIMM = 'b1 ;
                ALUOP = 3'b010;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end  

            'b0110: begin // or
                MUXIMM = 'b0 ;
                ALUOP = 3'b011;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end 

            'b0111: begin // ori
                MUXIMM = 'b1 ;
                ALUOP = 3'b011;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end   

            'b1000: begin // mov
                MUXIMM = 'b1 ;
                ALUOP = 3'b100;
                WRITEENABLE = 'b1;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b1;
            end 

            'b1001: begin // Branz
                MUXIMM = 'b0 ;
                ALUOP = 3'bxxx;
                WRITEENABLE = 'bx;
                BRAZ = 'b0;
                BRANZ = 'b1;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end 

            'b1010: begin // Braz
                MUXIMM = 'b0 ;
                ALUOP = 3'bxxx;
                WRITEENABLE = 'bx;
                BRAZ = 'b1;
                BRANZ = 'b0;
                BRAUNCOND = 'b0;
                 MOV_SELECT = 'b0;
            end      
    
            'b1011: begin // Brauncod
                MUXIMM = 'bx ;
                ALUOP = 3'bxxx;
                WRITEENABLE = 'bx;
                BRAZ = 'b0;
                BRANZ = 'b0;
                BRAUNCOND = 'b1;
                 MOV_SELECT = 'b0;
            end 

            default: begin 
                MUXIMM = 'bx ;
                ALUOP = 3'bxxx;
                WRITEENABLE = 'bx;
                BRAZ = 'bx;
                BRANZ = 'bx;
                BRAUNCOND = 'bx;
                 MOV_SELECT = 'bx;
            end              


                
        endcase   
    end
endmodule