#!/usr/bin/Rscript

library(RcppCNPy)

set.seed(42)
M1 <- matrix(rnorm(1e6, 1e3, 1e3))

tempmatfile <- tempfile(pattern="npymat", fileext=".npy")
npySave(tempmatfile, M1)

M2 <- npyLoad(tempmatfile)
identical(M1, M2)

tempmatfile <- tempfile(pattern="npymat", fileext=".npy.gz")
npySave(tempmatfile, M1)

M3 <- npyLoad(tempmatfile)
identical(M1, M3)

