#!/usr/bin/Rscript

library(RcppCNPy)

fmat <- npyLoad("fmat.npy")
fmat
stopifnot(all.equal(fmat, t(matrix(seq(0,11) * 1.1, 4, 3))))

fmat <- npyLoad("fmat.npy.gz")
fmat
stopifnot(all.equal(fmat, t(matrix(seq(0,11) * 1.1, 4, 3))))

if (npyHasIntegerSupport()) {
    imat <- npyLoad("imat.npy", "integer")
    imat
    stopifnot(all.equal(imat, t(matrix(seq(0,11), 4, 3))))
}

fvec <- npyLoad("fvec.npy")
fvec
stopifnot(all.equal(fvec, seq(0,4) * 1.1))

if (npyHasIntegerSupport()) {
    ivec <- npyLoad("ivec.npy", "integer")
    ivec
    stopifnot(all.equal(ivec, seq(0,4)))
}

