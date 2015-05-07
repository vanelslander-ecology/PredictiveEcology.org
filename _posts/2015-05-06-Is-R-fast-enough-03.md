---
layout: post
title: Is R Fast Enough? - Part 3 - "Fibonacci"
author: Eliot McIntire
date: May 6, 2015
tags: [R]
comments: true
---

In part 3 of this series on benchmarking `R`, it will be quick. Just the Fibonacci series. This is one that R gets a really bad reputation about.  Because it is an iterative function, it can't be vectorized, which is the usual way that we make R programs fast. Doing explicit loops in `R` is thought to be slow. So lets look...

Similarly, [julialang.org](http://julialang.org) showed that Fibonacci series was, again, particularly bad in `R`. We, again, felt that this was a case of poor `R` coding, or more accurately, missing the point of whether `R` was capable or not.  

### Fibonacci Series

We run 2 versions of `C++`, 2 versions of `R` that we build here, and 1 version within the `numbers` package from the open source R community.







```r
# Define two R functions
fibR1 = function(n) {
    fib <- numeric(n)
    fib[1:2] <- c(1, 2)
    for (k in 3:n) {
        fib[k] <- fib[k - 1] + fib[k - 2]
    } 
    return(fib)
}
fibR2 = function(n) {
     if (n < 2) {
         return(n)
     } else {
         return(fibR2(n-1) + fibR2(n-2))
     }
}

N = 20L
mbFib <- microbenchmark(times=200L, 
                    a <- fibonacci(N+1, TRUE)[N+1], 
                    b <- fibCpp1(N+1), 
                    d <- fibCpp2(N+1), 
                    e <- fibR1(N)[N], 
                    f <- fibR2(N+1))
summary(mbFib)[c(1,2,5,7)]
```

```
##                                 expr       min     median        max
## 1 a <- fibonacci(N + 1, TRUE)[N + 1]    47.924    61.9015  16823.625
## 2                b <- fibCpp1(N + 1)    55.604    60.2115    110.899
## 3                d <- fibCpp2(N + 1)    55.604    61.4405    128.409
## 4                   e <- fibR1(N)[N]    35.329    44.8520    980.880
## 5                  f <- fibR2(N + 1) 85597.578 88614.4030 133390.309
```

```r
all.equalV(a,b,d, e, f)
```

```
## [1] TRUE
```

Here, one of the two native R implementations is **1599x faster** by pre-allocating the output vector size. The fibonacci function in the package `numbers` was 2.36x slower than the faster `R` function because it has error checking. ***The native C++ version was 1.12x slower***. 

#### Take home points:

1. *Pre-allocate* vectors. This is standard in other languages, yet it is not done in many basic tests of R code.

`R` certainly held its own, again, compared to simple `C++` functions precompiled using `Rcpp` package. In this case, we used native `R` with pre-allocation, and it was faster than the fastest `C++` version. And of course, there was a very slow way to do things in `R` as well. The function within the package `numbers` was very fast and had nice checking within the function that is likely worth the overhead in many cases. 

#### Conclusion

*YES! `R` is more than fast enough*.  

#### Next time - Loops

How to make loops in R faster, for those times that you can't make code vectorized.

--------------------

#### Functions used

The C++ functions that were used are:


```r
cppFunction('int fibCpp2(const int x) {
    if (x == 0 || x == 1) return(x);
    return (fibCpp2(x - 1)) + fibCpp2(x - 2);
}')

cppFunction('int fibCpp1(int n) {
    return n < 2 ? n : fibCpp1(n-1) + fibCpp1(n-2);
}')

all.equalV = function(...) {
  vals <- list(...)
  all(sapply(vals[-1], function(x) all.equal(vals[[1]], x)))
}
```

#### System used:
Tests were done on an HP Z400, Xeon 3.33 GHz processor, running Windows 7 Enterprise, using:


```
## R version 3.2.0 (2015-04-16)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 7 x64 (build 7601) Service Pack 1
## 
## locale:
## [1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252   
## [3] LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                   
## [5] LC_TIME=English_Canada.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] microbenchmark_1.4-2 numbers_0.5-6        Rcpp_0.11.5         
## [4] rbenchmark_1.0.0    
## 
## loaded via a namespace (and not attached):
##  [1] codetools_0.2-11 digest_0.6.8     MASS_7.3-40      grid_3.2.0      
##  [5] plyr_1.8.1       gtable_0.1.2     formatR_1.1      scales_0.2.4    
##  [9] evaluate_0.6     ggplot2_1.0.1    reshape2_1.4.1   rmarkdown_0.5.1 
## [13] proto_0.3-10     tools_3.2.0      stringr_0.6.2    munsell_0.4.2   
## [17] yaml_2.1.13      colorspace_1.2-6 htmltools_0.2.6  knitr_1.9
```
