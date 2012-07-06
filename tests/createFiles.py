#!/usr/bin/python

import os
import numpy as np

# simple float and integer arrays
np.save("fmat.npy", np.arange(12).reshape(3,4) * 1.1)
np.save("imat.npy", np.arange(12).reshape(3,4))

# simple float and integer vectors
np.save("fvec.npy", np.arange(5) * 1.1)
np.save("ivec.npy", np.arange(5))
