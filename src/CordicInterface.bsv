package CordicInterface;

import ClientServer :: *;
import FloatingPoint :: *;
import FixedPoint :: *;

typedef FixedPoint#(16,16) CordicFxp;
typedef Tuple4#(CordicFxp, CordicFxp, Bit#(32), Bit#(32)) Testtp4;

interface CordicIFC;
    interface Server  #(Float, Float) cordicServerIFC;
endinterface

typedef Server #(Float, CordicFxp) FixedPointConvertIFC;

interface CordicSineCosineIFC;
interface Server#(Bit#(32), CordicFxp) server;
endinterface

interface ArcTanIFC;
method Bit#(32) arcTan(Bit#(5) i); 
endinterface

interface CordicSineCosineRotIFC;
interface Server#(Tuple2#(Testtp4,Bit#(5)), Testtp4) rotServer;
endinterface

endpackage
