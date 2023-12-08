package CordicInterface;

import ClientServer :: *;
import FloatingPoint :: *;
import FixedPoint :: *;

typedef FixedPoint#(32,32) CordicFxp;


interface CordicIFC;
    interface Server  #(Float, Float) cordicServerIFC;
    //method Action dometh(Bit#(16));
endinterface


typedef Server #(Float, CordicFxp) FixedPointConvertIFC;
typedef Server #(CordicFxp, CordicFxp) CordicSineCosineRotIFC;



endpackage
