module Adder_4bit(SW, LEDG);

	input [8:0] SW;
	output [4:0] LEDG;
	wire C0, C1, C2;
	
	FA b0(SW[7], SW[3], SW[8], LEDG[4], C0);
	FA b1(SW[6], SW[2], C0, LEDG[3], C1);
	FA b2(SW[5], SW[1], C1, LEDG[2], C2);
	FA b3(SW[4], SW[0], C2, LEDG[1], LEDG[0]);

endmodule

module FA(a, b, Cin, s, Cout);

	input a, b, Cin;
	output s, Cout;
	
	assign s = a ^ b ^ Cin;
	assign Cout = (a ^ b)&Cin | a&b;
	
endmodule
