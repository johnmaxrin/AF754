# AF754
The goal is to design an area-efficient pipelined module that supports unary operators commonly used as activation functions in deep learning, specifically tanh(x), sigmoid(x), leaky ReLU(x), and SeLU(x). The module is intended to transform a data stream using one of these functions at a time. To optimize efficiency, the design will leverage the commonality in the mathematical expressions of these functions, particularly the shared use of exp(-x).

## Overview
- [ ] ***exp*** <br>
      $exp(-x) = e^{-x}$ <br>
      $e = 2.71828$
- [ ] ***tanh*** <br>
      $tanh(x) = \frac{\exp(x) - \exp(-x)}{\exp(x) + \exp(-x)}$
- [ ] ***sigmoid*** <br>
      $\sigma(x) = \frac{1}{1 + \exp(-x)}$
- [ ] ***Leaky ReLu: Rectified Linear Unit*** <br>
      ${ReLU}(x) = \max(0.o1 * x, x)$
- [ ] ***SeLu: Scaled Exponential Linear Unit*** <br>
      $SeLU(x) = λ× {(x>0)? x : a *exp(x)−1)}$ <br>
      $λ = 1.0507009 \text{ and } \alpha = 1.6732632$

## Interfaces
- [ ] `Fp32IFC()`

## Modules
- [ ] `mkActivation()`

## Functions
- [ ] `Fp32 exp( Fp32 x)`
- [ ] `Fp32 tanh(Fp32 x)`
- [ ] `Fp32 sigmoid(Fp32 x)`
- [ ] `Fp32 relu(Fp32 x)`
- [ ] `Fp32 selu(Fp32 x)`
