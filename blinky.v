module top(input clk_25mhz,
           input [6:0] btn,
           output [7:0] led,
           output wifi_gpio0);

    wire i_clk;

    // Tie GPIO0, keep board from rebooting
    assign wifi_gpio0 = 1'b1;
    assign i_clk = clk_25mhz;
    reg [7:0] o_led;
    assign led= o_led;
    reg slow_clk;

    localparam ctr_width = 32;
    reg [ctr_width-1:0] ctr = 0;
    reg [ctr_width-1:0] ctr2 = 0;

    always @(posedge i_clk) begin
        ctr <= ctr + 1;
        slow_clk <= ctr[21];
    end
    
    always @(posedge slow_clk) begin
    
    	if (ctr2 == 13)
    	begin
    	   ctr2 <= 0;
    	end
    	else
    	begin
    	   ctr2 <= ctr2 + 1;
    	end
    	
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
