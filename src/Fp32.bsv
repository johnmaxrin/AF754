package Fp32;

import FloatingPoint :: *;

module mkActivation();
	
	Reg#(Float) testvar <- mkReg(0);
	
	rule r1 (testvar == 0);	
		$display("Hello");
		testvar <= 2;
	endrule	

	rule ending (testvar == 2);
		let rexp = testvar.exp;
		Float e = 2.7;
		let vari = rexp * e.exp;
		$display("Ending %b",rexp);
		$finish;
	endrule

endmodule

endpackage
