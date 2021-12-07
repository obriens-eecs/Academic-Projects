module Part2(KEY, SW, HEX);

 

                input [11:0]SW;

                input [1:0]KEY;

                output [3:0]HEX;

                wire [7:0]w0;

                wire [7:0]w1;

 

                flipflop m1(w0, KEY[0], SW[11], w1);

                ALU m2(SW[7:0], w1, SW[10:8], w0);

                char_7seg m3(SW[7:4], HEX3);

                char_7seg m4(SW[3:0], HEX2);

                char_7seg m5(w1[7:4], HEX1);

                char_7seg m6(w1[3:0], HEX0);

 

endmodule

 

module flipflop (D, Clock, Resetn, Q);

 

                input [7:0]D;

                input Clock, Resetn;

                output [7:0]Q;

                reg Q;

               

                always @(negedge Resetn or posedge Clock)

                                if (!Resetn)

                                Q <= 0;

                                else

                                Q <= D;

               

endmodule

 

module ALU(A, B, OPCODE, D);

 

                input[7:0] A;

                input[7:0] B;

                input[2:0] OPCODE;

                reg [7:0]f;

                output[7:0]  D;

               

               

                                always @ (*)

                begin

                case(~OPCODE)

               

                3'b000:  f = ~A[7:0] | B[7:0]; // case 000

               

                3'b001:  f = ~A[7:0] | ~B[7:0]; // case 001

                 

                3'b010:  f = ~A[7:0]; // case 010

               

                3'b011:  f =  A[7:0] & B[7:0]; // case 011

               

                3'b100:  f = A[7:0] + B[7:0]; // case 100

               

                3'b101:  f = ~A[7:0] & ~B[7:0]; // 101

               

                3'b110:  f = A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] + A[7]; // case 110

               

                3'b111: f = A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] + A[7] + B[0] + B[1] + B[2] + B[3] + B[4] + B[5] + B[6] + B[7]; // case 111

               

                endcase

 

                end

               

                assign D = f;

endmodule

 

module char_7seg (A, HEX0);

 

    input  [3:0] A ;

    output [6:0] HEX0;

   

               

    assign HEX0[0] = ( A[3] | (~A[3] & ~A[2] & ~A[1] & ~A[0]) | (~A[3] & ~A[2] & A[1])| (~A[3] & A[2] & ~A[1] & A[0])| (~A[3] & A[2] & A[1]));

    assign HEX0[1] = ((~A[3] & ~A[2]) | (~A[3] & A[2] & ~A[1] & ~A[0]) | (~A[3] & A[2] & A[1] & A[0]) | (A[3] & ~A[2]) | (A[3] & A[2] ~A[1] & A[0]));

    assign HEX0[2] = ((~A[3] & ~A[2] & ~A[1]) | (~A[3] & ~A[2] & A[1] & A[0]) | (~A[3] & A[2]) | (A[3] & ~A[2]) | (A[3] & A[2] ~A[1] & A[0]));

    assign HEX0[3] = ((~A[3] & ~A[2] & ~A[1] & ~A[0]) | (~A[3] & ~A[2] & A[1])| (~A[3] & A[2] & ~A[1] & A[0])| (~A[3] & A[2] & A[1] & ~A[0]) | (A[3] & ~A[2] & ~A[1] & ~A[0]) |(A[3] & ~A[2] & A[1] & A[0])| (A[3] & A[2] & ~A[1]) | (A[3] & A[2] & A[1] & ~A[0]));

    assign HEX0[4] = ((~A[3] & ~A[2] & ~A[1] & ~A[0])| (~A[3] & ~A[2] & A[1] & A[0])| (~A[3] & A[2] & A[1] & ~A[0]) | (A[3] & ~A[2] & ~A[1] & ~A[0])| (A[3] & ~ A[2] & A[1])| (A[3] & A[2]));

    assign HEX0[5] = ((~A[3] & ~A[2] & ~A[1] & ~A[0])| (~A[3] & A[2] & ~A[1])| (~A[3] & A[2] & A[1] & ~A[0]) | A[3]);

    assign HEX0[6] = ((~A[3] & ~A[2] & A[1])| (~A[3] & A[2] & ~A[1])| (~A[3] & A[2] & A[1] & ~A[0])|(A[3] & ~A[2]) | (A[3] & A[2] & A[1]));

   

 

endmodule
