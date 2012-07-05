\name{NEWS}
\title{News for Package \pkg{RcppCNPy}}
\newcommand{\cpkg}{\href{http://CRAN.R-project.org/package=#1}{\pkg{#1}}}

\section{Changes in version 0.0.1 (2012-07-04)}{
  \itemize{
    \item Initial version, as a straightforward Rcpp modules wrap around
    the \code{cpny} library by Carl Rogers (on github under a MIY
    licens).
    \item At present, \code{npy} files can be read and written for
    vectors and matrices of either \code{numeric} or \code{integer} type.
    Note however that matrices are currently \emph{transposed} because
    of the default Fortran ordering done by numpy.
  } 
}
