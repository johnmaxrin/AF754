package CordicFp2Fpx;
import CordicInterface :: *;
import Vector :: *;
import FIFO :: *;
import FixedPoint :: *;
import FloatingPoint :: *;
import ClientServer :: *;
import GetPut :: *;



export mkFixedPointConvertModule;

// Convert fraction part from FloatingPoint to FixedPoint.
module mkFixedPointConvertModule(FixedPointConvertIFC);
        
    Bit#(16) lookupTablefrac[6];
    lookupTablefrac[0] = 5; 
    lookupTablefrac[1] = 25;
    lookupTablefrac[2] = 125; 
    lookupTablefrac[3] = 625; 
    lookupTablefrac[4] = 3125; 
    lookupTablefrac[5] = 15625; 

    Vector #(6, FIFO #(Tuple3 #(Bit #(16), Bit #(16), Bit#(16)))) fifoacc <- replicateM(mkFIFO);

    FIFO #(Float) req <- mkFIFO;
    FIFO #(CordicFxp) res <- mkFIFO;

    FIFO#(Tuple2#(Bit#(16),Bit#(16))) initValue <- mkFIFO;

    rule r1;
    match{.intr, .fraction} =  initfunc(req.first); req.deq;
    initValue.enq(tuple2(intr,fraction));
    endrule

    // Utilize full potential of parallelization.
    rule start;
        match{.intr, .fraction} = initValue.first; initValue.deq;
        fifoacc[0].enq(tuple3 (intr,fraction,((fraction[15] == 1) ? lookupTablefrac[0] : 0)));
    endrule    

    rule iter1;
        match{.intr, .frac, .acc0} = fifoacc[0].first; fifoacc[0].deq;
        fifoacc[1].enq(tuple3 (intr,frac, acc0 + ((frac[14] == 1) ? lookupTablefrac[1] : 0)));
    endrule
    
    rule iter2;
        match{.intr, .frac, .acc1} = fifoacc[1].first; fifoacc[1].deq;
        fifoacc[2].enq(tuple3 (intr, frac, acc1 + ((frac[13] == 1) ? lookupTablefrac[2] : 0)));
    endrule
    
    rule iter3;
        match{.intr, .frac, .acc2} = fifoacc[2].first; fifoacc[2].deq;
        fifoacc[3].enq(tuple3 (intr, frac, acc2 + ((frac[12] == 1) ? lookupTablefrac[3] : 0)));
    endrule
    
    rule iter4;
        match{.intr, .frac, .acc3} = fifoacc[3].first; fifoacc[3].deq;
        fifoacc[4].enq(tuple3 (intr, frac, acc3 + ((frac[11] == 1) ? lookupTablefrac[4] : 0)));
    endrule
    
    rule iter5;
        match{.intr, .frac, .acc4} = fifoacc[4].first; fifoacc[4].deq;
        fifoacc[5].enq(tuple3 (intr, frac, acc4 + ((frac[10] == 1) ? lookupTablefrac[5] : 0)));
    endrule    

    rule endIter;
        match{.intr, .frac, .acc5} = fifoacc[5].first; fifoacc[5].deq;
        CordicFxp x;
        x.i[15:0] = intr;
        x.f[15:0] = acc5;
        res.enq(x);
    endrule 
    
    return toGPServer(req,res);

endmodule


// Possible issue while pipelining. 
function Tuple2#(Bit#(16), Bit#(16)) initfunc(Float a);
            
            Tuple2#(Half, Exception) x = convert(a,Rnd_Nearest_Even,True);
            let y = tpl_1(x);

            let b = y.exp - 15;
            
            Bit#(16) d = 0; // Integer part
            Bit#(16) fr = 0; // Fractional part for conversion.            
            
            // Deal with the integer part.
            d = d | 1;
            d = d << 10;
            d[9:0] = d[9:0] | y.sfd;
            let decimal = d >> (10 - b); 
            
            // Deal with the fractional part. 
            fr = d << b+1; 
        return tuple2(decimal,fr);
endfunction

endpackage