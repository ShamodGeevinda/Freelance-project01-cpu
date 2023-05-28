module freg(IN, ZERO, WRITE, CLK, RESET);

	input WRITE, CLK, RESET;				// 1-bit inputs
	input [31:0] IN;						// 32-bits input
    output  ZERO;
			// 32-bits outputs

	reg [31:0] register;		

       
    assign #1 ZERO =  ~(|register); 
	


	// write to given address register at positive edge of the clock
	always @(posedge CLK) 
	begin 
		// writting happens when WRITE is high. 
		// if statement includes only one row so don't use begin end keywords
		if (RESET == 0 && WRITE ==1 )	
			
			// this is synchronous therefore, we use non-blocking statement with delay 1 unit.
			// write in to given register
			#1 register <= IN ;

		
		// reset all the registers when RESET is high. 
		if ( RESET ) #1
		begin			
			
				register <= 32'b0;
			
		end
	
	end


    initial
    
    begin
        $dumpfile("cpu_wavedata.vcd");
            $dumpvars(1,register);
    end   


endmodule	


