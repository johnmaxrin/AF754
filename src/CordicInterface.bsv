package CordicInterface;

import ClientServer :: *;
import FloatingPoint :: *;
import FixedPoint :: *;

typedef FixedPoint#(16,16) CordicFxp;
typedef Tuple4#(CordicFxp, CordicFxp, Bit#(20), Bit#(20)) CordicHyperbolic;
typedef Tuple4#(CordicFxp, CordicFxp, Bit#(32), Bit#(32)) Testtp4;

typedef enum
{

	Sigmoid,
	Tanh,
	LeakyRelu,
	Selu

} ActivationFunctions deriving (Bits, Eq);

// *** Main Interface  Start *** //
typedef Server#(Tuple2#(Float, ActivationFunctions), CordicFxp) MainIFC; 
// *** Main Interface  End *** // 

interface CordicIFC;
    	interface Server  #(Float, Tuple2#(CordicFxp, CordicFxp)) cordicServerIFC;
endinterface

typedef Server #(Float, CordicFxp) FixedPointConvertIFC;


// ****** Activation Functions Start ******** //

typedef Server#(Float, CordicFxp) TanhIFC;
typedef Server#(Float, CordicFxp) SigmoidIFC;
typedef Server#(Float, CordicFxp) LeakyReluIFC;
typedef Server#(Float, CordicFxp) SeluIFC;

// ****** Activation Functions End ******** // 

// ****** Exponential () Start ******* // 
typedef Server#(Tuple2#(Float,Bit#(1)), CordicFxp) ExponentialIFC;
// ****** Exponential () End ******* // 


// ****** Hyperbolic Start ****** // 

interface CordicSineHCosineHIFC;
        interface Server#(Bit#(20), Tuple2#(CordicFxp,CordicFxp)) server;
endinterface

interface ArcTanHIFC;
	method Bit#(20) arcTanH(Bit#(5) i);
endinterface

interface CordicSineHCosineHRotIFC;
        interface Server#(Tuple2#(CordicHyperbolic,Bit#(5)), CordicHyperbolic) rotServer;
endinterface

// ****** Hyperbolic End ****** //

 
// **** Sine Cosine ***** // 
interface CordicSineCosineIFC;
	interface Server#(Bit#(32), CordicFxp) server;
endinterface

interface ArcTanIFC;
	method Bit#(32) arcTan(Bit#(5) i); 
endinterface

interface CordicSineCosineRotIFC;
	interface Server#(Tuple2#(Testtp4,Bit#(5)), Testtp4) rotServer;
endinterface
// ****** End Sine Cosine ******* // 


endpackage
