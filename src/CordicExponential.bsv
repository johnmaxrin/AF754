package CordicExponential;

import CordicInterface :: *;
import ClientServer :: *;
import FIFO :: *;
import cordic :: *;
import GetPut :: *;
import FloatingPoint :: *;
import FixedPoint :: *;


module mkCordicExponential(ExponentialIFC);
    
CordicIFC cordic <- mkCordicModule;

FIFO#(Tuple2#(Float, Bit#(1))) req <- mkFIFO;
FIFO#(CordicFxp) res <- mkFIFO;
FIFO#(Bit#(1)) sign <- mkFIFO;

rule r1;
	let a = req.first;
    cordic.cordicServerIFC.request.put(tpl_1(a));
	sign.enq(tpl_2(a));
	req.deq;
endrule 

rule r2;
	let a <- cordic.cordicServerIFC.response.get();
	if(sign.first == 0)
		res.enq(tpl_1(a) - tpl_2(a));
	else
		res.enq(tpl_1(a) + tpl_2(a));
endrule
return toGPServer(req,res);
endmodule

endpackage
