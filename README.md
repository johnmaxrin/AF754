# Bluespec Activation Functions

This repository implements various activation functions in Bluespec, focusing on IEEE 754 Single Precision.

## Implemented Activation Functions

- Sigmoid
- Tanh
- LeakyRelu
- Selu

## Implementation Details

1. **Floating Point to Fixed Point:**
   - The project includes a robust mechanism for converting floating-point numbers to fixed-point representation. This conversion is crucial for working with fixed-point arithmetic in the context of hardware description languages like Bluespec.
   - This conversion is a critical step, ensuring compatibility between the IEEE 754 Single Precision format and the fixed-point representation necessary for efficient hardware implementation of CORDIC Algorithm.
  
2. **Exponential Module:**
The exponential function (e^x) is a common component for three of the activation functions. The Exponential module is designed to compute e^x or e^-x using the CORDIC algorithm. The mathematical relationships used are e^x = sinh(x) + cosh(x) and e^-x = sinh(x) - cosh(x).

3. **CORDIC Rotation for sinh and cosh:**
To calculate sinh and cosh values, the CORDIC algorithm is employed for rotation. The CORDIC rotation allows for efficient computation of hyperbolic functions using iterative and hardware-friendly processes. The rotation angles are carefully chosen to minimize computational complexity and enhance precision.

4. **Implementation in codric.bsv:**
The implementation details for the CORDIC algorithm and activation functions are encapsulated in the "cordic.bsv" file. This file contains the necessary modules and logic for accurate computation of trigonometric and exponential functions, which are fundamental to the activation functions.
 

5. **Cordic Algorithm:**
   - Utilizes Cordic algorithm for efficient trigonometric and hyperbolic function calculations.
   - The Cordic algorithm involves iterative shifts and additions to approximate functions like sine, cosine, hyperbolic sine, and hyperbolic cosine. This approach is advantageous in hardware designs where complex mathematical operations need to be performed efficiently.

6. **Synthesis Report snippet:**
```bash
ABC: WireLoad = "none"  Gates =  53992 ( 15.1 %)   Cap = 11.5 ff (  5.7 %)   Area =   477177.66 ( 81.5 %)   Delay =115202.65 ps  (  2.6 %)               
ABC: netlist                       : i/o = 8904/ 8868  lat =    0  nd = 53992  edge = 135006  area =477239.55  delay =465.00  lev = 465
   Chip area for module '\mkMain': 665803.558400
```
## How to Run

Navigate to the `src` directory:

```bash
cd src
```

Compile the project:
```bash
./run c
```

Run the testbench:
```bash
./run r
```
