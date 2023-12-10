package CordicHyperbolic;

import ClientServer :: *;
import GetPut :: *;
import FIFO :: *;
import Vector :: *;
import FixedPoint :: *;
import CordicInterface :: *;

module mkCordicSineHCosineH(CordicSineHCosineHIFC);

    CordicSineHCosineHRotIFC cordicSineHCosineHRot <- mkCordicSineHCosineHRot;
    
    FIFO#(Bit#(20)) req <- mkFIFO;
    FIFO#(Tuple2#(CordicFxp, CordicFxp)) res <- mkFIFO;
    Reg#(Bit#(5)) index <- mkReg(0);

    FIFO#(CordicHyperbolic) initFIFO <- mkFIFO;
    Vector #(16, FIFO#(CordicHyperbolic)) cordicPipe <- replicateM(mkFIFO);

 

    // ******* Iteration Begin  ********* //
    rule iter0 if(index == 0);
        initFIFO.enq(tuple4(1,0,0,req.first)); req.deq;
        index <= 1;
    endrule

    rule iter1 if(index == 1);
        cordicSineHCosineHRot.rotServer.request.put(tuple2(initFIFO.first,0));
        index <= 2;
    endrule

    rule iter2 if(index == 2);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,1));
        index <= 3;
   endrule


    rule iter3 if(index == 3);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,2));        
        index <= 4;
    endrule

    rule iter4 if(index == 4);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,3));        
        index <= 5;
    endrule

    rule iter5 if(index == 5);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,4));        
        index <= 6;
    endrule


    rule iter6 if(index == 6);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,5));        
        index <= 7;
    endrule


    rule iter7 if(index == 7);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,6));        
        index <= 8;
    endrule


    rule iter8 if(index == 8);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,7));        
        index <= 9;
    endrule


    rule iter9 if(index == 9);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,8));        
        index <= 10;
    endrule


    rule iter10 if(index == 10);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,9));        
        index <= 11;
    endrule


    rule iter11 if(index == 11);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,10));        
        index <= 12;
    endrule


    rule iter12 if(index == 12);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,11));        
        index <= 13;
    endrule


    rule iter13 if(index == 13);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,12));        
        index <= 14;
    endrule


    rule iter14 if(index == 14);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,13));        
        index <= 15;
    endrule


    rule iter15 if(index == 15);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,14));        
        index <= 16;
    endrule

    rule iter16 if(index == 16);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        cordicSineHCosineHRot.rotServer.request.put(tuple2(x,15));        
        index <= 17;
    endrule



    rule momentofTruth if(index == 17);
        CordicHyperbolic x <- cordicSineHCosineHRot.rotServer.response.get();
        match{.a, .b, .c, .d} = x;
        a = a*0.67253;
        b = b*0.67253;
	res.enq(tuple2(a,b));
        index <= 0;
    endrule
// **************** ITER END ***************** //
interface server = toGPServer(req,res);
endmodule



// Returns arcTanh(1/2^n)
module mkArcTanH(ArcTanHIFC);
    method Bit#(20) arcTanH(Bit#(5) i);
        Bit#(20) arcTanHVal;
        case(i)
            0: arcTanHVal = 131072;
            1: arcTanHVal = 77376;
            2: arcTanHVal = 40883;
            3: arcTanHVal = 20753;
            4: arcTanHVal = 10417;
            5: arcTanHVal = 5213;
            6: arcTanHVal = 2607;
            7: arcTanHVal = 1304;
            8: arcTanHVal = 652;
            9: arcTanHVal = 326;
            10: arcTanHVal = 163;
            11: arcTanHVal = 81;
            12: arcTanHVal = 41;
            13: arcTanHVal = 20;
            14: arcTanHVal = 10;
            15: arcTanHVal = 5;
            16: arcTanHVal = 3;
            17: arcTanHVal = 1;
            default: arcTanHVal = 0;
        endcase
    return arcTanHVal;
    endmethod
endmodule

module mkCordicSineHCosineHRot(CordicSineHCosineHRotIFC);

    FIFO#(CordicFxp) nx <- mkFIFO;
    FIFO#(CordicFxp) ny <- mkFIFO;
    FIFO#(Bit#(20)) ncAngle <- mkFIFO;
    FIFO#(Bit#(20)) nrcAngle <- mkFIFO;
 
    FIFO#(CordicFxp) x <- mkFIFO;
    FIFO#(CordicFxp) y <- mkFIFO;
    FIFO#(Bit#(20)) cAngle <- mkFIFO;
    FIFO#(Bit#(5)) i <- mkFIFO;
    FIFO#(Bit#(20)) rcAngle <- mkFIFO;
    
    FIFO#(Tuple2#(CordicHyperbolic,Bit#(5))) req <- mkFIFO;
    FIFO#(CordicHyperbolic) res <- mkFIFO;


    ArcTanHIFC arcTanHLookup <- mkArcTanH;

    rule r1;
        match{.a, .b} = req.first;

        x.enq(tpl_1(a));
        y.enq(tpl_2(a));
        cAngle.enq(tpl_3(a));
        rcAngle.enq(tpl_4(a));
        i.enq(b);


        req.deq;
    endrule

    rule r2(cAngle.first < rcAngle.first);
        nx.enq(x.first - (y.first >> i.first));
        ny.enq((x.first >> i.first) + y.first);
        ncAngle.enq(cAngle.first + arcTanHLookup.arcTanH(i.first));
        nrcAngle.enq(rcAngle.first);
        
        x.deq;
        y.deq;
        cAngle.deq;
        i.deq;
        rcAngle.deq;
    
    endrule 

    rule r3(cAngle.first >= rcAngle.first);
        nx.enq(x.first + (y.first >> i.first));
        ny.enq(y.first - (x.first >> i.first));
        ncAngle.enq(cAngle.first - arcTanHLookup.arcTanH(i.first));
        nrcAngle.enq(rcAngle.first);

        x.deq;
        y.deq;
        cAngle.deq;
        i.deq;
        rcAngle.deq;

    endrule

    rule dispatch;

        res.enq(tuple4(nx.first, ny.first, ncAngle.first,nrcAngle.first));
        
        nx.deq;
        ny.deq;
        ncAngle.deq;
        nrcAngle.deq;
    endrule

    interface rotServer = toGPServer(req,res);
endmodule

endpackage
