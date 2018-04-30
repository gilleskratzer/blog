+++
# Date this page was created.
date = 2016-04-27T00:00:00

# Project title.
title = "abn"

# Project summary to display on homepage.
summary = "Modelling Multivariate Data with Additive Bayesian Networks."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "banner_.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["software"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "banner_.jpg"
caption = "Nasa's Juno spacecraft: Jupiter"

+++

The study of the causes and effect of health and disease condition is a cornerstone of the epidemiology. Classical approaches, such as regression techniques have been successfully used to model the impact of health determinants over the whole population. However, recently there is a growing recognition of biological, behavioural factors, at multiple levels that can impact the health condition. These epidemiological data are, by nature, highly complex and correlated. Classical regression framework have shown limited abilities to embrace the correlated multivariate nature of high dimensional epidemiological variables. On the other hand, models driven by expert knowledge often fail to efficiently manage the complexity and correlation of the epidemiological data. Additive Bayesian Networks (ABN) addresses these challenges in producing a data selected set of multivariate models presented using Directed Acyclic Graphs (DAGs). ABN is a machine learning approach to empirically identifying associations in complex and high dimensional datasets. It is actually distributed as an R package available on CRAN.
The very natural extension to abn R package is to implement a frequentist approach using the classical GLM, then to implement classical scores as AIC, BIC etc. This extension could have many side benefits, one can imagine to boost different scores to find the best supported BN, it is easier to deal with data separation in a GLM setting, multilevel of clustering can be tackled with a mixed model setting, there exists highly efficient estimation methods for fitting GLM. More generally, if the main interest relies on the score and not on the shape of the posterior density, then a frequentist approach can be a good alternative. Surprisingly, there exists few available resources to display and analyse epidemiological data in an ABN framework. There is a need for comprehensive approach to display abn outputs. Indeed as the ABN framework is aimed for non-statistician to analyse complex data, one major challenge is to provide simple graphical tools to analyse epidemiological data. Besides that, there is a lack of resource addressing which class of problem can be tackle using ABN method, in terms of sample size, number of variables, expected density of the learned network.


 [![](https://cranlogs.r-pkg.org/badges/abn)](https://cran.rstudio.com/web/packages/abn/index.html)