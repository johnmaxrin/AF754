package Fp32Interfaces;

import FloatingPoint :: *;
import ClientServer :: *;



typedef Server  #( Tuple2#(Float, Bit#(3)),Float) ExpHIFC; // For x^n .
typedef Server  #( Tuple3#(Float, Float, RoundMode), Tuple2#(Float,Exception)) FpMULTIFC;


endpackage
