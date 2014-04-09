## RcppCNPy: Rcpp bindings for NumPy files

[![Build Status](https://travis-ci.org/eddelbuettel/rcppcnpy.png)](https://travis-ci.org/eddelbuettel/rcppcnpy)

This package uses the [cnpy](https://github.com/rogersce/cnpy) library
written by Carl Rogers to provide read and write facilities for files created
with (or for) the NumPy extension for Python.  Vectors and matrices of
numeric types can be read or written to and from files as well as compressed
files. Support for integer files is available if the package has been built
with -std=c++11 which is the default starting with release 0.2.3 following
the release of R 3.1.0.
