---
layout: post
title: Is `R` Fast Enough? - Part 4 - "Loops"
author: Eliot McIntire
date: Sept 4, 2015
tags: [R]
comments: true
---

In part 4 of this series on benchmarking `R`, we'll explore loops and a common alternative, vectorizing. This is probably the "biggest" issue making people think that R is a slow language. Essentially, other procedural languages use explicit loops; programmers moving from those languages to R start with the same procedures and find that R is slow. We will discuss a range of ways making loops faster and how vectorizing can help. 

There are many other resources about this topic; we will try to be concise and show the worst case, the best case, and many little steps in between.


## Loops

Loops have been the achilles heel of R in the past. In version 3.1 and forward, much of this problem appears to be gone. As could be seen in the [http://predictiveecology.org/2015/05/06/Is-R-fast-enough-03.html](Fibonacci  example), pre-allocating a vector and filling it up inside a loop can now be very fast and efficient in native R. To demonstrate these points, below are 6 ways to achieve the same result in R, beginning with a naive loop approach, and working up to the fully vectorized approach. I am using a very fast vectorized function, seq_len, to emphasize the differences between using loops and optimized vectorized functions.





The basic code below generates random numbers. The sequence goes from a fully unvectorized, looped structure, with no pre-allocation of the output vector, through to pure vectorized code. The intermediate steps are:

- Loop
- Loop with pre-allocated length of output
- sapply (like loops)
- sapply with pipe operator
- vectorized
- vectorized with no intermediate objects
- C++ vectorized




```r
library(magrittr) # for pipe %>%
library(data.table)
N = 1e5

unifs <- runif(N) 
dt = data.table(num=rep(NA_real_, N))

mb = microbenchmark::microbenchmark(times=5L,

                                     
# no pre-allocating of vector length, generating uniform random numbers once, then calling them within each loop
loopWithNoPreallocate = {
  set.seed(104)
  a <- numeric()
    for (i in 1:N) {
      a[i] = unifs[i]
    } 
   a
  } ,

# pre-allocating vector length, generating uniform random numbers once, then calling them within each loop
loopWithPreallocate = {
    set.seed(104)
    a <- numeric(N) 
    for (i in 1:N) {
      a[i] = unifs[i]
    }
    a
  },
 
# # sapply - generally faster than loops
sapplyVector1 = {
      set.seed(104)
      sapply(unifs,function(x) x)
      },

# sapply with pipe operator: no intermediate objects are created
sapplyWithPipe = {
      set.seed(104)
      unifs <- (runif(N)) %>%
        sapply(.,function(x) x)
      },

# use data.table set function, which can be very fast inside a loop
datatableSet = {
  set.seed(104)
  for(i in 1L:N) {
    set(dt, i, j = 1L, unifs[i])
  }
  dt
  },

# vectorized with intermediate object before return
vectorizedWithCopy = {
    set.seed(104)
    unifs <- runif(N)
    unifs
  },

# no intermediate object before return
vectorizedWithNoCopy = {
  set.seed(104)
  runif(N)
  },

cpp = {
  set.seed(104)
  runifCpp(N)
}
)

print("Units: milliseconds")
```

```
## [1] "Units: milliseconds"
```

```r
summary(mb, unit="ms")[c(1,2,5,7,8)]
```

```
##                    expr          min       median          max neval
## 1 loopWithNoPreallocate 12802.511195 12908.986463 13618.461857     5
## 2   loopWithPreallocate   141.383047   150.713476   199.640091     5
## 3         sapplyVector1    64.211709    72.396608   104.804129     5
## 4        sapplyWithPipe    70.540230    74.944790    82.344498     5
## 5          datatableSet   274.122245   277.530571   286.644428     5
## 6    vectorizedWithCopy     3.572677     3.702005     3.952369     5
## 7  vectorizedWithNoCopy     3.729653     3.873727     4.120712     5
## 8                   cpp     1.437057     1.578675     1.859143     5
```

```r
# Test that all results return the same vector
all.equalV(loopWithNoPreallocate, 
           datatableSet$num, 
           loopWithPreallocate, 
           sapplyVector1, sapplyWithPipe, 
           vectorizedWithCopy, vectorizedWithNoCopy, 
           cpp[,1])
```

```
## Warning in all(sapply(vals[-1], function(x) all.equal(vals[[1]], x))):
## coercing argument of type 'character' to logical
```

```
## [1] NA
```

```r
sumLoops <- round(summary(mb)[[5]],1)
```

The fully vectorized function is ***3489x*** faster than the fully naive loop. Note also that making as few intermediate objects as possible is faster as well. Comparing vectorizedWithCopy and vectorizedWithNoCopy (where the only difference is making one copy of the object) shows virtually no change. This, I believe, is due to some improvements in after version 3.1 of R that reduces copying for vectors and matrices. 

Using pipes instead of intermediate objects also did not change the speed very much (slight change by -3.34%). Since these are simple tests, larger, or more complex objects, will likely see improvements using pipes.

Note, in this case, the C++, using [Rcpp sugar](http://gallery.rcpp.org/articles/random-number-generation/) was the fastest, 2.44x faster.

*Note also, that this example is somewhat artificial, because it is also comparing the random number generating speeds at the same time as the loop speeds. Thus, these benchmarks about loops are simply for illustrative purposes. The speed gains in loops will be determined mostly by what is actually happening within the loops.*

## Conclusions

***Write vectorized code in R*** where possible. If not possible, pre-allocate prior to writing loops. If speed is crucial, as in simulation studies using `SpaDES`, consider writing in C++ via `Rcpp` package, though as we showed in previous posts, this often is not necessary.
  
Perhaps more importantly, with the `Rcpp` package and its infrastructure, we get access to very fast code, but within the higher level `R` language opening it up to many more users.

#### Next time 

We move on to higher level operations. Specifically, some GIS operations.

#### See also

http://gallery.rcpp.org/tags/benchmark/

--------------------

#### Functions used


```r
all.equalV = function(...) {
  vals <- list(...)
  all(sapply(vals[-1], function(x) all.equal(vals[[1]], x)))
}

cppFunction('NumericMatrix runifCpp(const int N) {
  NumericMatrix X(N, 1);
  X(_, 0) = runif(N);
  return X;
}')
```

#### System used:
Tests were done on an HP Z400, Xeon 3.33 GHz processor, running Windows 7 Enterprise, using:


```
## R version 3.2.2 (2015-08-14)
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
## [1] data.table_1.9.4 magrittr_1.5     Rcpp_0.12.0     
## 
## loaded via a namespace (and not attached):
##  [1] knitr_1.9            splines_3.2.2        MASS_7.3-43         
##  [4] munsell_0.4.2        lattice_0.20-33      colorspace_1.2-6    
##  [7] multcomp_1.4-1       stringr_1.0.0        plyr_1.8.3          
## [10] tools_3.2.2          grid_3.2.2           gtable_0.1.2        
## [13] TH.data_1.0-6        htmltools_0.2.6      survival_2.38-3     
## [16] yaml_2.1.13          digest_0.6.8         reshape2_1.4.1      
## [19] ggplot2_1.0.1        formatR_1.1          codetools_0.2-14    
## [22] microbenchmark_1.4-2 evaluate_0.7         rmarkdown_0.5.1     
## [25] sandwich_2.3-3       stringi_0.5-5        scales_0.2.5        
## [28] mvtnorm_1.0-3        chron_2.3-47         zoo_1.7-12          
## [31] proto_0.3-10
```

