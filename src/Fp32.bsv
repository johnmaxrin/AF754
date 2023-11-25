package Fp32;

import FloatingPoint :: *;
import FIFO :: *;
import Fp32Interfaces :: *;
import ClientServer :: *;
import GetPut :: *;

export mkExpH;
export mkEexpF;

module mkEexpF(EexpFIFC);
	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
	
	FIFO#(Float) temp <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm0 <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm1 <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm2 <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm3 <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm4 <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm5 <- mkFIFO;
	
	
	FIFO#(Float) fterm <- mkFIFO;
	FIFO#(Float) fterm0 <- mkFIFO;
	FIFO#(Float) fterm1 <- mkFIFO;
	FIFO#(Float) fterm2 <- mkFIFO;
	FIFO#(Float) fterm3 <- mkFIFO;
	FIFO#(Float) fterm4 <- mkFIFO;
	FIFO#(Float) fterm5 <- mkFIFO;
	

	FIFO#(Float) prfinal <- mkFIFO;
        

	ExpHIFC exph1 <- mkExpH;
	ExpHIFC exph2 <- mkExpH;
	ExpHIFC exph3 <- mkExpH;
	ExpHIFC exph4 <- mkExpH;
	ExpHIFC exph5 <- mkExpH;
	ExpHIFC exph6 <- mkExpH;
	
	rule r1;
		temp.enq(req.first); 
		fterm.enq(req.first);
		req.deq;
	endrule
	
	rule terms;
		exph1.request.put(tuple2(temp.first,2));		
		exph2.request.put(tuple2(temp.first,3));		
		exph3.request.put(tuple2(temp.first,4));		
		exph4.request.put(tuple2(temp.first,5));		
		exph5.request.put(tuple2(temp.first,6));		
		exph6.request.put(tuple2(temp.first,7));		
		temp.deq;
	endrule
	
	
// Simple Error Here!

	rule r3;
	      	let val1 <- exph1.response.get();
	      	fterm0.enq(val1);
	      	
		let val2 <- exph2.response.get();
	      	fterm1.enq(val2);
	      	
		let val3 <- exph3.response.get();
	      	fterm2.enq(val3);
	      	
		let val4 <- exph4.response.get();
	      	fterm3.enq(val4);
	      	
		let val5 <- exph5.response.get();
	      	fterm4.enq(val5);
	  
	  	let val6 <- exph6.response.get();
	      	fterm5.enq(val6);
	        
	       
	endrule	

	rule r4;
		Float fRes = fterm.first; fterm.deq;
		Float  fRes0 = fterm0.first/2; fterm0.deq;
		Float  fRes1 = fterm1.first/6; fterm1.deq;
		Float  fRes2 = fterm2.first/24; fterm2.deq;
		Float  fRes3 = fterm3.first/120; fterm3.deq;
		Float  fRes4 = fterm4.first/720; fterm4.deq;
		Float  fRes5 = fterm5.first/5040; fterm5.deq;	

		// We have to add floating point addition too. For that make 
		// use of the mkAddition module	already there and comeback here. 
		// It is giving that error again. 
		let finalz = 1 + fRes + fRes0 + fRes1 + fRes2 + fRes3 + fRes4 + fRes5;
		prfinal.enq(finalz); 
	endrule

	rule r5;
		Float fRes = prfinal.first; prfinal.deq;
		res.enq(fRes);
	endrule


	return toGPServer(req,res); 
endmodule

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
