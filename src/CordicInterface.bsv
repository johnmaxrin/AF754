package CordicInterface;

import ClientServer :: *;
import FloatingPoint :: *;
import FixedPoint :: *;

interface CordicIFC;
    interface Server  #(Float, Float) cordicServerIFC;
    //method Action dometh(Bit#(16));
endinterface


typedef Server #(Float, FixedPoint#(24,24)) FixedPointConvertIFC;

endpackage
