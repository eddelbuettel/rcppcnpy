
## We would like to do this at the C++ level too, alas file-system operations
## are still very depedent on the operating system.  C++17 is going to help, but
## it is not yet widely enough available (and certainly not on CRAN). Boost
## has functions in its filesystem module, but they require linking with the system
## and filesystem libraries so they cannot be used in header-only mode from BH

.checkPath <- function(filename) {
    parent <- dirname(filename)
    if (!dir.exists(parent)) stop("Directory '", parent, "' does not exist", call. = FALSE)
    invisible(TRUE)
}
