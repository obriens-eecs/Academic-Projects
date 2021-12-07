module Lab2Part1(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6);
	input [17:0] SW;
	input [2:0] KEY;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	output [6:0] HEX6;
	
	wire [2:0] W0, W1, W2, W3, W4, W5, W6;
	
	mux_3bit_7to1 m0(SW[5:3], SW[17:15], SW[17:15], SW[2:0], SW[14:12], SW[11:9], SW[8:6], KEY, W0);
	char_7seg s0(W0, HEX0);
	
	mux_3bit_7to1 m1(SW[8:6], SW[5:3], SW[17:15], SW[17:15], SW[2:0], SW[14:12], SW[11:9], KEY, W1);
	char_7seg s1(W1, HEX1);
	
	mux_3bit_7to1 m2(SW[11:9], SW[8:6], SW[5:3], SW[17:15], SW[17:15], SW[2:0], SW[14:12], KEY, W2);
	char_7seg s2(W2, HEX2);
	
	mux_3bit_7to1 m3(SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[17:15], SW[17:15], SW[2:0], KEY, W3);
	char_7seg s3(W3, HEX3);
	
	mux_3bit_7to1 m4(SW[2:0], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[17:15], SW[17:15], KEY, W4);
	char_7seg s4(W4, HEX4);
	
	mux_3bit_7to1 m5(SW[17:15], SW[2:0], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[17:15], KEY, W5);
	char_7seg s5(W5, HEX5);
	
	mux_3bit_7to1 m6(SW[17:15], SW[17:15], SW[2:0], SW[14:12], SW[11:9], SW[8:6], SW[5:3], KEY, W6);
	char_7seg s6(W6, HEX6);

endmodule


// a 3-bit wide 2-to-1 MUX
module mux_3bit_2to1(X,Y,s,M);
   input [2:0] X,Y;
   input       s;
   
   output [2:0] M;

   assign M = ({3{~s}} & X) | ({3{s}} & Y);

endmodule // mux_3bit_2to1

// a 3-bit wide 7-to-1 MUX
module mux_3bit_7to1(T,U,V,W,X,Y,Z,S,M);
   input [2:0] T,U,V,W,X,Y,Z,S;
   output [2:0]     M;

   wire [2:0] 	    N1,N2,N3,N4,N5;
      
   mux_3bit_2to1 m0(T,U,S[0],N1);
   mux_3bit_2to1 m1(V,W,S[0],N2);
   mux_3bit_2to1 m2(X,Y,S[0],N3);
   mux_3bit_2to1 m3(N1,N2,S[1],N4);
   mux_3bit_2to1 m4(N3,Z,S[1],N5);
   mux_3bit_2to1 m5(N4,N5,S[2],M);

endmodule // mux_3bit_7to1

module char_7seg(C, Display);

	input [2:0] C;
	output [6:0] Display;
	assign Display[0] = (~C[2] | (C[2] & ~C[1] & ~C[0]));
	assign Display[1] = (~C[2] & C[1]) | (C[2] & ~C[1]);
	assign Display[2] = (C[2] & ~C[1] ) | (~C[2] & C[1] & ~C[0]);
	assign Display[3] = (~C[2] | (C[2] & ~C[1] & ~C[0]));
	assign Display[4] = (C[2] & ~C[1] & ~C[0]) | (~C[2] & ~C[1]) | (~C[2] & C[1] & C[0]);
	assign Display[5] = (C[2] & ~C[1] & ~C[0]) | (~C[2] & ~C[1]);
	assign Display[6] = (~C[2]);
	
endmodule
