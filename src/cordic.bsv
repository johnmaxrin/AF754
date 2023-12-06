// e^x using CORDIC Alogrithm 





// sine(x) and cos(x) implementation. 
import CordicInterface :: *;
import FIFO :: *;
import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import FixedPoint :: *;

(*synthesize*)
module mkCordicModule(CordicIFC);
	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
    
    Reg#(Bit#(24))  result <- mkReg(0);
    Reg#(Bit#(1)) flag <- mkReg(0);
    
    function Action dometh(Float a);
        action
            $display("Actual: %b",a);
            $display("EXP: %d",a.exp);
            $display("MANTISSA: %b",a.sfd);
            let b = a.exp - 127;
            

            Bit#(24) d = 0; // Integer part
            Bit#(24) fr = 0; // Fractional part for conversion.

            Bit#(14) lookupTablefrac[6];
            lookupTablefrac[0] = 5; 
            lookupTablefrac[1] = 25; 
            lookupTablefrac[2] = 125; 
            lookupTablefrac[3] = 625; 
            lookupTablefrac[4] = 3125; 
            lookupTablefrac[5] = 15625; 
            
            // Deal with the integer part.
            d = d | 1;
            d = d << 23;
            d[22:0] = d[22:0] | a.sfd;
            let decimal = d >> (23 - b); 
            $display("Decimal Value: %d", decimal);
            
            // Deal with the fractional part. 
            fr = d << b+1;
            $display("Fraction: %b",fr);
            Bit#(14) frres = 0;


            for(int i = 23; i>17; i = i-1)
                ass = frres + (fr[i] == 1 ? (lookupTablefrac[i]) : 0);
            
            $display("Fractional Value: %b",frres);

            result <=  d;
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

module mkCordicModule(FractionValueIFC);
endmodule



module mkMain(Empty);
    CordicIFC cordic <- mkCordicModule;

    rule r1;
        cordic.cordicServerIFC.request.put(45.256);
    endrule

endmodule




module mkFractionValueModule();

endmodule