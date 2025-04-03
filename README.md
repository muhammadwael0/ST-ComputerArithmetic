# STmicroelectronics Computer Arithmetic Training

## Task 1
> Design 64-bit brent-kung adder
```
this task aims to enhance the addition operation in the digital system
Delay recurrence :
    D(k) = D(k/2)+2 = 2 log2(k) – 1
Cost recurrence :
    C(k) = C(k/2) + k – 1 = 2k – 2 – log2k
which is better than ripple carry adder
```
