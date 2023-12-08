// e^x using CORDIC Alogrithm 





// sine(x) and cos(x) implementation. 
import CordicInterface :: *;
import FIFO :: *;
import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import FixedPoint :: *;
import CordicFp2Fpx :: *;

(*synthesize*)
module mkCordicModule(CordicIFC);

    // Interfaces
    FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;

	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
    
    Reg#(FixedPoint#(24,24))  result <- mkReg(0);
    
	rule r1; 
        fixedPointConvert.request.put(req.first);
        req.deq;
    endrule			

    rule r2;
        let a <- fixedPointConvert.response.get();
        $display(fshow(a));
        $finish;
    endrule

	interface cordicServerIFC = toGPServer(req,res);
endmodule




module mkMain(Empty);
    CordicIFC cordic <- mkCordicModule;

    rule r1;
        cordic.cordicServerIFC.request.put(45.5);
    endrule

endmodule





