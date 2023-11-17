package Fp32;

import FloatingPoint :: *;
import FIFO :: *;
import Fp32Interfaces :: *;
import ClientServer :: *;
export mkExpH;



module mkExpH(ExpHIFC);
	FIFO#(Tuple2#(Float, Bit#(3))) req <- mkFIFO;
	FIFO#(Float) res <- mkFIFO;
	
	FIFO#(Tuple2#(Float, Bit#(3))) temp1 <- mkFIFO;
	FIFO#(Tuple2#(Float, Bit#(3))) temp2 <- mkFIFO;
	
	rule r1;
		match{.x0, .y0} = req.first; req.deq;
		temp1.enq(tuple2(x0,y0));
	endrule

	rule r2;
		match{.x1, .y1} = temp1.first; temp1.deq;
		temp1.enq(tuple2((x1 << y1),y1));	
	endrule

	rule r3;
		match{.fREs,.fresy} = temp1.first; temp1.deq;
		res.enq(fREs);
	endrule

	return toGPServer(req,res);	
endmodule

function Float selu(Float x);
	Float l = 1.0507009;
	Float a = 1.6732632;
	return l * ((x >0) ? x : a * (exph(x) - 1));
endfunction

function Float leakyrelu(Float x);
	let term1 = 0.01 * x;
	return (term1 > x) ? term1 : x;
endfunction

function Float tanh(Float x);
	let term1 = exph(x);
	let term2 = expn(x);
	return (term1 - term2) / (term1 + term2);
endfunction

function Float sigmoid(Float x);
	let term1 = 1 + expn(x);
	return 1/term1;
endfunction

function Float exph(Float x);
	let term0 = square(x,2)/2;
	let term1 = square(x,3)/6;
	let term2 = square(x,4)/24;
	let term3 = square(x,5)/120;
	return (1 + x + term0 + term1 + term2 + term3);
endfunction

function Float expn(Float x);
	let term0 = square(x,2)/2;
	let term1 = square(x,3)/6;
	let term2 = square(x,4)/24;
	let term3 = square(x,5)/120;
	return (1 - x + term0 - term1 + term2 - term3);
endfunction

function Float square(Float x , Integer y);
	Float res = 1;
	for(int i = 0; i<5; i = i + 1) begin
		res = res * x;
	end	
	return res;
endfunction

endpackage
