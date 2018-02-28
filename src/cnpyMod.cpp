// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-
//
// cnpyMod.cpp: Rcpp R/C++ modules interface to cnpy
//
// Copyright (C) 2012 - 2014  Dirk Eddelbuettel
//
// This file is part of RcppCNPy.
//
// RcppCNPy is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// RcppCNPy is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with RcppCNPy.  If not, see <http://www.gnu.org/licenses/>.

#include <Rcpp.h>               // need to include the main Rcpp header file only
#include "cnpy.h"               // (local copy of) header for cnpy library

template <typename T>
T transpose(const T & m) {      // tranpose for IntegerMatrix / NumericMatrix, see array.c in R
    int k = m.rows(), n = m.cols();
    //Rcpp::Rcout << "Transposing " << n << " by " << k << std::endl;
    T z(n, k);
    int sz1 = n*k-1;
    typename T::const_iterator mit ;
    typename T::iterator zit;
    for (mit = m.begin(), zit = z.begin(); mit != m.end(); mit++, zit += n) {
        if (zit >= z.end()) zit -= sz1;
        *zit = *mit;
    }
    return(z);
}

// cf stackoverflow.com/questions/874134
bool hasEnding(std::string const &full, std::string const &ending) {
    if (full.length() >= ending.length()) {
        return(0 == full.compare(full.length() - ending.length(), ending.length(), ending));
    } else {
        return false;
    }
}

Rcpp::RObject npyLoad(const std::string & filename, const std::string & type, const bool dotranspose) { 

    cnpy::NpyArray arr;

    if (hasEnding(filename, ".gz")) {
        arr = cnpy::npy_gzload(filename);
    } else {
        arr = cnpy::npy_load(filename);
    }

    std::vector<unsigned int> shape = arr.shape;
    SEXP ret = R_NilValue;      		// allows us to assign either int or numeric 
    if (shape.size() == 1) {
        if (type == "numeric") {
            double *p = reinterpret_cast<double*>(arr.data);
#ifdef WORDS_BIGENDIAN
            std::transform(p, p + shape[0], p, swap_endian<double>);
#endif
            ret = Rcpp::NumericVector(p, p + shape[0]);
        } else if (type == "integer") {
            int64_t *p = reinterpret_cast<int64_t*>(arr.data);
#ifdef WORDS_BIGENDIAN
            std::transform(p, p + shape[0], p, swap_endian<int64_t>);
#endif
            ret = Rcpp::IntegerVector(p, p + shape[0]);
        } else {
            arr.destruct();
            Rf_error("Unsupported type in npyLoad");
        } 
    } else if (shape.size() == 2) {
        if (type == "numeric") {
            double *p = reinterpret_cast<double*>(arr.data);
#ifdef WORDS_BIGENDIAN
            std::transform(p, p + shape[0] * shape[1], p, swap_endian<double>);
#endif
            // invert dimension for creation, and then tranpose to correct Fortran-vs-C storage
            if (dotranspose) {
                ret = transpose(Rcpp::NumericMatrix(shape[1], shape[0], p));
            } else {
                ret = Rcpp::NumericMatrix(shape[0], shape[1], p);
            }
        } else if (type == "integer") {
            int64_t *p = reinterpret_cast<int64_t*>(arr.data);
#ifdef WORDS_BIGENDIAN
            std::transform(p, p + shape[0] * shape[1], p, swap_endian<int64_t>);
#endif
            // invert dimension for creation, and then tranpose to correct Fortran-vs-C storage
            if (dotranspose) {
                ret = transpose(Rcpp::IntegerMatrix(shape[1], shape[0], p));
            } else {
                ret = Rcpp::IntegerMatrix(shape[0], shape[1], p);
            }
        } else {
            arr.destruct();
            Rf_error("Unsupported type in npyLoad");
        }
    } else {
        arr.destruct();
        Rf_error("Unsupported dimension in npyLoad");
    }
    arr.destruct();
    return ret;
}

