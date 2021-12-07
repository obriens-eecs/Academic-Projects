module ALU(SW, KEY, LEDR);

	input [15:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	reg r;
	
	if(KEY[2] == 0)
		begin
		
		if(KEY[1] == 0)
			begin
			
				if(KEY[0] == 0)
					begin
					LEDR[7:0] = ~SW[15:8] | SW[7:0];
			
				else
					LEDR[7:0] = ~SW[15:8] | ~SW[7:0];
					end
			
			end
		
		if(KEY[1] == 1)
			begin
			
				if(KEY[0] == 0)
					begin
					LEDR[7:0] = ~SW[15:8];
			
			
				else
					LEDR[7:0] = SW[15:8] & SW[7:0];
					end
		
			end
		
		end
		
	end
	
	if(KEY[2] == 1)
		
		if(KEY[1] == 0)
			begin
			
			if(KEY[0] == 0)
				begin
				LEDR[7:0] = ~SW[15:8] + SW[7:0];
			
			else
			
				LEDR[7:0] = ~(SW[15:8] | SW[7:0]);
				end
			
			end
		
		if(KEY[1] == 1)
			begin
			
			if(KEY[0] == 0)
				begin
				
				for(i = 15; i >= 8; i = i - 1);
					begin
						if(SW[i] == 1);
							r = r +1;
					end
			
				end
			
			else
				begin
				
				for(i = 15; i >= 0; i = i - 1);
					begin
						if(SW[i] == 1);
							r = r +1;
					end
			
				end
		
			end
		
		end
		
	end
	
endmodule
