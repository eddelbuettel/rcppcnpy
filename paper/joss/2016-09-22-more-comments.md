Thank you for the quick and thorough review, @mdnunez!

I have a few additional comments/suggestions before acceptance.

(1) paper.md didn't pull the author information properly (hopefully @arfon can look into that), however, the package vignette on CRAN (https://cran.r-project.org/web/packages/RcppCNPy/vignettes/RcppCNPy-intro.pdf) includes a second author, also listed in the README.md, that isn't included in the JOSS submission. They should probably also be included in paper.md.

(2) Since the package vignette in CRAN includes more information, it would be good to also reference/point-to that as well (in paper.md).

(3) README.md should have a small section for the installation instructions. I think it should include both the install.packages("RcppCNPy"), as well as install.packages("eddelbuettel/rcppcnpy"), should the CRAN package be a slightly older version than that found on GitHub.

(4) README.md should also include a sentence pointing to the tests directory. A short description of each test (in README.md or in a separate file) would also be beneficial.

(5) It would be good to cite NumPy in the paper, see https://www.scipy.org/citing.html.





Briefly

(1) I will add Wush as he is a contributor to the package.
(2) Yes, that occurred to me too, and I saw other JOSS submission do it. Will do.
(3) I will add the usual two-liner about install.packages(). The delta is temporary and are the changes I made in the 24 hours in response to this very issue ticket / review, and are in a branch. (I consider CRAN to be the primary and always push releases. GitHub is my development repository. This policy has been consistent and transparent for ten+ years across two dozen packages. I do not plan to change that.)
(4) No. It is a CRAN package, and R users understand how to tickle tests. The README in the repository is not a replacement for the R manuals.
(5) I look for such citation information, but found it wanting. If anything, the cnpy repository should be cited (and I will add this). RcppCNPy does not contain NumPy code or functionality so this is a bit of a stretch. But I will add it.



(3) I still think it would be good to add install.packages("RcppCNPy") to the README.md, to be overtly clear how the package can be installed from CRAN. This also may be useful in preventing confusion related to the case-sensitivity (also since the GitHub repo is named in all lowercase).

(5) Despite the package not using any NumPy code, it is built as a means to read-write from the NumPy data format--that's why I think citing NumPy makes sense. I hope the rationale is more clear now.





(3) Yes I agree (and I edited the above commented twice). I checked, and this package does not have the short block most my other packages have -- ie preference for install.packages(). I will add that.

(5) Yes. No point to debate this to death. Taken further, we could also cite R and Python. But NumPy is appropriate, and cnpy even more so. Any tips on citing 'unpublished' github repos?
