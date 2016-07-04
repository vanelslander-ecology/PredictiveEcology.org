---
layout: post
title: How to start using Compute Canada cluster with R and SpaDES.
author: Eliot McIntire
date: July 4, 2016
comments: true
tags: [supercomputer, HPC, Grex, Simulation, R]
---

Is your R script taking too long?  Do you find yourself rerunning things over and over? Are you using loops or lapply and think that these are slowing you down? In many cases, working with parallel computing in R can help solves these problems. Working on a super computer with 100s or 1000s of nodes can potentially help a lot.

These instructions are for Compute Canada super computing network, and specifically, the Grex machine on the WestGrid network, but they should work with some minor modifications for any super computing cluster.
 
## Create an account on your super computing network

For Compute Canada, that is [https://www.computecanada.ca/research-portal/account-management/apply-for-an-account/](here).

