package CordicSineCosine;

import ClientServer :: *;
import GetPut :: *;
import FIFO :: *;
import Vector :: *;
import FixedPoint :: *;
import CordicInterface :: *;

typedef FixedPoint#(16,16) CordicFxp;


module mkCordicSineCosine(CordicSineCosineIFC);

    CordicSineCosineRotIFC cordicSineCosineRot <- mkCordicSineCosineRot;
    
    FIFO#(Bit#(32)) req <- mkFIFO;
    FIFO#(CordicFxp) res <- mkFIFO;
    Reg#(Bit#(5)) index <- mkReg(0);

    FIFO#(Testtp4) initFIFO <- mkFIFO;
    Vector #(16, FIFO#(Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)))) cordicPipe <- replicateM(mkFIFO);

 

    // ******* Iteration Begin  ********* //
    rule iter0 if(index == 0);
        initFIFO.enq(tuple4(1,0,0,req.first)); req.deq;
        index <= 1;
    endrule

    rule iter1 if(index == 1);
        cordicSineCosineRot.rotServer.request.put(tuple2(initFIFO.first,0));
        index <= 2;
    endrule

    rule iter2 if(index == 2);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,1));
        index <= 3;
   endrule


    rule iter3 if(index == 3);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,2));        
        index <= 4;
    endrule

    rule iter4 if(index == 4);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,3));        
        index <= 5;
    endrule

    rule iter5 if(index == 5);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,4));        
        index <= 6;
    endrule


    rule iter6 if(index == 6);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,5));        
        index <= 7;
    endrule


    rule iter7 if(index == 7);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,6));        
        index <= 8;
    endrule


    rule iter8 if(index == 8);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,7));        
        index <= 9;
    endrule


    rule iter9 if(index == 9);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,8));        
        index <= 10;
    endrule


    rule iter10 if(index == 10);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,9));        
        index <= 11;
    endrule


    rule iter11 if(index == 11);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,10));        
        index <= 12;
    endrule


    rule iter12 if(index == 12);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,11));        
        index <= 13;
    endrule


    rule iter13 if(index == 13);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,12));        
        index <= 14;
    endrule


    rule iter14 if(index == 14);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,13));        
        index <= 15;
    endrule


    rule iter15 if(index == 15);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,14));        
        index <= 16;
    endrule

    rule iter16 if(index == 16);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        cordicSineCosineRot.rotServer.request.put(tuple2(x,15));        
        index <= 17;
    endrule





    rule momentofTruth if(index == 17);
        Testtp4 x <- cordicSineCosineRot.rotServer.response.get();
        match{.a, .b, .c, .d} = x;
        a = a*0.67253;
        b = b*0.67253;

        $display("[x]:%d.%d",b.i, b.f);
        $display("[y]:%d.%d",a.i, a.f);

        index <= 0;
        $finish;
    endrule
// **************** ITER END ***************** //
interface server = toGPServer(req,res);
endmodule


module mkArcTan(ArcTanIFC);
    method Bit#(32) arcTan(Bit#(5) i);
        Bit#(32) arcTanVal;
        case(i)
            0: arcTanVal = 131072;
            1: arcTanVal = 77376;
            2: arcTanVal = 40883;
            3: arcTanVal = 20753;
            4: arcTanVal = 10417;
            5: arcTanVal = 5213;
            6: arcTanVal = 2607;
            7: arcTanVal = 1304;
            8: arcTanVal = 652;
            9: arcTanVal = 326;
            10: arcTanVal = 163;
            11: arcTanVal = 81;
            12: arcTanVal = 41;
            13: arcTanVal = 20;
            14: arcTanVal = 10;
            15: arcTanVal = 5;
            16: arcTanVal = 3;
            17: arcTanVal = 1;
            default: arcTanVal = 0;
        endcase    
    return arcTanVal;
    endmethod
endmodule


module mkCordicSineCosineRot(CordicSineCosineRotIFC);

    FIFO#(CordicFxp) nx <- mkFIFO;
    FIFO#(CordicFxp) ny <- mkFIFO;
    FIFO#(Bit#(32)) ncAngle <- mkFIFO;
    FIFO#(Bit#(32)) nrcAngle <- mkFIFO;
 
    FIFO#(CordicFxp) x <- mkFIFO;
    FIFO#(CordicFxp) y <- mkFIFO;
    FIFO#(Bit#(32)) cAngle <- mkFIFO;
    FIFO#(Bit#(5)) i <- mkFIFO;
    FIFO#(Bit#(32)) rcAngle <- mkFIFO;
    
    FIFO#(Tuple2#(Testtp4,Bit#(5))) req <- mkFIFO;
    FIFO#(Testtp4) res <- mkFIFO;


    ArcTanIFC arcTanLookup <- mkArcTan;

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
        ncAngle.enq(cAngle.first + arcTanLookup.arcTan(i.first));
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
        ncAngle.enq(cAngle.first - arcTanLookup.arcTan(i.first));
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