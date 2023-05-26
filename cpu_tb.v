
`include "cpu.v"

module cpu_tb;

    reg CLK, RESET;
    wire [31:0] PC ;
    wire [18:0] INSTRUCTION;
    
   
	
	reg [18:0] instr_mem [127:0]; 	// instruction array
    
   integer i;  
    
	assign #2 INSTRUCTION = {instr_mem[PC]};	// fetching instruction with time delay
	
    initial
    begin
        // initializin ram module
       

    //    // Unconditional Branch
	// 	{instr_mem[0] }= 19'b1000000010001000001;
    //     {instr_mem[1] }= 19'b1000000010001000001;
    //     {instr_mem[2] }= 19'b1000000100001000010;
    //     {instr_mem[3] }= 19'b100000011xxxxx00010;

    //     {instr_mem[4] }= 19'b0000001000000100010;
    //     {instr_mem[5] }= 19'b0001001010010000101;
    //     {instr_mem[6] }= 19'b0010001100010100010;

    //     {instr_mem[7] }= 19'b0011001100001000001;
    //     {instr_mem[8] }= 19'b0100001110001100101;
    //     {instr_mem[9] }= 19'b0101001110011000111;

    //     {instr_mem[10]} = 19'b0110010000011100000;
    //     {instr_mem[11]} = 19'b0111010000011100100;
    //     {instr_mem[12]} = 19'b1011xxxxxxxxxx01010;

        


         // BRANZ
        {instr_mem[0] }= 19'b1000000010001000001;
        {instr_mem[1] }= 19'b1000000010001000001;
        {instr_mem[2] }= 19'b1000000100001000010;
        {instr_mem[3] }= 19'b100000011xxxxx00010;

        {instr_mem[4] }= 19'b0000001000000100010;
        {instr_mem[5] }= 19'b0001001010010000101;
        {instr_mem[6] }= 19'b0010001100010100010;

        {instr_mem[7] }= 19'b0011001100001000001;
        {instr_mem[8] }= 19'b0100001110001100101;
        {instr_mem[9] }= 19'b0101001110011000111;

        {instr_mem[10]} = 19'b0110010000011100000;
        {instr_mem[11]} = 19'b0111010000011100100;
        {instr_mem[12]} = 19'b1001000100000100101;


        // BRAZ

        //  {instr_mem[0] }= 19'b1000000010001000001;
        // {instr_mem[1] }= 19'b1000000010001000001;
        // {instr_mem[2] }= 19'b1000000100001000010;
        // {instr_mem[3] }= 19'b100000011xxxxx00010;

        // {instr_mem[4] }= 19'b0000001000000100010;
        // {instr_mem[5] }= 19'b0001001010010000101;
        // {instr_mem[6] }= 19'b0010001100010100010;

        // {instr_mem[7] }= 19'b0011001100001000001;
        // {instr_mem[8] }= 19'b0100001110001100101;
        // {instr_mem[9] }= 19'b0101001110011000111;

        // {instr_mem[10]} = 19'b0110010000011100000;
        // {instr_mem[11]} = 19'b0111010000011100100;
        // {instr_mem[12]} = 19'b1010000100001000101;
       


        // {instr_mem[15]} = 19'b1001001000001001001;
        // {instr_mem[16]} = 19'b0110110110000110110;
        // {instr_mem[17]} = 19'b1101101100001101101;
        // {instr_mem[18]} = 19'b0010010010000010010;
        // {instr_mem[19]} = 19'b1011011010001011011;
        
    end
    

    initial
    begin
        $dumpfile("cpu_wavedata.vcd");
        for(i=0;i<20;i++)
            $dumpvars(1,instr_mem[i]);
    end    
    /* 
    -----
     CPU
    -----
    */
    cpu mycpu(PC, INSTRUCTION, CLK, RESET);

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_tb);
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the proginstr_mem exe}cution
        RESET = 1'b1;
        #6
        RESET = 1'b0;

        // reset check
        #250
        RESET = 1'b1;
        #2
        RESET = 1'b0;
        //
		
		
        // finish simulation after some time
        #500
        $finish;
        
    end
    
    // clock signal generation
    always
        #4 CLK = ~CLK;
        

endmodule
