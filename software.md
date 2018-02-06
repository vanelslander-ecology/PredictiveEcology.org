---
layout: page
title: Software
permalink: /software/
---

## R packages

### [`SpaDES`](http://spades.predictiveecology.org)

#### Develop and Run Spatially Explicit Discrete Event Simulation Models

Metapackage for implementing a variety of event-based models, with a focus on spatially explicit models.
These include raster-based, event-based, and agent-based models.
The core simulation components (provided by [`SpaDES.core`](http://spades-core.predictiveecology.org/)) are built upon a discrete event simulation (DES) framework that facilitates modularity, and easily enables the user to include additional functionality by running user-built simulation modules (see also [`SpaDES.tools`](http://spades-tools.predictiveecology.org/)).
Included are numerous tools to visualize rasters and other maps (via [`quickPlot`](http://quickplot.predictiveecology.org/)), and caching methods for reproducible simulations (via [`reproducible`](http://reproducible.predictiveecology.org/)).
Additional functionality is provided by the [`SpaDES.addins`](http://spades-addins.predictiveecology.org/) and [`SpaDES.shiny`](http://spades-shiny.predictiveecology.org/) packages.

View on [CRAN](https://cran.r-project.org/package=SpaDES); [GitHub](https://github.com/PredictiveEcology/SpaDES); [Website](http://spades.predictiveecology.org)

### [`quickPlot`](http://quickplot.predictiveecology.org)

#### A System of Plotting Optimized for Speed and Modularity

A high-level plotting system, built using `grid` graphics, that is optimized for speed and modularity.
This has great utility for quick visualizations when testing code, with the key benefit that visualizations are updated independently of one another.

View on [CRAN](https://cran.r-project.org/package=quickPlot); [GitHub](https://github.com/PredictiveEcology/quickPlot); [Website](http://quickplot.predictiveecology.org)

### [`reproducible`](http://reproducible.predictiveecology.org)

#### A set of tools for R that enhance reproducibility beyond package management.

Built on top of `git2r` and `archivist`, this package aims at making high-level, robust, machine and OS independent tools for making deeply reproducible and reusable content in R.
This extends beyond the package management utilites of `packrat` and `checkpoint` by including tools for caching and accessing GitHub repositories.

View on [CRAN](https://cran.r-project.org/package=reproducible); [GitHub](https://github.com/PredictiveEcology/reproducible); [Website](http://reproducible.predictiveecology.org/)

### [`fpCompare`](http://fpcompare.predictiveecology.org)

#### Reliable Comparison of Floating Point Numbers

Comparisons of floating point numbers are problematic due to errors associated with the binary representation of decimal numbers. Despite being aware of these problems, people still use numerical methods that fail to account for these and other rounding errors (this pitfall is the first to be highlighted in Circle 1 of Burns (2012) [The R Inferno](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf)). This package provides new relational operators useful for performing floating point number comparisons with a set tolerance.

View on [CRAN](https://cran.r-project.org/package=fpCompare);  [GitHub](https://github.com/PredictiveEcology/fpCompare); [Website](http://fpcompare.predictiveecology.org/)

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

View on [CRAN](https://cran.r-project.org/package=NetLogoR); [GitHub](https://github.com/PredictiveEcology/NetLogoR); [Website](http://NetLogoR.predictiveecology.org/)
