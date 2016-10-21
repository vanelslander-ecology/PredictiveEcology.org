---
layout  : post
title   : Rmarkdown in a scientific workflow
author  : Alex Chubaty
date    : October 21, 2016
tags    : [reproducible research, R]
---

Using [`Rmarkdown`](http://rmarkdown.rstudio.com/) with [Rstudio](https://www.rstudio.com/products/rstudio) and for all stages of my scientific projects has been a remarkable shift in how my work gets done!
There are so many advantages to this type of workflow, not least of which are reproducibility and transparency (both are crucial for scientists as well as public servants).
I've been using this approach as much as possible recently, and I'm quite happy with it.
The entire process can be done using `Rmarkdown` etc. but there are still a few challenges which I'll touch on below.

## What is `Rmarkdown`?

The folks behind the RStudio IDE have completely changed how a majority of R users work with and program in R.
Not only have they provided an exceptional IDE for working with and debugging R code, Rstudio also includes a number of important features that facilitate project management, package management, interactive graphics, and dynamic document generation.

This is where `Rmarkdown` come in.

`Rmarkdown` documents allow you to combine your "data, code, and narrative" in a single file, similar to project notebooks in MatLab, Mathematica, and others.
This facilitates the integration of project development, data analyses, and report writing.
Each of the components of your project can be tied together and, crucially, easily rerun when data are updated or changes need to be made to other steps in the research workflow.

`Rmarkdown` files follow the [`markdown`](https://daringfireball.net/projects/markdown/
) mark up language, which is designed to be both human and machine readable.
Although you edit `.Rmd` files in text form, the files are converted to their 'final' format (`.pdf`, `.html`, etc.) using the [`knitr`](yihui.name/knitr/
) package and [`pandoc`](pandoc.org).
It is very easy to incorporate text, images, equations, code, etc. into `.Rmd` files which can then be rendered in a wide variety of file formats.

Importantly, because`Rmarkdown` files (`.Rmd`) are text files, they are easily incorporated into a `git` or other version control system.
This further enhances the utility of `Rmarkdown` for scientific projects because with version control, one can see the evolution of a project from start to finish.

## Using `Rmarkdown` throughout the scientific workflow

### Initial project conception

Most (all?) researchers maintain a project notebook of some type to track the development of theirs projects.
These notebooks are crucial for accountability and tracking project history and progress, and are invaluable references during the final stages of a project (*i.e.*, writing manuscripts).
Text, code, equations, and data can all be maintained in an `.Rmd` file.
Handwritten project sketches and notes can also be digitized for inclusion.

### Data analyses

This is where most discussion about using `Rmarkdown` occurs.
R code is run and the output of analyses can be directly inserted into the text narrative, as inline results, separate code blocks, tables, and figures.
This makes rerunning things a breeze, and can be used to generate dynamic reports.

Using version control, you don't have to worry about maintaining old code and commenting it out as the project matures -- just delete it (it's still available in the version control history).
This means you can always keep your `.Rmd` files up to date and ready to share with collaborators (or reviewers).

One important additional note: `knitr` supports caching of `Rmarkdown` code blocks, which means you don't need to rerun all analyses when updating a report.

### Collaboration

A use a collaborative workflow using R, `Rmarkdown`, and [GitHub](https://github.com).
However, most of my colleagues do not.
This has been the most difficult challenge to overcome.
How do I convince people to 1) adopt an open and reproducible workflow (*e.g.*, use `Rmarkdown` instead of MS Word), and 2) use version control (*i.e.*, `git`)?

In many cases, after spending some time with my colleagues to highlight the advantages and teach them how to use the tools, they are happily converted.
However, even with most collaborators adopting this workflow, if even a single one doesn't it can add additional work to my plate.

Currently, I'll push changes to the project's GitHub repository, usually tagging my collaborators in the relevant commit messages for them to take a look.
I'll also send an email (with the current version attached) and solicit feedback via GitHub.

For my collaborators using GitHub regularly, it's easy -- they make changes, we merge, and rebuild the documents as needed.
But I still get emails back with a modified / annotated version of the file I sent out, which means I need to be the one to manually make changes and push them to GitHub.
Getting (late) feedback on an old version of a draft sent out by email when the current GitHub version has seen substantial changes is even more frustrating to deal with.
Annoying, but not the end of the world.

I'm not discouraged!
The time spend incorporating changes is mostly about copy-paste into the current version -- no different than my old workflow using MS Word.
I think the time saved in other parts of the workflow make up for the additional time spent here.

I'm looking forward to more of my colleagues using `.Rmd` files, though I note that currently there is no good way of annotating documents.
One method is to add text directly, which appears in the final rendered document.
Another is to use HTML-style comments (`<!-- comments go here -->`) in the `.Rmd` file which will not appear in the final rendered document.

### Publication

This one is improving everyday.
Basic article publication tools are already included with Rstudio and `RMarkdown` (including [citations](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)); however, for more advanced formatting there are other packages like [`rticles`](https://cran.r-project.org/package=rticles) (which I'm using for my current manuscripts) and [`bookdown`](https://bookdown.org/) for book formatting.
As a fallback, you can adopt HTML and LaTeX markup in your `.Rmd` files, and use additional CSS or LaTeX templates as needed.

Owing to the long history of TeX in scientific publications, most journals not only accept `.tex` file submissions but also provide the necessary templates (some of these are included with the `rticles` package), and citation style (`.csl`) files can be downloaded from [https://www.zotero.org/styles](https://www.zotero.org/styles).

### Communication

#### Email

One of the major selling points of markdown is that it's a human-readable markup language (contrast against LaTeX or HTML).
In principle, you can use markdown formatting for emails but most email programs will render them as text unless your recipient has a markdown converter (there are a few for *e.g.*, Gmail).

#### Blogs

Most blogging platfroms support markdown (by default or with additional plugins).
This blog renders the markdown files (generated from `.Rmd` files) we upload into HTML format with all the appropriate syntax highlighting, etc.
It's a phenomenal way to create content locally and render the results reliably on a blog.

## Final thoughts

How successful have I been?
I firmly believe that adopting this new workflow has improved productivity as well as the calibre of the work I do.
Especially over the medium to long term.
Additionally, adopting a reproducible workflow not only improves scientific transparency and accountability, but it has enhanced the *reusability* of my work.
Copying and pasting code from old projects actually works the first time -- because I'm tracking these old projects using 'living documentation' that includes everything needed to run the code again: data, scripts, and associated explanations.

It's worth the effort, and I encourage you to start using `Rmarkdown`.

## Further reading

Gandrud, C. (2015). Reproducible Research with R and RStudio, 2nd edn. Chapman and Hall/CRC Press. https://github.com/christophergandrud/Rep-Res-Book

Ram, K. (2013). Git can facilitate greater reproducibility and increased transparency in science. Source Code for Biology and Medicine, 8(1), 7. http://doi.org/10.1186/1751-0473-8-7

Wilson, G., Aruliah, D. A., Brown, C. T., Chue Hong, N. P., Davis, M., Guy, R. T., … Wilson, P. (2014). Best practices for scientific computing. PLoS Biology, 12(1), e1001745. http://doi.org/10.1371/journal.pbio.1001745
