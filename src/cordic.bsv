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
import Real :: *;

(*synthesize*)
module mkCordicModule(CordicIFC);

    // Interfaces
    FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;
    CordicSineCosineRotIFC cordicSineCosineRot <- mkCordicSineCosineRot;

	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
    
	rule r1; 
        fixedPointConvert.request.put(req.first);
        req.deq;
    endrule			

    rule r2;
        let a <- fixedPointConvert.response.get();
        cordicSineCosineRot.request.put(a);
    endrule

	interface cordicServerIFC = toGPServer(req,res);
endmodule




module mkMain(Empty);
    CordicIFC cordic <- mkCordicModule;

    rule r1;
        cordic.cordicServerIFC.request.put(30);
    endrule

endmodule


// CORDIC SINE-COSINE ROTATION 
module mkCordicSineCosineRot(CordicSineCosineRotIFC);

    FIFOF #(CordicFxp) req <- mkFIFOF;
    FIFO #(CordicFxp) res <- mkFIFO;

    CordicFxp arcTanLookup[16];
    arcTanLookup[0] = 45.0;
    arcTanLookup[1] = 26.565;
    arcTanLookup[2] = 14.036;
    arcTanLookup[3] = 7.125;
    arcTanLookup[4] = 3.576;
    arcTanLookup[5] = 1.790;
    arcTanLookup[6] = 0.8951;
    arcTanLookup[7] = 0.4476;
    arcTanLookup[8] = 0.2238;
    arcTanLookup[9] = 0.1119;
    arcTanLookup[10] = 0.0559;
    arcTanLookup[11] = 0.0279;
    arcTanLookup[12] = 0.0139;
    arcTanLookup[13] = 0.0069;
    arcTanLookup[14] = 0.003;
    arcTanLookup[15] = 0.001; 

    FIFOF#(CordicFxp) fifo1 <- mkFIFOF;
    FIFOF#(CordicFxp) fifo2 <- mkFIFOF;
    FIFOF#(Bit#(32)) fifo3 <- mkFIFOF;
    FIFOF#(CordicFxp) fifo4 <- mkFIFOF;
    FIFOF#(CordicFxp) fifo5 <- mkFIFOF;


    Reg#(CordicFxp) data <- mkReg(0);

    // For fetching angle
    rule r1;
        fifo1.enq((req.first)); req.deq;
    endrule

    // For >> 16
    rule r2;
        fifo2.enq((fifo1.first) << 16); fifo1.deq;
    endrule

    // For /360
    rule r3;
        fifo3.enq((fifo2.first.i)/360); fifo2.deq;
    endrule

    rule r4;
        $display("%d",fifo3.first);
        $finish;
    endrule


    return toGPServer(req,res);
endmodule


/*function CordicFxp convert2Radians(CordicFxp a);

endfunction*/




