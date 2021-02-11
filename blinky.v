module top(input clk_25mhz,
           input [6:0] btn,
           output [7:0] led,
           output wifi_gpio0);

    wire i_clk;

    // Tie GPIO0, keep board from rebooting
    assign wifi_gpio0 = 1'b1;
    assign i_clk = clk_25mhz;
    reg [7:0] o_led;
    
    // Assign the LED register to the LED outputs
    assign led = o_led;
    
    // Define a 1 bit register to hold the slow clock
    reg slow_clk;
    
    // Define two 32 bit counters
    localparam ctr_width = 32;
    reg [ctr_width-1:0] ctr1 = 0;
    reg [ctr_width-1:0] ctr2 = 0;

    // Increment ctr1 on each cycle of the 25MHz clock
    // Take slow_clk from bit 21 = 25MHz / 2^21 = 12Hz 
    always @(posedge i_clk) begin
        ctr1 <= ctr1 + 1;
        slow_clk <= ctr1[21];
    end
    
    // On each upwards transition of slow_clk
    always @(posedge slow_clk) begin
    
        // Reset ctr2 if it has overflowed, otherwise increment ctr2
    	if (ctr2 == 13)
    	begin
    	   ctr2 <= 0;
    	end
    	else
    	begin
    	   ctr2 <= ctr2 + 1;
    	end
    	
    	// Choose an output pattern based on the value of ctr2
    	case (ctr2)
    	     0 : o_led[7:0] = 8'b00000001;
    	     1 : o_led[7:0] = 8'b00000010;
    	     2 : o_led[7:0] = 8'b00000100;
    	     3 : o_led[7:0] = 8'b00001000;
    	     4 : o_led[7:0] = 8'b00010000;
    	     5 : o_led[7:0] = 8'b00100000;
    	     6 : o_led[7:0] = 8'b01000000;
    	     7 : o_led[7:0] = 8'b10000000;
    	     8 : o_led[7:0] = 8'b01000000;
    	     9 : o_led[7:0] = 8'b00100000;
    	    10 : o_led[7:0] = 8'b00010000;
    	    11 : o_led[7:0] = 8'b00001000;
    	    12 : o_led[7:0] = 8'b00000100;
    	    13 : o_led[7:0] = 8'b00000010;
    	    default : o_led[7:0] = 8'b00000000;
	endcase
	end

endmodule
