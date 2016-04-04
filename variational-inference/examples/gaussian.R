library(ggplot2)
library(rstan)

# generate data following normal distribution
set.seed(1)

N <- 100
M <- 1

x <- rnorm(N)

# quick histogram
qplot(y, geom="histogram")