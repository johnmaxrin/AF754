package Activation;

import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import FIFO :: *;
import CordicExponential :: *;
import CordicInterface :: *;
import FixedPoint :: *;
import CordicFp2Fpx :: *;

module mkTanH(TanhIFC);
	ExponentialIFC exponential1 <- mkCordicExponential;
	ExponentialIFC exponential2 <- mkCordicExponential;
	FIFO#(Float) req <- mkFIFO;
	FIFO#(CordicFxp) res <- mkFIFO;
 
	rule r1;
    	exponential1.request.put(tuple2(req.first,1));
    	exponential2.request.put(tuple2(req.first,0));
		req.deq;
	endrule

	rule r2;
		let a <- exponential1.response.get;
		let b <- exponential2.response.get;
		res.enq((a-b)/(a+b));
	endrule

	return toGPServer(req,res);
endmodule


module mkSigmoid(SigmoidIFC);

	ExponentialIFC exponential <- mkCordicExponential;
	FIFO#(Float) req <- mkFIFO;
	FIFO#(CordicFxp) res <- mkFIFO;

	rule r1;
    	exponential.request.put(tuple2(req.first,0));
		req.deq;
	endrule

	rule r2;
		let a <- exponential.response.get;
		res.enq(1/1+(a));
	endrule 
	
	return toGPServer(req,res);
endmodule

module mkLeakyRelu(LeakyReluIFC);
	FIFO#(Float) req <- mkFIFO;
	FIFO#(CordicFxp) res <- mkFIFO;
	FIFO#(CordicFxp) a <- mkFIFO;

    FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;
	
	rule r1;
		fixedPointConvert.request.put(req.first);
		req.deq;
	endrule
	
	rule inter;
		let y <- fixedPointConvert.response.get;
		a.enq(y);
	endrule	

	rule r2;
		if((a.first * 0.01)>a.first)
			res.enq(a.first * 0.01);
		else
			res.enq(a.first);
		a.deq;
	endrule
	return toGPServer(req,res);
endmodule

module mkSelu(SeluIFC);
	FIFO#(Float) req <- mkFIFO;
    FIFO#(CordicFxp) res <- mkFIFO;
    FIFO#(CordicFxp) inter <- mkFIFO;
	CordicFxp lambda = 1.0507009;
	CordicFxp alpha = 1.6732632;

	ExponentialIFC exponential <- mkCordicExponential;
	FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;
	
	rule init;	
		fixedPointConvert.request.put(req.first);
		exponential.request.put(tuple2(req.first,0));
		req.deq;
	endrule 
		
	rule r1;
		let a <- fixedPointConvert.response.get;
		inter.enq(a);
	endrule
	
	rule r3 if(inter.first > 0);
		res.enq(lambda * alpha); 
		inter.deq;	
	endrule
	
	rule r4(inter.first <= 0);
		let b <- exponential.response.get;
		res.enq(lambda*alpha * (b-1));
		inter.deq;	
	endrule	

	return toGPServer(req,res);
endmodule



endpackage
