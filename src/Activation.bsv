package Activation;

import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import FIFO :: *;

import Fp32 :: *;
import Fp32Interfaces :: *;


module mkActivation();

	ExpHIFC expH <- mkExpH;
	
	rule r1_A;
		expH.request.put(tuple2(3,4));
	endrule	

	rule r2_A;
		let x = expH.response.get();
		$display("%b ",x);
		$finish;
	endrule
	
	
endmodule


endpackage
