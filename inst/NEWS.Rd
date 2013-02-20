\name{NEWS}
\title{News for Package \pkg{RcppCNPy}}
\newcommand{\cpkg}{\href{http://CRAN.R-project.org/package=#1}{\pkg{#1}}}

\section{Changes in version 0.2.1 (2013-02-19)}{
  \itemize{
    \item Ensure that inclusion of \code{Rinternal.h} does not affect
    other headers by adding RF_NO_REMAP
  }
}

\section{Changes in version 0.2.0 (2012-07-30)}{
  \itemize{
    \item Support for writing of \code{gzip}-ed \code{npy} files has
    been added.
    \item A new option \code{dotranspose} has been added to
    \code{npyLoad()} to support data sets that do not need to be
    transposed to be used in R.
    \item A memory leak in reading files has been corrected.
  }
}
\section{Changes in version 0.1.0 (2012-07-07)}{
  \itemize{
    \item Added automatic use of transpose to automagically account for
    Fortran-vs-C major storage defaults between Python and R.
    \item Support for integer types in dependent on the \code{int64_t}
    type which is available only when the \code{-std=c++0x} switch is
    used at build-time (and CRAN still discourages use of it)
    \item Added support for reading gzip'ed files ending in ".npy.gz"
    \item Added regression tests in directory \code{tests/}
    \item Added a vignette describing the package
    \item Added a timing benchmark in demo/timings.R
  }
}
\section{Changes in version 0.0.1 (2012-07-04)}{
  \itemize{
    \item Initial version, as a straightforward Rcpp modules wrap around
    the \code{cpny} library by Carl Rogers (on github under a MIT
    license).
    \item At present, \code{npy} files can be read and written for
    vectors and matrices of either \code{numeric} or \code{integer} type.
    Note however that matrices are currently \emph{transposed} because
    of the default Fortran ordering done by numpy.
  } 
}
