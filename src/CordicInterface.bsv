package CordicInterface;

import ClientServer :: *;
import FloatingPoint :: *;

interface CordicIFC;
    interface Server  #(Float, Float) cordicServerIFC;
    //method Action dometh(Bit#(16));
endinterface


typedef Server #(Bit#(24), Bit#(24)) FractionValueIFC;

endpackage
