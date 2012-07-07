\name{RcppCNPy-package}
\alias{RcppCNPy-package}
\alias{RcppCNPy}
\alias{npyLoad}
\alias{npySave}
\docType{package}
\title{
  File access to data files written by (or for) NumPy (Numeric Python) modules
}
\description{
  This package provides access to the \code{cnpy} library by Carl Rogers
  which provides read and write facilities for files created with (or for) the
  NumPy extension for Python.

  Support is currently limited to reading and writing of either vectors
  or matrices of numeric types. Integer support can be added if the
  package, as well \pkg{Rcpp} are recompiled using the \code{-std=c++11}
  flag.

  Files with \code{gzip} compression can be transparently read as well.
}
\usage{
  npyLoad(filename, type="numeric")
  npySave(filename, object, mode="w")
}
\arguments{
  \item{filename}{string with (path and) filename for a \code{npy} object file}
  \item{type}{string with type 'numeric' (default) or 'integer'}
  \item{object}{an R object, currently limited to a vector or matrix of
    either integer or numeric type}
  \item{mode}{a one-character string indicating whether files are
    appended to ("a") or written ("w", the default)}
}
\details{
  \tabular{ll}{
    Package: \tab RcppCNPy\cr
    Type: \tab Package\cr
    Version: \tab 0.1.0\cr
    Date: \tab 2012-07-07\cr
    License: \tab GPL (>= 2)\cr
  }

  The package uses Rcpp modules to provide R bindings \code{npyLoad()}
  and \code{npySave()} which wrap the \code{npy_load()} and
  \code{npy_save()} functions. Currently, only one- and two-dimensional
  vectors and matrices are suppported; higher-dimensional arrays could
  be added.
}
\author{
  Dirk Eddelbuettel provide the binding to R (using the Rcpp package).

  Carl Rogers wrote the underlying \code{cnpy} library, which is
  released under the MIT license.
  
  Maintainer: Dirk Eddelbuettel <edd@debian.org>
}
\references{
  Rcpp, in particular the Rcpp modules documentation.

  The \code{cnpy} repository: \url{https://github.com/rogersce/cnpy}
}
\keyword{package}
\seealso{
  \code{\link[Rcpp:Rcpp-package]{Rcpp}} 
}
\examples{
  ## TODO, but see demo()
}
