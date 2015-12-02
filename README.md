## RcppCNPy

[![Build Status](https://travis-ci.org/eddelbuettel/rcppccnpy.svg)](https://travis-ci.org/eddelbuettel/rcppccnpy) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html) [![CRAN](http://www.r-pkg.org/badges/version/RcppCNPy)](http://cran.rstudio.com/package=RcppCNPy) [![Downloads](http://cranlogs.r-pkg.org/badges/RcppCNPy?color=brightgreen)](http://www.r-pkg.org/pkg/RcppCNPy)

Rcpp bindings for NumPy files

### About

This package uses the [cnpy](https://github.com/rogersce/cnpy) library
written by Carl Rogers to provide read and write facilities for files created
with (or for) the NumPy extension for Python.  Vectors and matrices of
numeric types can be read or written to and from files as well as compressed
files. Support for integer files is available if the package has been built
with -std=c++11 which is the default starting with release 0.2.3 following
the release of R 3.1.0.

### Status

On [CRAN](https://cran.rstudio.com/web/packages/RcppCNPy/index.html), stable and
mostly feature-complete.

### Author

Dirk Eddelbuettel

### License

GPL (>= 2)
