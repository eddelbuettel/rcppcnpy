---
title: 'RcppCNPy: Read-Write Support for NumPy Files in R'
tags:
  - Python
  - NumPy
  - R
  - data transfer
authors:
  - name: Dirk Eddelbuettel
  - orcid: 0000-0001-6419-907X
affiliation: Debian and R Projects
date: 26 August 2016
bibliography: paper.bib
---

# Summary

[Python](https://https://www.python.org/) is a widely-used and popular programming
language. It is deployed in use cases ranging from simple scripting to larger-scale
application development. [Python](https://https://www.python.org/) is also popular for
quantitative and scientific application due to the existence of extension modules such as
[NumPy](http://www.numpy.org/) (which is shorthand for Numeric Python) and many other
packages for data analysis.

[NumPy](http://www.numpy.org/) is used to efficiently represent N-dimensional arrays, and
provides an efficient binary storage model for these files.  In practice, N is often equal
to two, and matrices processed or generated in [Python](https://https://www.python.org/)
can be stored in this form. As [NumPy](http://www.numpy.org/) is popular, many project
utilize this file format.

[R](https://www.r-project.org) has no dedicated reading or writing functionality for these
type of files.  However, Carl Rogers has provided a small C++ library called
[cnpy](https://github.com/rogersce/cnpy). Using the _Rcpp modules_ feature in
[Rcpp](http://dirk.eddelbuettel.com/code/rcpp.html) [@Eddelbuettel:2013:Rcpp,@CRAN:Rcpp],
we provide (some) features of this library to [R](https://www.r-project.org).

# References

