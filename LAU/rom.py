import numpy as np

# (Q5.10)
FIXED_POINT_SCALE = 1024

# φ+ Function
def phi_plus(x):
    return np.log2(1 + 2**(-x))

# φ- Function
def phi_minus(x):
    return np.log2(1 - 2**(-x)) if x > 0 else 0

# find 2's Complement of a Number
def get_2sComplement(x, y=16):
    bin_num = bin(x)[2:].zfill(y)
    output = str()
    for i in bin_num:
        if i == '1':
            output = output + "0"
        else:
            output = output + "1"
    int_num = int(output, base=2)
    return int_num + 1

phi_plus_values = [int(phi_plus((i/1024)) * FIXED_POINT_SCALE) for i in range(10782)]
phi_minus_values = [get_2sComplement(int(phi_minus((i/1024)) * FIXED_POINT_SCALE)) for i in range(10782)]

with open("phi_plus.mem", "w") as f:
    for value in phi_plus_values:
        f.write(f"{value:04X}\n")

with open("phi_minus.mem", "w") as f:
    for value in phi_minus_values:
        f.write(f"{(value if value != phi_minus_values[0] else 65535):04X}\n")