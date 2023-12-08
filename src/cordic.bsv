// e^x using CORDIC Alogrithm 


// sine(x) and cos(x) implementation. 
import CordicInterface :: *;
import FIFO :: *;
import FIFOF :: *;
import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import Vector :: *;
import FixedPoint :: *;
import CordicFp2Fpx :: *;
import Real :: *;

(*synthesize*)
module mkCordicModule(CordicIFC);

    // Interfaces
    FixedPointConvertIFC fixedPointConvert <- mkFixedPointConvertModule;
    CordicSineCosineRotIFC cordicSineCosineRot <- mkCordicSineCosineRot;

	FIFO#(Float) res <- mkFIFO;
	FIFO#(Float) req <- mkFIFO;
    
	rule r1; 
        fixedPointConvert.request.put(req.first);
        req.deq;
    endrule			

    rule r2;
        let a <- fixedPointConvert.response.get();
        cordicSineCosineRot.request.put(a);
    endrule

	interface cordicServerIFC = toGPServer(req,res);
endmodule




module mkMain(Empty);
    CordicIFC cordic <- mkCordicModule;

    rule r1;
        cordic.cordicServerIFC.request.put(30);
    endrule

endmodule


// CORDIC SINE-COSINE ROTATION 
module mkCordicSineCosineRot(CordicSineCosineRotIFC);

    FIFOF #(CordicFxp) req <- mkFIFOF;
    FIFO #(CordicFxp) res <- mkFIFO;

     

    Reg#(CordicFxp) x <- mkReg(0);
    Reg#(CordicFxp) y <- mkReg(0);
    Reg#(CordicFxp) z <- mkReg(0);

    // Do the scaling. 
    FIFOF#(CordicFxp) fifo1 <- mkFIFOF;
    FIFOF#(CordicFxp) fifo2 <- mkFIFOF;
    FIFOF#(Bit#(32)) fifo3 <- mkFIFOF;
    FIFOF#(CordicFxp) fifo4 <- mkFIFOF;

    Vector#(16,FIFO#(Tuple4#(CordicFxp, CordicFxp, CordicFxp, CordicFxp))) cordicPipe <- replicateM(mkFIFO);

    // For fetching angle
    rule r1;
        fifo1.enq((req.first)); req.deq;
    endrule

    // For >> 16
    rule r2;
        fifo2.enq((fifo1.first) << 16); fifo1.deq;
    endrule

    // For /360
    rule r3;
        fifo3.enq((fifo2.first.i)/360); fifo2.deq;
    endrule
    rule r4;
        CordicFxp x = 0;
        x.i = fifo3.first; fifo3.deq;
        fifo4.enq(x);
    endrule
    // ********* Done with the scaling **********


    // ********* Iteration Begin ****************  
    rule iterInit;
        cordicPipe[0].enq(tuple4(1,0,0,fifo4.first));
        fifo4.deq;
    endrule

    rule iter0;
            match{.x, .y, .curra, .reala} = cordicPipe[0].first; 
            cordicPipe[0].deq;
            if(curra < reala)
                cordicPipe[1].enq(ifCondition(tuple4(x,y,curra,reala), 0));
            else
                cordicPipe[1].enq(elseCondition(tuple4(x,y,curra,reala), 0));
    endrule
    
    rule iter1;
            match{.x, .y, .curra, .reala} = cordicPipe[1].first; 
            cordicPipe[1].deq;
            if(curra < reala)
                cordicPipe[2].enq(ifCondition(tuple4(x,y,curra,reala), 1));
            else
                cordicPipe[2].enq(elseCondition(tuple4(x,y,curra,reala), 1));
    endrule
    rule iter2;
            match{.x, .y, .curra, .reala} = cordicPipe[2].first; 
            cordicPipe[2].deq;
            if(curra < reala)
                cordicPipe[3].enq(ifCondition(tuple4(x,y,curra,reala), 2));
            else
                cordicPipe[3].enq(elseCondition(tuple4(x,y,curra,reala), 2));
    endrule
    rule iter3;
            match{.x, .y, .curra, .reala} = cordicPipe[3].first; 
            cordicPipe[3].deq;
            if(curra < reala)
                cordicPipe[4].enq(ifCondition(tuple4(x,y,curra,reala), 3));
            else
                cordicPipe[4].enq(elseCondition(tuple4(x,y,curra,reala), 3));
    endrule
    rule iter4;
            match{.x, .y, .curra, .reala} = cordicPipe[4].first; 
            cordicPipe[4].deq;
            if(curra < reala)
                cordicPipe[5].enq(ifCondition(tuple4(x,y,curra,reala), 4));
            else
                cordicPipe[5].enq(elseCondition(tuple4(x,y,curra,reala), 4));
    endrule

    rule iter5;
            match{.x, .y, .curra, .reala} = cordicPipe[5].first; 
            cordicPipe[5].deq;
            if(curra < reala)
                cordicPipe[6].enq(ifCondition(tuple4(x,y,curra,reala), 5));
            else
                cordicPipe[6].enq(elseCondition(tuple4(x,y,curra,reala), 5));
    endrule
    rule iter6;
            match{.x, .y, .curra, .reala} = cordicPipe[6].first; 
            cordicPipe[6].deq;
            if(curra < reala)
                cordicPipe[7].enq(ifCondition(tuple4(x,y,curra,reala), 6));
            else
                cordicPipe[7].enq(elseCondition(tuple4(x,y,curra,reala), 6));
    endrule
    rule iter7;
            match{.x, .y, .curra, .reala} = cordicPipe[7].first; 
            cordicPipe[7].deq;
            if(curra < reala)
                cordicPipe[8].enq(ifCondition(tuple4(x,y,curra,reala), 7));
            else
                cordicPipe[8].enq(elseCondition(tuple4(x,y,curra,reala), 7));
    endrule
    rule iter8;
            match{.x, .y, .curra, .reala} = cordicPipe[8].first; 
            cordicPipe[8].deq;
            if(curra < reala)
                cordicPipe[9].enq(ifCondition(tuple4(x,y,curra,reala), 8));
            else
                cordicPipe[9].enq(elseCondition(tuple4(x,y,curra,reala), 8));
    endrule
    rule iter9;
            match{.x, .y, .curra, .reala} = cordicPipe[9].first; 
            cordicPipe[9].deq;
            if(curra < reala)
                cordicPipe[10].enq(ifCondition(tuple4(x,y,curra,reala), 9));
            else
                cordicPipe[10].enq(elseCondition(tuple4(x,y,curra,reala), 9));
    endrule    
    rule iter10;
            match{.x, .y, .curra, .reala} = cordicPipe[10].first; 
            cordicPipe[10].deq;
            if(curra < reala)
                cordicPipe[11].enq(ifCondition(tuple4(x,y,curra,reala), 10));
            else
                cordicPipe[11].enq(elseCondition(tuple4(x,y,curra,reala), 10));
    endrule
    rule iter11;
            match{.x, .y, .curra, .reala} = cordicPipe[11].first; 
            cordicPipe[11].deq;
            if(curra < reala)
                cordicPipe[12].enq(ifCondition(tuple4(x,y,curra,reala), 11));
            else
                cordicPipe[12].enq(elseCondition(tuple4(x,y,curra,reala), 11));
    endrule
    rule iter12;
            match{.x, .y, .curra, .reala} = cordicPipe[12].first; 
            cordicPipe[12].deq;
            if(curra < reala)
                cordicPipe[13].enq(ifCondition(tuple4(x,y,curra,reala), 12));
            else
                cordicPipe[13].enq(elseCondition(tuple4(x,y,curra,reala), 12));
    endrule
    rule iter13;
            match{.x, .y, .curra, .reala} = cordicPipe[13].first; 
            cordicPipe[13].deq;
            if(curra < reala)
                cordicPipe[14].enq(ifCondition(tuple4(x,y,curra,reala), 13));
            else
                cordicPipe[14].enq(elseCondition(tuple4(x,y,curra,reala), 13));
    endrule
    rule iter14;
            match{.x, .y, .curra, .reala} = cordicPipe[14].first; 
            cordicPipe[14].deq;
            if(curra < reala)
                cordicPipe[15].enq(ifCondition(tuple4(x,y,curra,reala), 14));
            else
                cordicPipe[15].enq(elseCondition(tuple4(x,y,curra,reala), 14));
    endrule
    
    // ********* Iteration End ******************

    rule momentofTruth;
        match{.x, .y, .z, .u} = cordicPipe[15].first;
        cordicPipe[15].deq;

        $display(fshow(x));
        $finish;
    endrule



    return toGPServer(req,res);
