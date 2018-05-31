+++
# Date this page was created.
date = 2016-04-27T00:00:00

# Project title.
title = "varrank"

# Project summary to display on homepage.
summary = "Variable ranking for large epidemiological datasets."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "varrank_banner.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["software"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "varrank_banner.jpg"
caption = "Mount Fuji"

+++
A common challenge encountered when working with high dimensional datasets is that of variable selection. All relevant confounders must be taken into account to allow for unbiased estimation of model parameters, while balancing with the need for parsimony and producing interpretable models. This task is known to be one of the most controversial and difficult tasks in epidemiological analysis. 

Variable selection approaches can be categorized into three broad classes: filter-based methods, wrapper-based methods, and embedded methods. They differ in how the methods combine the selection step and the model inference. An appealing filter approach is the minimum redundancy maximum relevance (mRMRe) algorithm. The purpose of this heuristic approach is to select the most relevant variables from a set by penalising according to the amount of redundancy variables share with previously selected variables. In epidemiology, the most frequently used approaches to tackle variable selection based on modelling use goodness-of fit metrics. The paradigm is that important variables for modelling are variables that are causally connected and predictive power is a proxy for causal links. On the other hand, the mRMRe algorithm aims to measure the importance of variables based on a relevance penalized by redundancy measure which makes it appealing for epidemiological modelling.

varrank has a flexible implementation of the mRMRe algorithm which perform variable ranking based on mutual information. The package is particularly suitable for exploring multivariate datasets requiring a holistic analysis. The two main problems that can be addressed by this package are the selection of the most representative variables for modelling a collection of variables of interest, i.e., dimension reduction, and variable ranking with respect to a set of variables of interest.

 [![](https://cranlogs.r-pkg.org/badges/varrank)](https://cran.rstudio.com/web/packages/varrank/index.html)

