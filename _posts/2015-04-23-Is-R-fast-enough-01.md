---
layout: post
title: Is R Fast Enough? - Part 1 - "The Mean"
author: Eliot McIntire
date: April 23, 2015
tags: [R, benchmark]
---

There have been many people, including ourselves, who have asked, "Is R fast enough for simulation modeling?". In other words, can R handle everything we throw at it for simulation modeling?  Low level functions, high level functions, GIS, data wrangling etc... 

After years of working with R as a data analysis and manipulation tool, we weren't convinced that R was fast enough. We realize now that was mostly because of what we see and hear on the internet (e.g., see table in [julialang.org](https://julialang.org)). So, we started benchmarking R with a series of low and high level functions. This is part 1 of a multi-part series of posts about this benchmarking experiment with R in the coming weeks. 

The objective of this experiment is to show some speed comparisons between R and other languages and software, including C++ and GIS software. Clearly this is NOT a comparison between R and, say, C++, because many of the functions in R are written in C++ and are wrapped in R. But, if simple R functions are fast, then we can focus our time on more complex things needed for simulation and science.

*So, is R fast enough?* 

*Answer:* **R is more than fast enough!**

We will start with a fairly basic low level function, the "mean"...

### Mean
For the mean, we show two different C++ versions. The R function, `mean` is somewhat slower (about half, but it does more things than just calculate the mean), but the `colMeans(x)` and calling the primitives directly with `sum(x)/length(x)` are as fast or  faster than the fastest C++ function we can write.







```r
x <- runif(1e6)
x1 = matrix(x, ncol=1)
m=list()
benchmark(m[[1]]<-meanC1(x), m[[2]]<-meanC2(x), m[[3]]<-mean(x), 
                m[[4]]<-mean.default(x), m[[5]]<-sum(x)/length(x), 
                m[[6]]<- .Internal(mean(x)), m[[7]]<-colMeans(x1),
                replications=2000L, columns=c("test", "elapsed", "relative"), order="relative")
```

```
##                           test elapsed relative
## 1          m[[1]] <- meanC1(x)    1.86    1.000
## 5   m[[5]] <- sum(x)/length(x)    1.90    1.022
## 7       m[[7]] <- colMeans(x1)    1.94    1.043
## 4    m[[4]] <- mean.default(x)    3.81    2.048
## 6 m[[6]] <- .Internal(mean(x))    3.81    2.048
## 3            m[[3]] <- mean(x)    3.82    2.054
## 2          m[[2]] <- meanC2(x)   13.42    7.215
```

```r
# Test that all did the same thing
all(sapply(1:6, function(y) all.equal(m[[y]],m[[y+1]])))
```

```
## [1] TRUE
```

#### Conclusions

*YES! R is more than fast enough*. But there is more to come... For the mean, the fastest way to calculate it for sizeable numeric vectors (1e6) is to use `sum(x)/length(x)`, `colMeans(x)`, or the efficient version of the C++ code `meanC1`. But, it is important to note that even the worst R version is better than an apparently minor coding decision in the second C++ version (`meanC2` divides by N every time). 

#### Next time

We will redo the Fibonacci series, a common low level benchmarking test that [shows R to be slow](https://julialang.org).  But it turns out to be a case of bad coding...

#### Take home message

The take home messages for the whole exercise are these: 

  1. built-in R functions (written in R or C++ or any other language) are often faster than ad hoc C++ functions, particularly if they are built with speed in mind (like `colMeans`).

  1. most built-in R functions *must* to be used in a vectorized way to achieve these speeds, avoiding loops unless it is strictly necessary to keep the sequence (though see the data.table package)

  1. there are often different ways to do the same thing in R; some are *much* faster than others (see following weeks posts). Use the Primitives where possible (`names(methods:::.BasicFunsList)`)

--------------------

#### Functions used

The C++ functions that were used are:



```r
cppFunction('double meanC1(NumericVector x) {
  int n = x.size();
  double total = 0;

  for(int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total / n;
}')

# inefficient because the /n is done within the loop
cppFunction('double meanC2(NumericVector x) {
  int n = x.size();
  double y = 0;

  for(int i = 0; i < n; ++i) {
    y += x[i] / n;
  }
  return y;
}')
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
## [1] Rcpp_0.11.5      rbenchmark_1.0.0
## 
## loaded via a namespace (and not attached):
## [1] formatR_1.1     tools_3.2.0     htmltools_0.2.6 yaml_2.1.13    
## [5] rmarkdown_0.5.1 knitr_1.9       stringr_0.6.2   digest_0.6.8   
## [9] evaluate_0.6
```
