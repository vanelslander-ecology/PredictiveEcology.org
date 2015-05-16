---
layout  : post
title   : Reliable comparison of floating point numbers in R
author  : Alex Chubaty
date    : May 16, 2015
comments: true
tags    : [R]
---

> Version 0.2.0 of `fpCompare` has been released on CRAN

Comparisons of floating point numbers are problematic due to errors associated with the binary representation of decimal numbers.
Computer scientists and programmers are aware of these problems and yet people still use numerical methods which fail to account for floating point errors (this pitfall is the first to be highlighted in Circle 1 of Burns (2012) [The R Inferno](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf)).

Inspired by [R FAQ 7.31](http://cran.r-project.org/doc/FAQ/R-FAQ.html#Why-doesn_0027t-R-think-these-numbers-are-equal_003f) and [this Stack Overflow answer](http://stackoverflow.com/a/2769618/1380598), the `fpCompare` package provides new relational operators useful for performing floating point number comparisons with a set tolerance:

```r
set.seed(123)
a <- 1:6
b <- jitter(1:6, 1e-7)
print(rbind(a,b), digits=16)

b %<=% a    # b <= a 
b %<<% a    # b <  a
b %>=% a    # b >= a 
b %>>% a    # b >  a
b %==% a    # b == a
b %!=% a    # b != a 
```

These functions use the `base` relational operators to make comparisons, but incorporate a tolerance value (`fpCompare.tolerance`), set via `options`.
It uses the same default tolerance value used in `all.equal` for numeric comparisons.

```r
# set telorance value
tol = .Machine$double.eps^0.5       # default value
options(fpCompare.tolerance = tol)

# perform comparisons
x1 <- 0.5 - 0.3
x2 <- 0.3 - 0.1
x1 == x2         # FALSE on most machines
x1 %==% x2       # TRUE everywhere
```

## Installation

### From CRAN

```r
install.packages("fpCompare")
```

### From GitHub

```r
library(devtools)
install_github("PredictiveEcology/fpCompare")
```

## Bug Reports

[https://github.com/PredictiveEcology/fpCompare/issues](https://github.com/PredictiveEcology/fpCompare/issues)
