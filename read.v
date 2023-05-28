

// module read();

	
// 	reg [31:0] instr_mem [31:0]; 	// instruction array
    
   
//     integer i ;

        
//     initial
//     begin
        
//         $readmemb("output.mem", instr_mem);
//     end
    
   

//     initial
//     begin
    
       
//         for(i=0;i<32;i++)
//         $display (instr_mem[i]);  
        
        
//     end







    
    

// endmodule

module OrOperationExample;

  reg [31:0] result;

  initial begin
    result = 10'b0000100101 | 2'b10;
    $display("Result: %d", result);
  end

endmodule