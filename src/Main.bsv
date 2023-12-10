package Main;

import CordicInterface :: *; 
import FIFO :: *;
import FloatingPoint :: *;
import Activation :: *;
import ClientServer :: *;
import GetPut :: *;
(*synthesize*)
module mkMain(MainIFC);

    TanhIFC tanh <- mkTanH;
    SigmoidIFC sigmoid <- mkSigmoid;
    LeakyReluIFC leakyRelu <- mkLeakyRelu;
    SeluIFC selu <- mkSelu;
    
	FIFO#(Tuple2#(Float, ActivationFunctions)) req <- mkFIFO;
	FIFO#(ActivationFunctions) whichacti <- mkFIFO;
	FIFO#(CordicFxp) res <- mkFIFO; 	
		

	rule r1;
		let a = req.first;
		whichacti.enq(tpl_2(a));
        case (tpl_2(a))
			Sigmoid: sigmoid.request.put(tpl_1(a));	
			Tanh: tanh.request.put(tpl_1(a));
			LeakyRelu: leakyRelu.request.put(tpl_1(a));
			Selu: selu.request.put(tpl_1(a));
    	endcase	
		req.deq;
	endrule

    rule r2(whichacti.first == Sigmoid);
   		let a <- sigmoid.response.get; 
		res.enq(a); 
		whichacti.deq;
	 endrule
	
	rule r3(whichacti.first == Tanh);
		let a <- tanh.response.get; 
		res.enq(a); 
		whichacti.deq;
    endrule

	rule r4(whichacti.first == LeakyRelu);
		let a <- leakyRelu.response.get; 
		res.enq(a); 
		whichacti.deq;
    endrule

	rule r5(whichacti.first == Selu);
		let a <- selu.response.get; 
		res.enq(a); 
		whichacti.deq;
    endrule

	return toGPServer(req,res);
endmodule
	

endpackage