endmodule


// If exceeds area requirement work on this. 
function Tuple4#(CordicFxp, CordicFxp, CordicFxp, CordicFxp) ifCondition(Tuple4#(CordicFxp, CordicFxp, CordicFxp, CordicFxp) data, Int#(32) i);
    
   
    CordicFxp arcTanLookup[16];
    arcTanLookup[0] = 8192;
    arcTanLookup[1] = 4836;
    arcTanLookup[2] = 2555;
    arcTanLookup[3] = 1297;
    arcTanLookup[4] = 650;
    arcTanLookup[5] = 325;
    arcTanLookup[6] = 162;
    arcTanLookup[7] = 81;
    arcTanLookup[8] = 41;
    arcTanLookup[9] = 20;
    arcTanLookup[10] = 10;
    arcTanLookup[11] = 5;
    arcTanLookup[12] = 3;
    arcTanLookup[13] = 1;
    arcTanLookup[14] = 0;
    arcTanLookup[15] = 0;

    
    
    
    match{.x, .y, .curra, .reala} = data;
    let ncurra = curra + arcTanLookup[i];
    let nx = x - (y >> i);
    let ny = (x >> i) + y;


    return tuple4(nx,ny,ncurra,reala);
endfunction

function Tuple4#(CordicFxp, CordicFxp, CordicFxp, CordicFxp) elseCondition(Tuple4#(CordicFxp, CordicFxp, CordicFxp, CordicFxp) data, Int#(32) i);
    CordicFxp arcTanLookup[16];
    arcTanLookup[0] = 8192;
    arcTanLookup[1] = 4836;
    arcTanLookup[2] = 2555;
    arcTanLookup[3] = 1297;
    arcTanLookup[4] = 650;
    arcTanLookup[5] = 325;
    arcTanLookup[6] = 162;
    arcTanLookup[7] = 81;
    arcTanLookup[8] = 41;
    arcTanLookup[9] = 20;
    arcTanLookup[10] = 10;
    arcTanLookup[11] = 5;
    arcTanLookup[12] = 3;
    arcTanLookup[13] = 1;
    arcTanLookup[14] = 0;
    arcTanLookup[15] = 0;
    
    match{.x, .y, .curra, .reala} = data;
    let ncurra = curra + arcTanLookup[i];
    let nx = x + (y >> i);
    let ny = y - (x >> i);
    return tuple4(nx,ny,ncurra,reala);
endfunction

