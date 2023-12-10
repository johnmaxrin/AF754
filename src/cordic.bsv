// e^x using CORDIC Alogrithm 


import CordicInterface :: *;
import FIFO :: *;
import FIFOF :: *;
import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import Vector :: *;
import FixedPoint :: *;
import CordicFp2Fpx :: *;
import CordicHyperbolic :: *;

module mkCordicModule(CordicIFC);

    // Interfaces
    FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;
    CordicSineHCosineHIFC cordicSineHCosineH <- mkCordicSineHCosineH;

	FIFO#(Float) req <- mkFIFO;
	FIFO#(Tuple2#(CordicFxp, CordicFxp)) res <- mkFIFO;
    
	rule r1; 
        fixedPointConvert.request.put(req.first);
        req.deq;
    endrule			

    rule r2;
        CordicFxp a <- fixedPointConvert.response.get();
        Bit#(20) ab = 0;
        ab[15:0] =  a.i;
        ab = ab << 11; 
        cordicSineHCosineH.server.request.put(ab);
    endrule

    rule r3;
	let a <- cordicSineHCosineH.server.response.get();
	res.enq(a);
    endrule 

	interface cordicServerIFC = toGPServer(req,res);
endmodule


