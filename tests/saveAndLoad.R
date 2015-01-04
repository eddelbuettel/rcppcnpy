#!/usr/bin/Rscript

library(RcppCNPy)

set.seed(42)
M1 <- matrix(rnorm(1e6), 1e3, 1e3)

## double precision floating point, uncompressed
tempmatfile <- tempfile(pattern="npymat", fileext=".npy")
M1sd <- sd(M1)
npySave(tempmatfile, M1)
stopifnot(identical(M1sd, sd(M1)))
M2 <- npyLoad(tempmatfile)
stopifnot(identical(M1, M2))

## double precision floating point, compressed
tempmatfile <- tempfile(pattern="npymat", fileext=".npy.gz")
npySave(tempmatfile, M1)
stopifnot(identical(M1sd, sd(M1)))
M3 <- npyLoad(tempmatfile)
stopifnot(identical(M1, M3))



## integer, uncompressed
M4 <- matrix(as.integer(round(M1)), 1e3, 1e3)
tempmatfile <- tempfile(pattern="intnpymat", fileext=".npy")
M4sd <- sd(M4)
npySave(tempmatfile, M4)
stopifnot(identical(M4sd, sd(M4)))
M5 <- npyLoad(tempmatfile, "integer")
stopifnot(identical(M4, M5))

## integer, compressed
tempmatfile <- tempfile(pattern="intnpymat", fileext=".npy.gz")
npySave(tempmatfile, M4)
stopifnot(identical(M4sd, sd(M4)))
M6 <- npyLoad(tempmatfile, "integer")
stopifnot(identical(M4, M6))

