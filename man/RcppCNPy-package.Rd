\name{RcppCNPy-package}
\alias{RcppCNPy-package}
\alias{RcppCNPy}
\alias{npyLoad}
\alias{npySave}
\alias{npyHasIntegerSupport}
\docType{package}
\title{
  File access to data files written by (or for) NumPy (Numeric Python) modules
}
\description{
  This package provides access to the \code{cnpy} library by Carl Rogers
  which provides read and write facilities for files created with (or for) the
  NumPy extension for Python.

  Support is provided to reading and writing of either vectors
  or matrices of numeric or integer types. 

  Files with \code{gzip} compression can be transparently read and
  written as well.
}
\usage{
  npyLoad(filename, type="numeric", dotranspose=TRUE)
  npySave(filename, object, mode="w", checkPath=TRUE)
  npyHasIntegerSupport()
}
\arguments{
  \item{filename}{string with (path and) filename for a \code{npy}
    object file. If the string ends with \code{.gz}, compressed files
    can be read or written.}
  \item{type}{string with type 'numeric' (default) or 'integer'.}
  \item{object}{an R object, currently limited to a vector or matrix of
    either integer or numeric type}
  \item{dotranspose}{a boolean variable indicating whether a
    two-dimensional object should be transposed after reading, default
    is true}
  \item{mode}{a one-character string indicating whether files are
    appended to ("a") or written ("w", the default). In case of writing
    \code{gzip}-ed file, this option is not supported as such files can
    only be (over-)written, and bot appended.
  }
  \item{checkPath}{a boolean variable indicating whether a path implied
    in the \code{filename} argument is to be checked for existing
    directories, default is true.
  }
}
\details{
  The package uses Rcpp modules to provide R bindings \code{npyLoad()}
  and \code{npySave()} which wrap the \code{npy_load()} and
  \code{npy_save()} functions. Currently, only one- and two-dimensional
  vectors and matrices are suppported; higher-dimensional arrays could
  be added.

  Integer support requires access to the \code{long long} type which is
  available if the package is built using the C++11 standard; this is
  the default since release 0.2.3 which came out after R 3.1.0 permitted
  used of C++11 in CRAN packages.
}
\author{
  Dirk Eddelbuettel provided the binding to R (using the Rcpp package).

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
\dontrun{
    library(RcppCNPy)

    ## load NumPy file with floating-point data
    fmat <- npyLoad("fmat.npy")
    
    ## load NumPy file with integer data
    imat <- npyLoad("imat.npy", "integer")

    ## save floating-point data: matrix and vector
    M <- matrix(0:11, 3, 4, byrow=TRUE) * 1.1
    v <- v <- 0:4 * 1.1
    npySave("fmat.npy", M)
    npySave("fvec.npy", v)

    ## save integer data: matrix and vector
    M <- matrix(0:11, 3, 4, byrow=TRUE)
    v <- v <- 0:4 
    npySave("imat.npy", M)
    npySave("ivec.npy", v)
    
    }  
}
