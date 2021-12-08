module lab1(Clk, HexA, HexB, start, stop, reset);
input Clk; 
input start, stop, reset;
reg [25:0] CountClk;
reg [7:0] CountSec; 
reg Cout;
	
reg [2:0] State;
parameter S0 = 3'b000; 
parameter S1 = 3'b001; 
parameter S2 = 3'b010; 
parameter S3 = 3'b011; 

always@(posedge Clk)
begin
	if(reset)
	begin
		State <= S0; 
		CountSec <= 0; 
	end
	else
	begin
		case(State)
		S0:begin
			CountSec <= CountSec; 
			if(start)
			begin
				State <= S1;
			end
			else 
			begin
				State <= S0; 
			end
		end
		S1:begin
			if(reset) 
			begin
				CountSec <= 0; 
				State <= S0; 
			end
			else if(stop) 
			begin
				State <= S0; 
			end
			else
			begin
				if(CountSec[3:0] > 9) 
				begin
					{Cout,CountSec[3:0]} <= CountSec[3:0] + 6;
					CountSec[7:4] <= CountSec[7:4] + 1; 
				end
				if(CountSec[7:4] > 9)
				begin
					CountSec[7:4] <= CountSec[7:4] + 6;		
				end
				//
				if(CountClk == 26'd50000000) 
				begin
					CountSec <= CountSec + 1; 
					CountClk <= 26'b0; 
					State <= S1; 
				end
				else
				begin
					CountClk <= CountClk + 26'b1; 
					State <= S1;
				end
			end
		//
		end
			default State <= S0;
		endcase
		//
	end
end
//	

output reg [6:0] HexA, HexB;
always@(CountSec[3:0])
begin
case(CountSec[3:0])
	4'b0000: HexA = ~(7'b0111111);//0
	4'b0001: HexA = ~(7'b0000110);//1
	4'b0010: HexA = ~(7'b1011011);//2
	4'b0011: HexA = ~(7'b1001111);//3
	4'b0100: HexA = ~(7'b1100110);//4
	4'b0101: HexA = ~(7'b1101101);//5
	4'b0110: HexA = ~(7'b1111101);//6
	4'b0111: HexA = ~(7'b0000111);//7
	4'b1000: HexA = ~(7'b1111111);//8
	4'b1001: HexA = ~(7'b1101111);//9
endcase
case(CountSec[7:4])
	4'b0000: HexB = ~(7'b0111111);//0
	4'b0001: HexB = ~(7'b0000110);//1
	4'b0010: HexB = ~(7'b1011011);//2
	4'b0011: HexB = ~(7'b1001111);//3
	4'b0100: HexB = ~(7'b1100110);//4
	4'b0101: HexB = ~(7'b1101101);//5
	4'b0110: HexB = ~(7'b1111101);//6
	4'b0111: HexB = ~(7'b0000111);//7
	4'b1000: HexB = ~(7'b1111111);//8
	4'b1001: HexB = ~(7'b1101111);//9
endcase
end

endmodule
