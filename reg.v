module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);

	input WRITE, CLK, RESET;				// 1-bit inputs
	input [4:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;	// 5-bits inputs
	input [31:0] IN;						// 32-bits input

	output [31:0] OUT1, OUT2;				// 32-bits outputs

	reg [31:0] registers[0:31];		// this represents the 32-bits(4 byte)  32 registers


	integer regNum ;			// represet the register number for the RESET task
       
 integer i,f;  
	// assign given addresses values to OUT1 and OUT2 respectively. this is asynchronous therefore, we use blocking statement with delay 2 units
	assign #2 OUT1 = registers[OUT1ADDRESS];	
	assign #2 OUT2 = registers[OUT2ADDRESS];


	// write to given address register at positive edge of the clock
	always @(posedge CLK) 
	begin 
		// writting happens when WRITE is high. 
		// if statement includes only one row so don't use begin end keywords
		if (RESET == 0 && WRITE ==1 )	
			
			// this is synchronous therefore, we use non-blocking statement with delay 1 unit.
			// write in to given register
			#1 registers[INADDRESS] <= IN ;

		
		// reset all the registers when RESET is high. 
		if ( RESET ) #1
		begin
			
			for(regNum = 0; regNum < 32 ; regNum = regNum + 1)begin
			
				registers[regNum] <= 32'b0;

			end
			
			
			
		end
	
	end


    initial
    
    begin
        $dumpfile("cpu_wavedata.vcd");
        for(i=0;i<32;i++)
            $dumpvars(1,registers[i]);
    end   


	initial begin
		#200
  		f = $fopen("output.mem","w");
	end

	initial begin
		#210
  		for (i = 0; i<32; i=i+1)
    	$fwrite(f,"%b\n",registers[i]);
	end

	initial begin
		#215
  		$fclose(f);  
	end

endmodule	


