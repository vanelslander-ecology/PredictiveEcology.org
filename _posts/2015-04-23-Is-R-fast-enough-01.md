
There have been many people, including ourselves, who have asked, "Is R faster enough for simulation modeling". In other words, if we spend a lot of time building forecasting models, are we going to eventually be limited by an inefficient language?  

After years of working with R as a data analysis and manipulation tool, I wasn't convinced that R was fast enoug. I realize now that was mostly because of what we see and hear on the internet (e.g., see table in http://julialang.org). So, I started benchmarking R with a series of low and high level functions. This is part 1 of a multi-part series of posts about this benchmarking experiment with R in the coming weeks. 

The objective of this experiment is to show some speed comparisons between R and other languages and software, including C++ and GIS software. Clearly this is NOT a comparison between R and, say, C++, because many of the functions in R are written in C++ and are wrapped in R. But, if simple R functions are fast, then we can focus our time on more complex things needed for simulation and science.

**Answer:** *R is more than fast enough!*

The take home messages for the whole exercise are these: 

1. built-in R functions (written in R or C++ or any other language) are often faster than ad hoc C++ functions.

2. most built-in R functions *must* to be used in a vectorized way to achieve these speeds, avoiding loops unless it is strictly necessary to keep the sequence (though see the data.table package)

3. there are often different ways to do the same thing in R; some are *much* faster than others (see following weeks posts). Use the Primitives where possible (`nms <- names(methods:::.BasicFunsList)`)

I will start with a fairly basic low level function, the "mean"

### Mean
For the mean, I show two different C++ versions. The R function, "mean" is somewhat slower (1/2x), but the colMeans function and calling sum/length directly are often faster than either C++ function.







```r
library(rbenchmark)
x <- runif(1e7)
x1 = matrix(x, ncol=1)
m=list()
mb <- benchmark(m[[1]]<-meanC1(x), m[[2]]<-meanC2(x), m[[3]]<-mean(x), 
                m[[4]]<-mean.default(x), m[[5]]<-sum(x)/length(x), 
                m[[6]]<- .Internal(mean(x)), m[[7]]<-colMeans(x1),
                replications=200L, columns=c("test", "elapsed", "relative"), order="relative")
print(mb)
```

```
##                           test elapsed relative
## 1          m[[1]] <- meanC1(x)    2.15    1.000
## 7       m[[7]] <- colMeans(x1)    2.16    1.005
## 5   m[[5]] <- sum(x)/length(x)    2.24    1.042
## 6 m[[6]] <- .Internal(mean(x))    4.38    2.037
## 4    m[[4]] <- mean.default(x)    4.45    2.070
## 3            m[[3]] <- mean(x)    4.47    2.079
## 2          m[[2]] <- meanC2(x)   13.41    6.237
```

```r
# Test that all did the same thing
all(sapply(1:6, function(y) all.equal(m[[y]],m[[y+1]])))
```

```
## [1] TRUE
```

### Conclusions

The fastest way to calculate the mean for long vectors (1e7) is to use `colMeans(x)`, which is one of many R functions written for speed. It is faster than a simple, but ad hoc, C++ example. 

### Next time

We will redo the fibinacci series, a common low level benchmarking test that shows R to be slow.  But it turns out to be a case of bad coding...

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

cppFunction('double meanC2(NumericVector x) {
  int n = x.size();
  double y = 0;

  for(int i = 0; i < n; ++i) {
    y += x[i] / n;
  }
  return y;
}')
```

### System used:
Tests are done on an HP Z400, Xeon 3.33 GHz processor, running Windows 7 Enterprise, using:

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
## [1] Rcpp_0.11.5          microbenchmark_1.4-2
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.8     MASS_7.3-40      grid_3.2.0       plyr_1.8.1      
##  [5] gtable_0.1.2     formatR_1.1      evaluate_0.6     scales_0.2.4    
##  [9] ggplot2_1.0.1    reshape2_1.4.1   rmarkdown_0.5.1  proto_0.3-10    
## [13] tools_3.2.0      stringr_0.6.2    munsell_0.4.2    yaml_2.1.13     
## [17] colorspace_1.2-6 htmltools_0.2.6  knitr_1.9
```

