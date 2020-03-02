+++
# Date this page was created.
date = 2019-04-27T00:00:00

# Project title.
title = "mcmcabn"

# Project summary to display on homepage.
summary = "Structural MCMC Sampler for DAGs."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "soft.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["software"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "soft.jpg"
caption = "Computing cluster"

+++

Flexible implementation of a structural MCMC sampler for Directed Acyclic Graphs (DAGs). It supports the new edge reversal move from Grzegorczyk and Husmeier (2008) <doi:10.1007/s10994-008-5057-7> and the Markov blanket resampling from Su and Borsuk (2016) <http://jmlr.org/papers/v17/su16a.html>. It supports three priors: a prior controlling for structure complexity from Koivisto and Sood (2004) <http://dl.acm.org/citation.cfm?id=1005332.1005352>, an uninformative prior and a user-defined prior. The three main problems that can be addressed by this R package are selecting the most probable structure based on a cache of pre-computed scores, controlling for overfitting, and sampling the landscape of high scoring structures. It allows us to quantify the marginal impact of relationships of interest by marginalizing out over structures or nuisance dependencies. Structural MCMC seems an elegant and natural way to estimate the true marginal impact, so one can determine if it's magnitude is big enough to consider as a worthwhile intervention.




 [![](https://cranlogs.r-pkg.org/badges/mcmcabn)](https://cran.rstudio.com/web/packages/mcmcabn/index.html)