void npySave(std::string filename, Rcpp::RObject x, std::string mode, bool checkPath) {
    if (checkPath) {
        Rcpp::Environment ns = Rcpp::Environment::namespace_env("RcppCNPy");
        Rcpp::Function checkPath = ns[".checkPath"];
        bool res = Rcpp::as<bool>(checkPath(filename));
        if (!res) Rcpp::stop("Filename contains non-existing directory.");
    }
    if (::Rf_isMatrix(x)) {
        if (::Rf_isInteger(x)) {
            Rcpp::IntegerMatrix mat = transpose(Rcpp::IntegerMatrix(x));
            std::vector<int64_t> vec(mat.ncol()*mat.nrow());
            std::copy(mat.begin(), mat.end(), vec.begin());
#ifdef WORDS_BIGENDIAN
            std::transform(vec.begin(), vec.end(), vec.begin(), swap_endian<int64_t>);
#endif
            std::vector<unsigned int> shape = 
                Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(mat.ncol(), mat.nrow()));
            if (hasEnding(filename, ".gz")) {
                cnpy::npy_gzsave<int64_t>(filename, &(vec[0]), &(shape[0]), 2); 	// no mode, overwrite only
            } else {
                cnpy::npy_save<int64_t>(filename, &(vec[0]), &(shape[0]), 2, mode);
            }
        } else if (::Rf_isNumeric(x)) {
            Rcpp::NumericMatrix mat = transpose(Rcpp::NumericMatrix(x));
#ifdef WORDS_BIGENDIAN
            std::transform(mat.begin(), mat.end(), mat.begin(), swap_endian<double>);
#endif
            std::vector<unsigned int> shape = 
                Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(mat.ncol(), mat.nrow()));
            
            if (hasEnding(filename, ".gz")) {
                cnpy::npy_gzsave<double>(filename, mat.begin(), &(shape[0]), 2); 	// no mode, overwrite only
            } else {
                cnpy::npy_save<double>(filename, mat.begin(), &(shape[0]), 2, mode);
            }
        } else {
            Rf_error("Unsupported matrix type\n");
        }
    } else if (::Rf_isVector(x)) {
        if (::Rf_isInteger(x)) {
            Rcpp::IntegerVector vec(x);
            std::vector<int64_t> v(vec.size());
            std::copy(vec.begin(), vec.end(), v.begin());
#ifdef WORDS_BIGENDIAN
            std::transform(v.begin(), v.end(), v.begin(), swap_endian<int64_t>);
#endif
            std::vector<unsigned int> shape = 
                Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(vec.length()));
            if (hasEnding(filename, ".gz")) {
                cnpy::npy_gzsave<int64_t>(filename, &(v[0]), &(shape[0]), 1);	// no mode, append only
            } else {
                cnpy::npy_save<int64_t>(filename, &(v[0]), &(shape[0]), 1, mode);
            }
        } else if (::Rf_isNumeric(x)) {
            Rcpp::Rcout << "Saving Numeric Vector\n";
#ifdef WORDS_BIGENDIAN
            Rcpp::NumericVector vec(Rcpp::clone(x)); // ensures a deep copy
            std::transform(vec.begin(), vec.end(), vec.begin(), swap_endian<double>);
#else
            Rcpp::NumericVector vec(x);
#endif
            std::vector<unsigned int> shape = 
                Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(vec.length()));
            if (hasEnding(filename, ".gz")) {
                cnpy::npy_gzsave<double>(filename, vec.begin(), &(shape[0]), 1); 	// no mode, append only
            } else {
                cnpy::npy_save<double>(filename, vec.begin(), &(shape[0]), 1, mode);
            }
        } else {
            Rf_error("Unsupported vector type\n");
        }
    } else {
        Rf_error("Unsupported type\n");
    }
}

bool npyHasIntegerSupport() {
    return true;                // no longer conditional
}

RCPP_MODULE(cnpy){

    using namespace Rcpp;

    function("npyLoad",         		// name of the identifier at the R level
             &npyLoad,          		// function pointer to helper function defined above
             List::create( Named("filename"),   // function arguments including default value
                           Named("type") = "numeric",
                           Named("dotranspose") = true),
             "read an npy file into a numeric or integer vector or matrix");

    function("npySave",         		// name of the identifier at the R level
             &npySave,          		// function pointer to helper function defined above
             List::create( Named("filename"),   // function arguments including default value
                           Named("object"), 
                           Named("mode") = "w",
                           Named("checkPath") = true),
             "save an R object (vector or matrix of type integer or numeric) to an npy file");

    function("npyHasIntegerSupport", &npyHasIntegerSupport, 
             "return logical value indicating whether package has integer support (which need C++11)");
}
