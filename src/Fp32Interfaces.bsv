package Fp32Interfaces;

import FloatingPoint :: *;
import ClientServer :: *;



typedef Server  #( Tuple2#(Float, Bit#(4)),Float) ExpHIFC; // For x^n .
typedef Server  #(Float,Float) EexpFIFC; // For e^x .
typedef Server  #( Tuple3#(Float, Float, RoundMode), Tuple2#(Float,Exception)) FpMULTIFC;
typedef Server  #( Tuple3#(Float, Float, RoundMode), Tuple2#(Float,Exception)) FpADDIFC;


endpackage
