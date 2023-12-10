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


2. **Cordic Algorithm:**
   - Utilizes Cordic algorithm for efficient trigonometric and hyperbolic function calculations.
   - The Cordic algorithm involves iterative shifts and additions to approximate functions like sine, cosine, hyperbolic sine, and hyperbolic cosine. This approach is advantageous in hardware designs where complex mathematical operations need to be performed efficiently.

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
