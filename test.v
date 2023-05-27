`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  
// Create Date: 14.05.2023 19:12:15
// Design Name: 
// Module Name: sdfdf
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////

module test(
 input button1,
 input button2, 
 input  button3,
 input button4,
 input clk, 
 input button,
 output reg [6:0] led_out,
 output reg [3:0] A_Act
);

  ///reg [3:0] digit_select = 4'b0000; // Initial digit selection
  reg [31:0]outnum=0000; 
  reg [25:0] count_25ms;
  reg [3:0] seg_a;
  reg [3:0] seg_b;
  reg [3:0] seg_c;
  reg [3:0] seg_d;
  reg [1:0] level; 
  reg [6:0] seg_display [0:9];
  reg[4:0]x =0;
  reg  xnew=0;
 reg buttonnew;
 integer count = 0;
 integer delay = 650000; // 6.5ms delay


// reading outputed data from cpu
 reg [31:0] instr_mem [0:31]; 	// instruction array

integer i ;

        
    // initial
    // begin
        
    //     $readmemb("output.mem", instr_mem);
    // end
    
   

    // initial
    // begin
    
    //    #5
    //     for(i=0;i<32;i++)
    //     $display (instr_mem[i]);  
        
        
    // end

    initial begin
        {instr_mem[          0]}= 32'b00000000000000000000000000000000;
        {instr_mem[          1]}= 32'b00000000000000000000000000000001;
        {instr_mem[          2]}= 32'b00000000000000000000000000000010;
        {instr_mem[          3]}= 32'b00000000000000000000000000000010;
        {instr_mem[          4]}= 32'b00000000000000000000000000000011;
        {instr_mem[          5]}= 32'b00000000000000000000000000001000;
        {instr_mem[          6]}= 32'b00000000000000000000000000000001;
        {instr_mem[          7]}= 32'b00000000000000000000000000000000;
        {instr_mem[          8]}= 32'b00000000000000000000000000000101;
        {instr_mem[          9]}= 32'b00000000000000000000000000000000;
        {instr_mem[         10]}= 32'b00000000000000000000000000000000;
        {instr_mem[         11]}= 32'b00000000000000000000000000000000;
        {instr_mem[         12]}= 32'b00000000000000000000000000000000;
        {instr_mem[         13]}= 32'b00000000000000000000000000000000;
        {instr_mem[         14]}= 32'b00000000000000000000000000000000;
        {instr_mem[         15]}= 32'b00000000000000000000000000000000;
        {instr_mem[         16]}= 32'b00000000000000000000000000000000;
        {instr_mem[         17]}= 32'b00000000000000000000000000000000;
        {instr_mem[         18]}= 32'b00000000000000000000000000000000;
        {instr_mem[         19]}= 32'b00000000000000000000000000000000;
        {instr_mem[         20]}= 32'b00000000000000000000000000000000;
        {instr_mem[         21]}= 32'b00000000000000000000000000000000;
        {instr_mem[         22]}= 32'b00000000000000000000000000000000;
        {instr_mem[         23]}= 32'b00000000000000000000000000000000;
        {instr_mem[         24]}= 32'b00000000000000000000000000000000;
        {instr_mem[         25]}= 32'b00000000000000000000000000000000;
        {instr_mem[         26]}= 32'b00000000000000000000000000000000;
        {instr_mem[         27]}= 32'b00000000000000000000000000000000;
        {instr_mem[         28]}= 32'b00000000000000000000000000000000;
        {instr_mem[         29]}= 32'b00000000000000000000000000000000;
        {instr_mem[         30]}= 32'b00000000000000000000000000000000;
        {instr_mem[         31]}= 32'b00000000000000000000000000000000;

     
    end

    // endo of reading part



initial begin
      seg_display[0] = 7'b1000000;
      seg_display[1] = 7'b1111001;
      seg_display[2] = 7'b0100100;
      seg_display[3] = 7'b0110000;
      seg_display[4] = 7'b0011001;
      seg_display[5] = 7'b0010010;
      seg_display[6] = 7'b0000010;
      seg_display[7] = 7'b1111000;
      seg_display[8] = 7'b0000000;
      seg_display[9] = 7'b0010000;
end

 always @(posedge clk) begin
    if (button != xnew) begin
      xnew <= button;
      count <= 0;
    end else if (count == delay) begin
      buttonnew <= xnew;
    end else begin
      count <= count + 1;
    end
  end

always @(posedge buttonnew) begin
    //if (posedge buttonnew) begin
      if (x <= 31) begin
       outnum <= instr_mem[x];
        x <= x + 1;
      end 
      else begin
        x<=0;
       // outnum <= instr_mem[x];
      end
      
  end


  
 
always @(posedge clk) begin
    // increment the 25ms counter
    count_25ms <= count_25ms + 1;
    
    // check if 25ms has elapsed
    if (count_25ms == 500000) begin
        count_25ms <= 0; // reset the 25ms counter
        
        // increment the level counter
        if (level == 4'b11) begin
            level <= 0; // reset the level counter
        end else begin
            level <= level+ 1;
        end
    end
end


always @(*) begin
  
seg_a <= outnum / 1000;                 
seg_b <= (outnum % 1000) / 100;         
seg_c <= ((outnum % 1000)%100)/10;
seg_d <= ((outnum % 1000)%100)%10;

    
    if (level == 2'b00) begin
        A_Act = 4'b0111; 
        led_out=seg_display[seg_a];
    end
    else if (level == 2'b01) begin
        A_Act = 4'b1011; 
        led_out=seg_display[seg_b];
       
    end
    else if (level == 2'b10) begin
         A_Act = 4'b1101;  
         led_out=seg_display[seg_c];
    end
    else if (level == 2'b11) begin
         A_Act = 4'b1110; 
         led_out =seg_display[seg_d]; 
    end
  end
 


endmodule