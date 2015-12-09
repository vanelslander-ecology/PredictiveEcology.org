---
layout: post
title: R Web App Development, Deployment, and Distribution
author: Olivia Sung
date: Dec 8, 2015
tags: [R]
comments: true
---

---
As `R` language is becoming popular among scientists to build simple we bapplication along simple integration with `RShiny`, `R` web applications are being created at a fast rate. `RShiny` package is not only easy to integrate but also provides a lightweight user interface that is pleasing to the eyes.
Compared to standard web application, how is `R` application development different? 
What is the process to deploy and distribute `R` web applications?
---

### Development

While web development can be done in many different environments, [RStudio](https://www.rstudio.com/) is widely used to develop `R` applications.

### Deployment and Distribution

For light `R` application that only needs a local deployment, `R` portable and web browser portable such as `Chrome` applications can be used. It does not require as much performance on end user's side and overall distribution will result in smaller files.

  *Refer to [this](http://www.r-bloggers.com/deploying-desktop-apps-with-r/) blog post by Lee Peng about Deploying Desktop Apps with R using portable apps*

`shinyapps.io` is a platform as a service (PaaS) for hosting `Shiny` web applications.

  *Refer to [this](http://shiny.rstudio.com/articles/shinyapps.html) where you can discover how to get started with `shinyapps.io`*

If you want an ultimate experience of `RShiny`, there is also a paid service [RShiny Pro](https://www.rstudio.com/products/shiny-server-pro/), where you can host your application on `Shiny` server. 
There are a few useful functionalities that comes with the service such as 

- User Access Control
- Monitor application performance 
- Monitor resource utilization 

However service is not cheap so if you have extra cash lying around, this would be a quick and easy way to host your application!





