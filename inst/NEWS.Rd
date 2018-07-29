\name{NEWS}
\title{News for Package \pkg{RcppCNPy}}
\newcommand{\cpkg}{\href{http://CRAN.R-project.org/package=#1}{\pkg{#1}}}

\section{Changes in version 0.2.10 (2018-07-29)}{
  \itemize{
    \item The vignettes have been updated using \sQuote{collapse} mode
    and edited.
    \item The README.md now refers to \CRANpkg{reticulate} as an
    alternative and points to the \dQuote{Using reticulate} vignette.
    \item The file \code{src/RcppExports.cpp} is used for package
    registration instead of \code{src/init.c}.
  }
}

\section{Changes in version 0.2.9 (2018-03-22)}{
  \itemize{
    \item The \code{npySave} function has a new option to check the path
    in the given filename.
    \item A new vignette was added showing how the \pkg{reticulate}
    package can be used instead.
  }
}

\section{Changes in version 0.2.8 (2018-01-04)}{
  \itemize{
    \item Vignette sets knitr option \code{python.reticulate=FALSE} to
    avoid another dependency just for the vignette [CRAN request]
  }
}

\section{Changes in version 0.2.7 (2017-09-22)}{
  \itemize{
    \item Vignette updated to Rmd and use of \code{pinp} package
    \item File \code{src/init.c} added for dynamic registration
  }
}

\section{Changes in version 0.2.6 (2016-09-25)}{
  \itemize{
    \item Expanded documentation in README.md
    \item Added examples to help page
    \item Added CITATION file for JOSS paper
  }
}
    
\section{Changes in version 0.2.5 (2016-08-26)}{
  \itemize{
    \item Synchronized code with the \code{cnpy} repository
    \item Updated vignette
    \item Expanded DESCRIPTION
  }
}

\section{Changes in version 0.2.4 (2015-01-05)}{
  \itemize{
    \item Support for saving integer objects was not correct and has been
    fixed
    \item Support for loading and saving on 'big endian' systems was
    incomplete, has been greatly expanded and corrected, thanks in large
    part to very diligent testing as well as patching by Wush Wu
    \item The implementation now uses const iterators, thanks to a pull
    request by Romain Francois
    \item The vignette no longer assumes that one can call \code{gzip}
    via \code{system} as the world's leading consumer OS may disagree.
  }
}

\section{Changes in version 0.2.3 (2014-04-10)}{
  \itemize{
    \item \code{src/Makevars} now sets \code{CXX_STD = CXX11} which also
    provides the \code{long long} type on all platforms, so integer file
    support is no longer conditional
    \item Consequently, code conditional on \code{RCPP_HAS_LONG_LONG_TYPES}
    has been simplified and is no longer conditional.
    \item The package now depends on R 3.1.0 or later to allow this.
    \item The vignette has been updated and refreshed to reflect this.
  }
}

\section{Changes in version 0.2.2 (2013-11-29)}{
  \itemize{
    \item Switched to using the result from the compile-time configuration 
    for R to determine big or little endian (as needed for the \code{NPy} 
    headers)
    \item Added a new test (and test validation result file) for a complete 
    save-reload cycle and comparison
  }
}

\section{Changes in version 0.2.1 (2013-11-28)}{
  \itemize{
    \item Synchronized code with the \code{cnpy} repository
    \item Added new function to test from R whether integers supported
    \item Updated tests for integer support, if available
    \item Updated vignette and discussion about need for rebuilding only
    \pkg{RcppCNPy} with the \code{-std=c++11} flag if integer support is
    desired 
    \item Updated tests for integer support, if available
    \item Updated THANKS file
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
