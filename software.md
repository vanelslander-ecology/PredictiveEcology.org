---
layout: page
title: Software
permalink: /software/
---

## R packages

### [`SpaDES`](http://SpaDES.PredictiveEcology.org)

#### Develop and Run Spatially Explicit Discrete Event Simulation Models

Easily implement a variety of simulation models, with a focus on spatially explicit models. These include raster-based, event-based, and agent-based models. The core simulation components are built upon a discrete event simulation framework that facilitates modularity, and easily enables the user to include additional functionality by running user-built simulation modules. Included are numerous tools to rapidly visualize raster and other maps.

View on [CRAN](https://cran.r-project.org/package=SpaDES); [GitHub](https://github.com/PredictiveEcology/SpaDES); [Website](http://SpaDES.PredictiveEcology.org)

### [`fpCompare`](https://cran.r-project.org/package=fpCompare)

#### Reliable Comparison of Floating Point Numbers

Comparisons of floating point numbers are problematic due to errors associated with the binary representation of decimal numbers. Despite being aware of these problems, people still use numerical methods that fail to account for these and other rounding errors (this pitfall is the first to be highlighted in Circle 1 of Burns (2012) [The R Inferno](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf)). This package provides new relational operators useful for performing floating point number comparisons with a set tolerance.

View on [CRAN](https://cran.r-project.org/package=fpCompare);  [GitHub](https://github.com/PredictiveEcology/fpCompare)

### [`lazyR`](https://github.com/PredictiveEcology/lazyR)

#### Using lazy load databases for R objects

An R package for stashing objects in lazy load databases, analogous to lazy loaded packages. This uses the archivist package for a lot of the back end, but allows loading to be lazy. This means that the objects aren't actually loaded into RAM until they are used for the first time.

View on [GitHub](https://github.com/PredictiveEcology/lazyR)

### [`NetLogoR`](http://NetLogoR.PredictiveEcology.org)

#### A port of NetLogo functions and language to R

`NetLogoR` is an R package which aims to help translating agent-based models built in NetLogo ([Wilensky, 1999](http://ccl.northwestern.edu/netlogo/)) into R or help directly with creating new agent-based models in R following the NetLogo framework.

`NetLogoR` provides the necessary [NetLogo's primitives](https://ccl.northwestern.edu/netlogo/docs/dictionary.html) as well as complementary functions to build agent-based models.
A programming guide derived from the [NetLogo’s Programming Guide](https://ccl.northwestern.edu/netlogo/docs/programming.html) is available. 

This package is under construction and therefore function errors and mismatches with the documentation may occur.

View on [GitHub](https://github.com/PredictiveEcology/NetLogoR)

