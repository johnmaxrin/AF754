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
	FIFO#(Tuple2#(Float, Exception)) tterm6 <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) tterm7 <- mkFIFO;
	
	
	FIFO#(Float) fterm <- mkFIFO;
	FIFO#(Float) fterm0 <- mkFIFO;
	FIFO#(Float) fterm1 <- mkFIFO;
	FIFO#(Float) fterm2 <- mkFIFO;
	FIFO#(Float) fterm3 <- mkFIFO;
	FIFO#(Float) fterm4 <- mkFIFO;
	FIFO#(Float) fterm5 <- mkFIFO;
	FIFO#(Float) fterm6 <- mkFIFO;
	FIFO#(Float) fterm7 <- mkFIFO;
	
	FIFO#(Float) fStage10 <- mkFIFO;
	FIFO#(Float) fStage11 <- mkFIFO;
	FIFO#(Float) fStage12 <- mkFIFO;
	FIFO#(Float) fStage13 <- mkFIFO;
	FIFO#(Float) fStage14 <- mkFIFO;
	
	FIFO#(Float) fStage20 <- mkFIFO;
	FIFO#(Float) fStage21 <- mkFIFO;
	FIFO#(Float) fStage22 <- mkFIFO;


	FIFO#(Float) fStage30 <- mkFIFO;
	FIFO#(Float) fStage31 <- mkFIFO;

	FIFO#(Float) prfinal <- mkFIFO;
        

	ExpHIFC exph1 <- mkExpH;
	ExpHIFC exph2 <- mkExpH;
	ExpHIFC exph3 <- mkExpH;
	ExpHIFC exph4 <- mkExpH;
	ExpHIFC exph5 <- mkExpH;
	ExpHIFC exph6 <- mkExpH;
	ExpHIFC exph7 <- mkExpH;
	ExpHIFC exph8 <- mkExpH;
	
	FIFO#(Float) fRes <- mkFIFO;
	FIFO#(Float) fRes0 <- mkFIFO;
	FIFO#(Float) fRes1 <- mkFIFO;
	FIFO#(Float) fRes2 <- mkFIFO;
	FIFO#(Float) fRes3 <- mkFIFO;
	FIFO#(Float) fRes4 <- mkFIFO;
	FIFO#(Float) fRes5 <- mkFIFO;
	FIFO#(Float) fRes6 <- mkFIFO;
	FIFO#(Float) fRes7 <- mkFIFO;
	
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
		exph7.request.put(tuple2(temp.first,8));		
		exph8.request.put(tuple2(temp.first,9));		
		temp.deq;
	endrule
	

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
	
	  	let val7 <- exph7.response.get();
      	fterm6.enq(val7);

	  	let val8 <- exph8.response.get();
      	fterm7.enq(val8);
	

	       
	endrule	

	rule r4;
		fRes.enq(fterm.first); fterm.deq;
		fRes0.enq((fterm0.first/2)); fterm0.deq;
		fRes1.enq((fterm1.first/6)); fterm1.deq;
		fRes2.enq((fterm2.first/24)); fterm2.deq;
		fRes3.enq((fterm3.first/120)); fterm3.deq;
		fRes4.enq((fterm4.first/720)); fterm4.deq;
		fRes5.enq((fterm5.first/5040)); fterm5.deq;	
		fRes6.enq((fterm6.first/40320)); fterm6.deq;	
		fRes7.enq((fterm7.first/362880)); fterm7.deq;	
	endrule

	rule addStage0;

		fStage10.enq(fRes.first + fRes0.first);
		fStage11.enq(fRes1.first + fRes2.first);
		fStage12.enq(fRes3.first + fRes4.first);
		fStage13.enq(fRes5.first + fRes6.first);
		fStage14.enq(fRes7.first + 1);

		fRes.deq;
		fRes0.deq;
		fRes1.deq;
		fRes2.deq;
		fRes3.deq;
		fRes4.deq;
		fRes5.deq;
		fRes6.deq;
		fRes7.deq;
	endrule

	rule addStage1;
		fStage20.enq(fStage10.first + fStage11.first);
		fStage21.enq(fStage12.first + fStage13.first);
		fStage22.enq(fStage14.first + 0);

		fStage10.deq;
		fStage11.deq;
		fStage12.deq;
		fStage13.deq;
		fStage14.deq;
	endrule

	rule addStage2;
		fStage30.enq(fStage20.first + fStage21.first);
		fStage31.enq(fStage22.first + 0);

		fStage20.deq;
		fStage21.deq;
		fStage22.deq;
	endrule


	rule addStage3;
		prfinal.enq(fStage30.first + fStage31.first);
		fStage30.deq;
		fStage31.deq;
	endrule

	rule r6;
		Float fRes = prfinal.first; prfinal.deq;
		res.enq(fRes);
	endrule


	return toGPServer(req,res); 
endmodule

module mkExpH(ExpHIFC);
	
	FpMULTIFC mult <- mkFloatingPointMultiplier;
	FIFO#(Tuple2#(Float, Bit#(4))) req <- mkFIFO;
	FIFO#(Float) res <- mkFIFO;
	
	FIFO#(Tuple3#(Float, Float, RoundMode)) multReq <- mkFIFO;
	FIFO#(Tuple2#(Float, Exception)) multRes <- mkFIFO;
	
	FIFO#(Tuple2#(Float, Bit#(4))) temp1 <- mkFIFO;
	FIFO#(Tuple2#(Float, Bit#(4))) r1temp <- mkFIFO;

	Reg#(Bit#(4)) ni <- mkReg(0);  //Jugaad
	Reg#(Bit#(4)) i <- mkReg(0);
	
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
	endrule

	rule r3(i < ni && !r2r3 );
		Tuple2#(Float, Exception) temp  <- mult.response.get();
		Float tempRes = tpl_1(temp);
		acc1 <= tempRes;
		r2r3 <= True;
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
