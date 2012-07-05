// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-
//
// cnpyMod.cpp: Rcpp R/C++ modules interface to cnpy
//
// Copyright (C) 2012  Dirk Eddelbuettel
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

Rcpp::RObject npyLoad(const std::string & filename, const std::string & type) { 
    cnpy::NpyArray arr = cnpy::npy_load(filename);
    std::vector<unsigned int> shape = arr.shape;
    if (shape.size() != 2)  Rf_error("Wrong dimension");
    SEXP ret = R_NilValue;      		// allows us to assign either int or numeric 
    if (type == "numeric") {
        ret = Rcpp::NumericMatrix(shape[0], shape[1], reinterpret_cast<double*>(arr.data));
    } else if (type == "integer") {
        ret = Rcpp::IntegerMatrix(shape[0], shape[1], reinterpret_cast<int*>(arr.data));
    } else {
        arr.destruct();
        REprintf("Unsupported type in npyLoad");
    }
    arr.destruct();
    return ret;
}

void npySave(std::string filename, Rcpp::RObject x, std::string mode) { 
    if (::Rf_isMatrix(x)) {
        if (::Rf_isInteger(x)) {
            Rcpp::IntegerMatrix mat(x);
            std::vector<unsigned int> shape = Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(mat.nrow(), mat.ncol()));
            cnpy::npy_save(filename, mat.begin(), &(shape[0]), 2, mode);
        } else if (::Rf_isNumeric(x)) {
            Rcpp::NumericMatrix mat(x);
            std::vector<unsigned int> shape = Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(mat.nrow(), mat.ncol()));
            cnpy::npy_save(filename, mat.begin(), &(shape[0]), 2, mode);
        } else {
            REprintf("Unsupported matrix type\n");
        }
    } else if (::Rf_isVector(x)) {
        if (::Rf_isInteger(x)) {
            Rcpp::IntegerVector vec(x);
            std::vector<unsigned int> shape = Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(vec.length()));
            cnpy::npy_save(filename, vec.begin(), &(shape[0]), 1, mode);
        } else if (::Rf_isNumeric(x)) {
            Rcpp::NumericVector vec(x);
            std::vector<unsigned int> shape = Rcpp::as<std::vector<unsigned int> >(Rcpp::IntegerVector::create(vec.length()));
            cnpy::npy_save(filename, vec.begin(), &(shape[0]), 1, mode);
        } else {
            REprintf("Unsupported vector type\n");
        }
    } else {
        REprintf("Unsupported type\n");
    }
}

RCPP_MODULE(cnpy){

    using namespace Rcpp;

    function("npyLoad",         		// name of the identifier at the R level
             &npyLoad,          		// function pointer to helper function defined above
             List::create( Named("filename"),   // function arguments including default value
                           Named("type") = "numeric"),
             "read an npy file into a numeric or integer matrix");

    function("npySave",         		// name of the identifier at the R level
             &npySave,          		// function pointer to helper function defined above
             List::create( Named("filename"),   // function arguments including default value
                           Named("object"), 
                           Named("mode") = "w"),
             "save an R object (vector or matrix of type integer or numeric) to an npy file");

}
