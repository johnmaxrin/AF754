// e^x using CORDIC Alogrithm 





// sine(x) and cos(x) implementation. 
import CordicInterface :: *;

module mkCordicModule(CordicIFC);
	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
	
				

	return toGPServer(req,res);
endmodule
