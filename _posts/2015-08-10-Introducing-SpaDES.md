---
layout: post
title: 'Introducing `SpaDES`: R Package for Spatial Discrete Event Simulation'
date: May 22, 2015
author: Alex Chubaty and Eliot McIntire
tags: [R, SpaDES]
---

> v1.0.1 is now available on [CRAN](cran.r-project.org/package=SpaDES)!

Building spatial simulation models often involves reusing various model components, often having to re-implement similar functionality in multiple simulation frameworks (*i.e*, in different programming languages).
When various components of a simulation model become fragmented across multiple platforms, it becomes increasingly difficult to link these various components, and often solutions for this problem are idiosyncratic and specific to the model being implemented.
As a result, developing general insights into complex computational models has, in the field of ecology at least, been hampered by modellers' typically developing models from scratch (Thiele, 2015).

`SpaDES` is a generic simulation platform that can be used to create new model components quickly.
It also provides a framework to link with existing simulation models, so that an already well described and mature model, *e.g.*, Landis-II (Scheller, 2007), can be used with *de novo* components.
Alternatively one could use several *de novo* models and several existing models in combination.
This approach requires a platform that allows for modular reuse of model components (herein called 'modules') as hypotheses that can be evaluated and tested in various ways, as advocated by Thiele (2015).

`SpaDES` makes it easy to implement a variety of simulation models including raster-based, event-based, and agent-based models. The core simulation components are built upon a discrete event simulation framework that facilitates modularity, and easily enables the user to include additional functionality by running user-built simulation modules. Included are numerous tools to rapidly visualize raster and other maps.

When beginning development of this package, we sought a general simulation platform at least the following characteristics:

1. Allow rapid building of models of a wide diversity of types (*e.g.*, agent-based models, raster models, differential equation models);
2. Run faster and more memory efficiently than current systems for doing similar things (*e.g.*, NetLogo (Wilensky, 1999), SELES (Fall & Fall, 2001));
3. Use a platform that already has strong data analysis, manipulation, and visualization capacities;
4. Be open source, but also make it as easy as possible for many people to easily contribute modules and code;
5. Be easy to use for a large number of scientists who aren't formally trained as computer programmers or have limited programming experience;
6. Should be built around modularity so that models can be seen as modules that are easily replaceable, not just 'in theory' replaceable;
7. Allow tight coupling between data and model simulations so that the entire work flow from raw data to result generation or even report generation is not actually something that one has to redesign every time there is a new data set.

We selected `R` as the system within which to build `SpaDES`. `R` is currently the *lingua franca* for scientific data analysis. 
This means that anything developed in `SpaDES` is simply `R` code and can be easily shared with journals and the scientific community. 
We can likewise leverage `R`'s strengths as a data platform, its excellent visualization and graphics, its capabilities to run external code such as `C`/`C++` and easily interact external software such as databases, and its abilities for high performance computing.
`SpaDES` therefore doesn't need to implement all of these from scratch, as they are achievable with already existing `R` packages.

## Getting started

### Installation

```r
# install `SpaDES` from CRAN
install.packages("SpaDES")


# install suggested package `fastshp`
#  (requires development tools, e.g. Rtools)
install.packages("fastshp", repos="http://rforge.net", type="source")
```

### Documentation

**Vignettes:**

```r
browseVignettes(package="SpaDES")
```

**Website:**

[http://SpaDES.PredictiveEcology.org](http://SpaDES.PredictiveEcology.org)

**Wiki:**

[https://github.com/PredictiveEcology/SpaDES/wiki](https://github.com/PredictiveEcology/SpaDES/wiki)

## Reporting bugs

Contact us via the package GitHub site: [https://github.com/PredictiveEcology/SpaDES/issues](https://github.com/PredictiveEcology/SpaDES/issues).

## References

Fall, A., & Fall, J. (2001). A domain-specific language for models of landscape dynamics. Ecological Modelling, 141, 1–18.

Scheller, R. M., Domingo, J. B., Sturtevant, B. R., Williams, J. S., Rudy, A., Gustafson, E. J., & Mladenoff, D. J. (2007). Design, development, and application of LANDIS-II, a spatial landscape simulation model with flexible temporal and spatial resolution. Ecological Modelling, 201, 409–419. doi:10.1016/j.ecolmodel.2006.10.009

Thiele, J. C., & Grimm, V. (2015). Replicating and breaking models: good for you and good for ecology. Oikos. doi:10.1111/oik.02170

Wilensky, U. (1999). NetLogo. Evanston, IL: Center for Connected Learning and Computer-Based Modeling, Northwestern University. http://ccl.northwestern.edu/netlogo
