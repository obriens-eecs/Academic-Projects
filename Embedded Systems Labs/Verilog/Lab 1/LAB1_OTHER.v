module Lab1StopWatchV3(Clk, HexA, HexB, Start, Stop, Rst);
input Clk; //50MHz Clock is used.
input Start, Stop, Rst; // Switches used to determine the process State the program will run.
reg [25:0] CountClk; // Needed to count the 50M from the input Clock to get 1 second.
reg [7:0] CountSec; // This will be the trasitional value to the seven segment display.
reg Cout; // CarryOut value from BCD transformation.


//****************************************************************************//
//									Title: The Stop Watch										//
//									Author: Mark Wilson 214136683								//
//									Co-Author: Dalan Shakaj 214206049						//																	
//									Date: January 7th, 2019 									//
//****************************************************************************//

	
// These are used to intialize the State parameters to run cases.
reg [2:0] State;
parameter S0 = 3'b000; 
parameter S1 = 3'b001; 
parameter S2 = 3'b010; 
parameter S3 = 3'b011; 

// Will run/scan 50M times per second.
// Can't add other posedge terms or the program is overloaded.
// StopWatch will be accurate up to 50 millionth of a second.
always@(posedge Clk)
begin
	if(Rst) // Reset is written first to give priority.
	begin
		State <= S0; // Return to default state.
		CountSec <= 0; // Result value to zero.
	end
	else
	begin
		case(State)
		S0:begin
			CountSec <= CountSec; // Maintains the current output.
			if(Start) // If start is activatied, go to state 1.
			begin
				State <= S1;
			end
			else // Continue scanning for a valid command that will change state or output values.
			begin
				State <= S0; 
			end
		end
		S1:begin
			if(Rst) // written first to give priority.
			begin
				CountSec <= 0; // reset output value
				State <= S0; // return to default case.
			end
			else if(Stop) // will stop the program from counting.
			begin
				State <= S0; // returns to default case without reseting the output value.
			end
			else
			begin
				if(CountSec[3:0] > 9) // BCD converter for first grouping(4) of binary digits.
				begin
					{Cout,CountSec[3:0]} <= CountSec[3:0] + 6;
					CountSec[7:4] <= CountSec[7:4] + Cout; // Add the carry out to the next grouping, before the BCD conversion.
				end
				if(CountSec[7:4] > 9) // BCD converter for second grouping (4) of binary digits.
				begin
					CountSec[7:4] <= CountSec[7:4] + 6;		
				end
				//
				if(CountClk == 26'd50000000) // Count the Clock cycles to add up to 1 second.
				begin
					CountSec <= CountSec + 1; // add one second.
					CountClk <= 26'b0; // reset the clock counter.
					State <= S1; // maintain state.
				end
				else
				begin
					CountClk <= CountClk + 26'b1; // add to the clock counter.
					State <= S1; // maintain state.
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

// Display the CountSec on the Seven Segment Displays.
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
//
end

endmodule
