module 8bit_register(SW, KEY, LEDR);

	input [9:0]SW;
	input KEY[0];
	output [7:0]LEDR
	
	pEdge_ff_wmux m1(SW[8], SW[9], SW[7], ~KEY[0], LEDR[7]);
	pEdge_ff_wmux m2(SW[8], SW[9], SW[6], ~KEY[0], LEDR[6]);
	pEdge_ff_wmux m3(SW[8], SW[9], SW[5], ~KEY[0], LEDR[5]);
	pEdge_ff_wmux m4(SW[8], SW[9], SW[4], ~KEY[0], LEDR[4]);
	pEdge_ff_wmux m5(SW[8], SW[9], SW[3], ~KEY[0], LEDR[3]);
	pEdge_ff_wmux m6(SW[8], SW[9], SW[2], ~KEY[0], LEDR[2]);
	pEdge_ff_wmux m7(SW[8], SW[9], SW[1], ~KEY[0], LEDR[1]);
	pEdge_ff_wmux m8(SW[8], SW[9], SW[0], ~KEY[0], LEDR[0]);
	assign LEDR = Q;
	
endmodule

module pEdge_ff_wmux(input left, right LoadLeft, loadn, D, Clk, output Q);

	wire w1, w2;
	mux2to1 u1(LoadLeft, left, right, w1);
	mux2to1 u2(loadn, D, w1, w2);
	D-ff u3(w2, Clk, Q);


endmodule

module D-ff(input D, Clk, output Q);

	reg z
	always@(posedge Clk)
	z <= D;
	assign Q = z;
endmodule

module mux2to1(input s,x,y, output m);

	assign m = (~s&x)|(s&y);

endmodule 
