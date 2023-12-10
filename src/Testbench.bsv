import Main :: *;
import Vector :: *;
import CordicInterface :: *;
import FloatingPoint :: *;
import ClientServer :: *;
import GetPut :: *;
import FixedPoint :: *;

module mkTestBench();

MainIFC main <- mkMain;

Vector#(4, Tuple2#(Float, ActivationFunctions)) testInputs;

testInputs[0] = tuple2(0.243, Sigmoid);
testInputs[1] = tuple2(90.6, Tanh);
testInputs[2] = tuple2(0.6, LeakyRelu);
testInputs[3] = tuple2(0.5, Selu);

Reg#(Bit#(5)) i <- mkReg(0);

rule r1(i < 5);
	main.request.put(testInputs[i]);
endrule

rule r2;
	let a <- main.response.get;
	$display("%d.%d",a.i, a.f);
	i <= i + 1;
endrule


rule r3(i >= 5);
	$finish;
endrule
endmodule
