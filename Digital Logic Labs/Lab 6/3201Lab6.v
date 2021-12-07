module part1(SW, KEY0, LEDG, LEDR);

 

input [1:0]SW;

input KEY0;

output LEDG0;

output [7:0]LEDR;

reg [7:0] y_Q, Y_D;

wire [7:0]w;

 

 

always @(*)

                case(SW[1])

                1: t_ff T0 (SW[1], KEY0, SW[0], w[0]);

                endcase

               

                case(w[0])

                1: t_ff T1 (w[0], KEY0, SW[0], w[1]);

                0: t_ff T0 (w[0], KEY0, SW[0], w[2]);

                endcase

               

                case(w[1])

                1: t_ff T1 (w[1], KEY0, SW[0], w[3]);

                0: t_ff T0 (w[0], KEY0, SW[0], w[0]);

                endcase

 

 

               

  wire [7:0] T, Qs;

 

  t_ff T0 (En, Clk, Clr, Qs[0]);

  assign T[0] = En & Qs[0];

 

  t_ff T1 (T[0], Clk, Clr, Qs[1]);

  assign T[1] = T[0] & Qs[1];

 

  t_ff T2 (T[1], Clk, Clr, Qs[2]);

  assign T[2] = T[1] & Qs[2];

 

  t_ff T3 (T[2], Clk, Clr, Qs[3]);

  assign T[3] = T[2] & Qs[3];

 

  t_ff T4 (T[3], Clk, Clr, Qs[4]);

  assign T[4] = T[3] & Qs[4];

 

  t_ff T5 (T[4], Clk, Clr, Qs[5]);

  assign T[5] = T[4] & Qs[5];

 

  t_ff T6 (T[5], Clk, Clr, Qs[6]);

  assign T[6] = T[5] & Qs[6];

 

  t_ff T7 (T[6], Clk, Clr, Qs[7]);

  assign T[7] = T[6] & Qs[7];

 

  assign LEDR = Qs;

endmodule

 

               

//T flip flop  

module t_ff (En, Clk, Clr, Q);

  input En, Clk, Clr;

  output reg Q;

 

  always @ (posedge Clk)

    if (~Clr)

      Q = 0;

    else if (En)

      Q <= Q + 1;

 

endmodule

 

module part2(SW, KEY0, LEDG0, LEDR);

input KEY0;

input [1:0]SW;

output LEDG0;

output [2:0]LEDR;

 

 

reg[2:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state

parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011,

                E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;

               

always @(*)

                case(y_Q)

               

                                A: if(SW[1]) Y_D = A;

                                                else Y_D = B;

                                               

                                B: if(SW[1]) Y_D = F;

                                                else Y_D = C;

                                               

                                C: if(SW[1]) Y_D = F;

                                                else Y_D = D;

                               

                                D: if(SW[1]) Y_D = F;

                                                else Y_D = E;

                                               

                                E: if(SW[1]) Y_D = F;

                                                else Y_D = E;

                                               

                                F: if(SW[1]) Y_D = G;

                                                else Y_D = B;

                                               

                                G: if(SW[1]) Y_D = A;

                                                else Y_D = H;

                                               

                                H: if(SW[1]) Y_D = F;

                                                else Y_D = C;

                                               

                                default: Y_D = 3'bxxx;

                endcase

 

 

always @(posedge KEY0)

begin: state_FFs

                if(!SW[0]) y_Q <= A;

                else y_Q <= Y_D;

end // state_FFs

 

assign LEDR[0] = (y_Q == B)|(y_Q == D)|(y_Q == F)|(y_Q == H);

assign LEDR[1] = (y_Q == C)|(y_Q == D)|(y_Q == G)|(y_Q == H);

assign LEDR[2] = (y_Q == E)|(y_Q == F)|(y_Q == G)|(y_Q == H);

assign LEDG0 = (y_Q == E)|(y_Q == H);

 

endmodule
