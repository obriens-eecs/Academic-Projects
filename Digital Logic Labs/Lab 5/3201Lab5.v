module part1 (SW, KEY, HEX1, HEX0); 

  input [3:0] SW; //Enable&Reset 

  input [1:0] KEY; //Clock pulse 

  output [0:6] HEX1, HEX0; //Output display

 

  wire [7:0] Q; // 8-bitCount output

 

  counter_7 c (SW[1], KEY[0], SW[0], Q);

 

  hex_ssd H0 (Q[3:0], HEX0);

  hex_ssd H1 (Q[7:4], HEX1);

 

endmodule

 

//byTTrigger built8-bitcounter  

module counter_7 (En, Clk, Clr, Q);

  input En, Clk, Clr;

  output [7:0] Q;

 

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

 

  assign Q = Qs;

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

 

module hex_ssd (BIN, SSD);

  input [15:0] BIN;

  output reg [0:6] SSD;

 

  always begin

    case(BIN)

      0:SSD=7'b0000001;

      1:SSD=7'b1001111;

      2:SSD=7'b0010010;

      3:SSD=7'b0000110;

      4:SSD=7'b1001100;

      5:SSD=7'b0100100;

      6:SSD=7'b0100000;

      7:SSD=7'b0001111;

      8:SSD=7'b0000000;

      9:SSD=7'b0001100;

      10:SSD=7'b0001000;

      11:SSD=7'b1100000;

      12:SSD=7'b0110001;

      13:SSD=7'b1000010;

      14:SSD=7'b0110000;

      15:SSD=7'b0111000;

    endcase

  end

endmodule

 

module part3(KEY0,LEDR);

input KEY0;

output [17:0]LEDR;

wire [17:0]w1;

assign w1 = 18'b000000000000000001;

 

reg right;

reg loadn;

reg [5:0] count;

reg [25:0]clockCount;

reg clk_1hz;

reg reset;

initial begin

clockCount <= 0;

clk_1hz <= 0;

loadn <= 0;

right <= 0;

count <= 0;

reset <= 1;

end

 

//slowClock clock_generator(KEY0, reset, clk_1hz);

 

fig1 bit0(right,loadn,w1[0],LEDR[17],LEDR[1],clk_1hz,LEDR[0]);

fig1 bit1(right,loadn,w1[1],LEDR[0],LEDR[2],clk_1hz,LEDR[1]);

fig1 bit2(right,loadn,w1[2],LEDR[1],LEDR[3],clk_1hz,LEDR[2]);

fig1 bit3(right,loadn,w1[3],LEDR[2],LEDR[4],clk_1hz,LEDR[3]);

fig1 bit4(right,loadn,w1[4],LEDR[3],LEDR[5],clk_1hz,LEDR[4]);

fig1 bit5(right,loadn,w1[5],LEDR[4],LEDR[6],clk_1hz,LEDR[5]);

fig1 bit6(right,loadn,w1[6],LEDR[5],LEDR[7],clk_1hz,LEDR[6]);

fig1 bit7(right,loadn,w1[7],LEDR[6],LEDR[8],clk_1hz,LEDR[7]);

fig1 bit8(right,loadn,w1[8],LEDR[7],LEDR[9],clk_1hz,LEDR[8]);

fig1 bit9(right,loadn,w1[9],LEDR[8],LEDR[10],clk_1hz,LEDR[9]);

fig1 bit10(right,loadn,w1[10],LEDR[9],LEDR[11],clk_1hz,LEDR[10]);

fig1 bit11(right,loadn,w1[11],LEDR[10],LEDR[12],clk_1hz,LEDR[11]);

fig1 bit12(right,loadn,w1[12],LEDR[11],LEDR[13],clk_1hz,LEDR[12]);

fig1 bit13(right,loadn,w1[13],LEDR[12],LEDR[14],clk_1hz,LEDR[13]);

fig1 bit14(right,loadn,w1[14],LEDR[13],LEDR[15],clk_1hz,LEDR[14]);

fig1 bit15(right,loadn,w1[15],LEDR[14],LEDR[16],clk_1hz,LEDR[15]);

fig1 bit16(right,loadn,w1[16],LEDR[15],LEDR[17],clk_1hz,LEDR[16]);

fig1 bit17(right,loadn,w1[17],LEDR[16],LEDR[0],clk_1hz,LEDR[17]);

//assign loadn = 1;

 

always @(posedge KEY0)begin

if(clockCount == 25000000)begin

clk_1hz <= ~clk_1hz;

clockCount <= 0;

end

else begin

clockCount <= clockCount + 1;

end

end

 

always @(posedge clk_1hz)begin

count <= count + 1;

if(count == 18)begin

count <= 2;

right <= ~right; 

end

if(count != 0)

loadn <= 1;

end

endmodule

 

module mux_2_to_1(a,b,s,f);

input a,b,s;

output f;

assign f = (~s&a) | (s&b);

endmodule

 

module flipflop(D,Clock,Q);

input D,Clock;

output reg Q;

always @(posedge Clock)

Q<=D;

endmodule

 

 

