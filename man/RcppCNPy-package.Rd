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

  Support is currently still pretty limited to reading and writing of
  either vectors or matrices of either numeric or integer type.

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
    Version: \tab 0.0.1\cr
    Date: \tab 2012-07-04\cr
    License: \tab What license is it under?\cr
    LazyLoad: \tab yes\cr
  }

  The package uses Rcpp modules to provide R bindings \code{npyLoadNM()}
  and \code{npyLoadIM()} which wrap the \code{npy_load()}
  function. Currently, only two-dimensional matrices are suppported but
  this can be extended easily to vectors.

  The following minor changes were made to \code{cnpy}:
  \itemize{
    \item the \code{printf(...); abort()} combination was replaced in
    three instances with \code{REprintf(...)} per CRAN Policy guidelines.
    \item \code{long long} was commented out in two places (which we can revert once
    CRAN switches to a new compiler and c++11 becomes standard) and one
    \code{unsigned long long} was replaced by \code{unsigned long}.
    \item several unused variables were commented out.
  }
  
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
  ## TODO
}
