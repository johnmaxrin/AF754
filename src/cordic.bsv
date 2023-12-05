// e^x using CORDIC Alogrithm 





// sine(x) and cos(x) implementation. 
import CordicInterface :: *;
import FIFO :: *;
import ClientServer :: *;
import GetPut :: *;

(*synthesize*)
module mkCordicModule(CordicIFC);
	FIFO#(Bit#(16)) res <- mkFIFO;
	FIFO#(Bit#(16)) req <- mkFIFO;
    
    Reg#(Bit #(16))  result <- mkReg(0);
    Reg#(Bit#(1)) flag <- mkReg(0);
    
    function Action dometh(Bit#(16) a);
        action
            result <= a >> 1;
            flag <= 1;
        endaction
    endfunction
    
 
	rule r1; 
        dometh(req.first);
    endrule			

    rule r2(flag == 1);
        $display("%b",result);
        $finish();
    endrule
    
    
   

	interface cordicServerIFC = toGPServer(req,res);
endmodule



module mkMain(Empty);
    CordicIFC cordic <- mkCordicModule;

    rule r1;
        cordic.cordicServerIFC.request.put(4);
    endrule

endmodule