module fig1(loadleft,loadn,D,right,left,clock,Q);

input loadleft,D,loadn,D,left,right,clock;

output Q;

wire w1,w2;

mux_2_to_1 mux1(right,left,loadleft,w1);

mux_2_to_1 mux2(D,w1,loadn,w2);

flipflop DataIN(w2,clock,Q);

endmodule

 

/*module slowClock(clk, reset, clk_1Hz);

input clk, reset;

output clk_1Hz;

 

reg clk_1Hz = 1'b0;

reg [27:0] counter;

 

always@(posedge reset or posedge clk)

begin

    if (reset == 1'b1)

        begin

            clk_1Hz <= 0;

            counter <= 0;

        end

    else

        begin

            counter <= counter + 1;

            if ( counter == 25_000_000)

                begin

                    counter <= 0;

                    clk_1Hz <= ~clk_1Hz;

                end

        end

end

endmodule   */

 

module L5P2(SW,KEY,LEDR,HEX3,HEX2,HEX1,HEX0);

input[17:0] SW;

input[0:0] KEY;

output[17:0] LEDR;

output[6:0] HEX3,HEX2,HEX1,HEX0;

wire[15:0] product;

reg[7:0] A,B;

always @(posedge KEY[0])

begin

if ( SW[8])

A <= SW[7:0];

else if ( SW[9])

B <= SW[7:0];

end

assign product = A*B;

hexto7segment H3(product[15:12],HEX3);

hexto7segment H2(product[11:8],HEX2);

hexto7segment H1(product[7:4],HEX1);

hexto7segment H0(product[3:0],HEX0);

assign LEDR = product;

 

endmodule 

 

module hexto7segment(x,y);

 

          input[3:0] x;

reg[6:0] z;

output[6:0] y;

always @*

case (x)

4'b0000 :      //Hexadecimal 0

z = 7'b0111111;

4'b0001 :    //Hexadecimal 1

z = 7'b0000110  ;

4'b0010 :  // Hexadecimal 2

z = 7'b1011011; 

4'b0011 : // Hexadecimal 3

z = 7'b1001111 ;

4'b0100 : // Hexadecimal 4

z = 7'b1100110 ;

4'b0101 : // Hexadecimal 5

z = 7'b1101101;  

4'b0110 : // Hexadecimal 6

z = 7'b1111101;

4'b0111 : // Hexadecimal 7

z = 7'b0000111;

4'b1000 :      //Hexadecimal 8

z = 7'b1111111;

4'b1001 :    //Hexadecimal 9

z = 7'b1101111;

4'b1010 :  // Hexadecimal A

z = 7'b1110111; 

4'b1011 : // Hexadecimal B

z = 7'b1111100;

4'b1100 : // Hexadecimal C

z = 7'b0111001;

4'b1101 : // Hexadecimal D

z = 7'b1011110;

4'b1110 : // Hexadecimal E

z = 7'b1111001;

4'b1111 : // Hexadecimal F

z = 7'b1110001;

endcase

 

assign y = ~z;

 

endmodule

 

 

 

--------------------------------------------------------------------------------------

 

 

 

module L5P1(CLOCK_50,HEX0,HEX1,HEX2,HEX3);

input CLOCK_50;

output[6:0] HEX0,HEX1,HEX2,HEX3;

reg newClock;

reg[27:0] counter;

reg[1:0] Q;

always @(posedge CLOCK_50)

begin

 

counter <= counter + 1;

if(counter == 25000000)

begin

newClock <= ~newClock;

counter <= 0;

end

end

always @(posedge newClock) 

begin

Q <= Q + 1;

end

shifter_decoder S1(Q,HEX3,HEX2,HEX1,HEX0);

endmodule

 

module shifter_decoder(a,h3,h2,h1,h0);

 

input[1:0] a;

output[6:0] h3,h2,h1,h0;

reg[1:0] h33,h22,h11,h00;

always @*

case(a)

2'b00:

begin

h33 = 2'b00;

h22 = 2'b01;

h11 = 2'b11;

h00 = 2'b10;

end

2'b01:

begin

h33 = 2'b10;

h22 = 2'b00;

h11 = 2'b01;

h00 = 2'b11;

end

2'b10:

begin

h33 = 2'b11;

h22 = 2'b10;

h11 = 2'b00;

h00 = 2'b01;

end

2'b11:

begin

h33 = 2'b01;

h22 = 2'b11;

h11 = 2'b10;

h00 = 2'b00;

end

endcase

hexto7segment H3(h33,h3);

hexto7segment H2(h22,h2);

hexto7segment H1(h11,h1);

hexto7segment H0(h00,h0);

 

endmodule

 

module hexto7segment(x,y);

 

          input[1:0] x;

reg[6:0] z;

output[6:0] y;

always @*

case (x)

 

2'b00 :     

z = 7'b0001100; //Hexadecimal P

2'b01 :    //Hexadecimal A

z = 7'b0001000;

2'b11 :  // Hexadecimal S

z = 7'b0010010; 

2'b10 :  // Hexadecimal S

z = 7'b0010010; 

endcase

 

assign y = z;

 

endmodule
