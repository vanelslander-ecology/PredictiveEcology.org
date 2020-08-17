---
layout: post
title: Is R Fast Enough? - Part 2 - "Sorting"
author: Eliot McIntire
date: April 28, 2015
tags: [R, benchmark]
comments: true
---

In part 2 of this series on benchmarking `R`, we'll explore sorting. This has been a topic on numerous blogs, discussions and posts around the internet, including here: [r-blogger post](https://www.r-bloggers.com/quicksort-speed-just-in-time-compiling-and-vectorizing/). Similarly, [julialang.org](https://julialang.org) showed that sorting was particularly bad in `R`. We, again, felt that this was a case of poor `R` coding, or more accurately, missing the point of whether `R` was capable or not. Another [example here](https://gallery.rcpp.org/articles/sorting/) compares `R` sorting with standard library of C++, called from `R`. 

In all cases, we felt that one of the points of using `R` is that there are concise ways of doing things **because the open source community has brought them to `R`**. So lets take advantage of that! We will cover both real number sorting and integer sorting. 

### Sorting






This was in part inspired from a blog post by Wingfeet at https://www.r-bloggers.com/quicksort-speed-just-in-time-compiling-and-vectorizing/ which drew on benchmark tests here: https://julialang.org/ 
Essentially, that julia test was a benchmark to test the speed of Julia. It showed for the Quicksort, that `R` is 524x slower than C. Below is that version. But, there was no explicit comparison of how the base `R` sort would match with C, nor how any of the more recent packages with sorting capability fare against these procedural versions of low level languages. 




#### Real number sorting


```r
x = runif(1e5)
xtbl <- tbl_df(data.frame(x=x))
(mbReal <- benchmark(
           a <- qsort(x), 
           d <- sort(x), 
           e <- sort(x, method="quick"),
           f <- .Internal(sort(x,decreasing = FALSE)),
           g <- data.table(x=x,key="x"), 
           h <- arrange(xtbl,x),
           i <- stl_sort(x),
           replications=25L, columns=c("test", "elapsed", "relative"),
           order="relative"))
```

```
##                                          test elapsed relative
## 7                            i <- stl_sort(x)    0.19    1.000
## 5           g <- data.table(x = x, key = "x")    0.21    1.105
## 3              e <- sort(x, method = "quick")    0.22    1.158
## 4 f <- .Internal(sort(x, decreasing = FALSE))    0.26    1.368
## 2                                d <- sort(x)    0.28    1.474
## 6                       h <- arrange(xtbl, x)    1.48    7.789
## 1                               a <- qsort(x)   86.58  455.684
```

```r
all.equalV(a, d, e, f, g$x, h$x, i)
```

```
## [1] TRUE
```

#### Integer sorting


```r
x = sample(1e6,size = 1e5)
xtbl <- tbl_df(data.frame(x=x))
(mbInteger <- benchmark(
           a <- qsort(x), 
           d <- sort(x), 
           e <- sort(x, method="quick"), 
           f <- .Internal(sort(x,decreasing = FALSE)),
           g <- data.table(x=x,key="x"), h<-arrange(xtbl,x),
           i <- stl_sort(x),
           replications=25L, columns=c("test", "elapsed", "relative"),
           order="relative"))
```

```
##                                          test elapsed relative
## 5           g <- data.table(x = x, key = "x")    0.13    1.000
## 3              e <- sort(x, method = "quick")    0.17    1.308
## 7                            i <- stl_sort(x)    0.19    1.462
## 4 f <- .Internal(sort(x, decreasing = FALSE))    0.23    1.769
## 2                                d <- sort(x)    0.25    1.923
## 6                       h <- arrange(xtbl, x)    0.67    5.154
## 1                               a <- qsort(x)   89.28  686.769
```

```r
all.equalV(a, d, e, f, g$x, h$x, i)
```

```
## [1] TRUE
```

Both real numbers and integers can be sorted quickly with R. The slowest function is indeed the procedural `qsort` written in native `R` without any optimization. This was also the `qsort` that the Julia testers used. Our numbers match almost exactly those from the the table in julialang.org; however, here we also test the real world `R` usage that a normal `R` user would face (i.e., we can all use `sort()`). We show that `R` competes quite favourably and regularly outperforms standard library of C++ (and Julia!, though that is not tested here explicitly). 

#### Take home points:

1. the basic `R` sorting functions are fast. The `sort(method="quick")` is about as fast as the standard `C++` library sort (11% faster). 
2. using [data.table](https://cran.r-project.org/web/packages/data.table/index.html) on integers is 32% faster than the `C++` standard library sort.

In real world situations, where we want to use the easiest, shortest code to produce fast, accurate results, `R` certainly holds its own compared to the standard `C++` library. But of course, there are many ways to do things in `R`. Some are much faster than others.

#### Conclusion

Using the `sort(method="quick")` and [`data.table`](https://cran.r-project.org/web/packages/data.table/index.html) sorting, we were able to sort a vector of real numbers ***412x*** faster than a naive procedural coding (`qsort`) and ***687x*** faster on a vector of integers. These put the `data.table` sort as fast as or substantially faster than C or Fortran or Julia's version of quicksort (based on timings on [julialang.org](https://julialang.org)).

*YES! `R` is more than fast enough*.  

#### Next time (really! I promised it last time...)

We will redo the Fibonacci series, a common low level benchmarking test that [shows `R` to be slow](https://julialang.org).  But it turns out to be a case of bad coding...


--------------------

#### Functions used

The C++ functions that were used are:



```r
cppFunction('NumericVector stl_sort(NumericVector x) {
   NumericVector y = clone(x);
   std::sort(y.begin(), y.end());
   return y;
}')
qsort = function(a) {
    qsort_kernel = function(lo, hi) {
        i = lo
        j = hi
        while (i < hi) {
            pivot = a[floor((lo+hi)/2)]
            while (i <= j) {
                while (a[i] < pivot) i = i + 1
                while (a[j] > pivot) j = j - 1
                if (i <= j) {
                    t = a[i]
                    a[i] <<- a[j]
                    a[j] <<- t
                    i = i + 1;
                    j = j - 1;
                }
            }
            if (lo < j) qsort_kernel(lo, j)
            lo = i
            j = hi
        }
    }
    qsort_kernel(1, length(a))
    return(a)
}

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
## [1] data.table_1.9.4 Rcpp_0.11.5      dplyr_0.4.1      rbenchmark_1.0.0
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.8    assertthat_0.1  chron_2.3-45    plyr_1.8.1     
##  [5] DBI_0.3.1       formatR_1.0     magrittr_1.5    evaluate_0.5.5 
##  [9] lazyeval_0.1.10 reshape2_1.4.1  rmarkdown_0.5.1 tools_3.2.0    
## [13] stringr_0.6.2   yaml_2.1.13     parallel_3.2.0  htmltools_0.2.6
## [17] knitr_1.9
```
