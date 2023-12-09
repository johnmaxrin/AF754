// e^x using CORDIC Alogrithm 


// sine(x) and cos(x) implementation. 
import CordicInterface :: *;
import FIFO :: *;
import FIFOF :: *;
import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import Vector :: *;
import FixedPoint :: *;
import CordicFp2Fpx :: *;
import CordicSineCosine :: *;

(*synthesize*)
module mkCordicModule(CordicIFC);

    // Interfaces
    FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;
    CordicSineCosineIFC cordicSineCosine <- mkCordicSineCosine;

	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
    
	rule r1; 
        fixedPointConvert.request.put(req.first);
        req.deq;
    endrule			

    rule r2;
        CordicFxp a <- fixedPointConvert.response.get();
        Bit#(32) ab = 0;
        ab[15:0] =  a.i;
        ab = ab << 11; 
        cordicSineCosine.server.request.put(ab);
    endrule

	interface cordicServerIFC = toGPServer(req,res);
endmodule




module mkMain(Empty);
    CordicIFC cordic <- mkCordicModule;

    rule r1;
        cordic.cordicServerIFC.request.put(30);
    endrule

endmodule

