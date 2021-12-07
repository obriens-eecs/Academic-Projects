module Lab2(Clk, reset, GPIO_0, ground);
input Clk;
input reset; //on when not pressed
reg r1;
reg[25:0] ClkCount;
output GPIO_0;
output ground;

assign GPIO_0 = r1;

if (~reset)

always@(posedge Clk)
	begin
		
			if (0 < ClkCount &&  ClkCount < 26'd300000) 
				r1 = 1'b1;
			else if(26'd400000 < ClkCount &&  ClkCount < 26'd800000)
				r1 = 1'b1;
			else 
				r1 = 1'b0;
			if (ClkCount == 26'd1500000) 
				ClkCount = 26'b0;
			else
				ClkCount = ClkCount + 26'b1;
			end
		
	end
end
endmodule
