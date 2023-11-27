package Activation;

import ClientServer :: *;
import GetPut :: *;
import FloatingPoint :: *;
import FIFO :: *;

import Fp32 :: *;
import Fp32Interfaces :: *;


module mkActivation();

	//ExpHIFC expH <- mkExpH;

	EexpFIFC eexpf <- mkEexpF;
	rule r1_A;
		eexpf.request.put(6);
	endrule	

	rule r2_A;
		let x = eexpf.response.get();
		$display("%b ",x);
		$finish;
	endrule
	
	
endmodule


endpackage
