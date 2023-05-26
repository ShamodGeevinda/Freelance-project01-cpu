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