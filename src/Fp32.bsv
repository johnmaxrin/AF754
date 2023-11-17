package Fp32;

import FloatingPoint :: *;
import FIFO :: *;
import Fp32Interfaces :: *;
import ClientServer :: *;
import GetPut :: *;
export mkExpH;




module mkExpH(ExpHIFC);
	
	FpMULTIFC mult <- mkFloatingPointMultiplier;
	FIFO#(Tuple2#(Float, Bit#(3))) req <- mkFIFO;
	FIFO#(Float) res <- mkFIFO;
	
	FIFO#(Tuple3#(Float, Float, RoundMode)) multReq <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) multRes <- mkFIFO;
	
	FIFO#(Tuple2#(Float, Bit#(3))) temp1 <- mkFIFO;
	FIFO#(Tuple2#(Float, Bit#(3))) r1temp <- mkFIFO;

	Reg#(Bit#(3)) ni <- mkReg(0);  //Jugaad
	Reg#(Bit#(3)) i <- mkReg(0);
	
	Reg#(Float) acc1 <- mkReg(1);
	Reg#(Bool) r2r3 <- mkReg(True);

	rule r1;
		match{.x0, .y0} = req.first; req.deq;
		ni <= y0;
		temp1.enq(tuple2(x0,y0));
	endrule
	
	rule r1inter;
		r1temp.enq(temp1.first); 
		temp1.deq;
	endrule	
		
	rule r2(i < ni && r2r3);
		match{.x1, .y1} = r1temp.first;
		mult.request.put(tuple3(acc1,x1,Rnd_Nearest_Even));		
		i <= i + 1;
		r2r3 <= False;
		$display("@r2 Prev i %d n:%d",i,ni);
	endrule

	rule r3(i < ni && !r2r3 );
		Tuple2#(Float, Exception) temp  <- mult.response.get();
		Float tempRes = tpl_1(temp);
		acc1 <= tempRes;
		r2r3 <= True;
		$display("Prev i %d n:%d",i,ni);
	endrule

	rule r4(i == ni);
		Tuple2#(Float, Exception) temp  <- mult.response.get();
		Float tempRes = tpl_1(temp);
		res.enq(tempRes);
		r1temp.deq;
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
