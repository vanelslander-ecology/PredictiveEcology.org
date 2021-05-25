---
layout: post
title: "SpaDES packages archived on CRAN"
author: "Alex Chubaty"
date: "May 25, 2021"
tags: [R, SpaDES]
---

Apologies to anyone trying to install `reporducible`, `NetLogoR`, and any `SpaDES` packages from CRAN.
We had one of our dependencies (`reproducible`) temporarily archived, but we are in the process of submitting a fixed version, which should restore the other packages.

In the meantime, installing the GitHub versions of `reproducible`, followed by any other packages should get you back to a working version.

```r
remotes::install_github("PredictiveEcology/reproducible")
remotes::install_github("PredictiveEcology/SpaDES.core")
```
