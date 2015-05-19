---
layout: page
title: Benchmarking
permalink: /benchmarking/
hide: true
---

### Introduction

We started benchmarking R with a series of low and high level functions.
The objective of this experiment is to show some speed comparisons between R and other languages and software, including C++ and GIS software.
Clearly this is NOT a comparison between R and, say, C++, because many of the functions in R are written in C++ and are wrapped in R.
But, if simple R functions are fast, then we can focus our time on more complex things needed for simulation and science.

*So, is R fast enough?* 

*Answer:* **R is more than fast enough!**

### Benchmarking posts

<ul class="posts">
{% for post in site.tags.benchmark limit: 20 %}
  <div class="post_info">
    <li>
         <a href="{{ post.url }}">{{ post.title }}</a>
         <span>({{ post.date | date:"%Y-%m-%d" }})</span>
    </li>
    </div>
  {% endfor %}
</ul>
