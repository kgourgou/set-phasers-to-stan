## Homework 5
## by Kostis, Stephen, and Jie
## Assigned: March 15, 2016

## read in Stan library
library(rstan)
library(dplyr)
library(ggplot2)
rstan_options(auto_write=TRUE)

# set seed
set.seed(1)
setwd() ## this needs to be filled in with your working directory

## to run the Stan code, you need to either re-write your homework 4 R script or read in an output file from that assignment

## make sure that the time is assigned to "t", the size of the population over time is assigned to "x", and the length of those vectors is assigned to "N"

tic <- Sys.time()
stan_fit <- stan(file = 'poisson-model.stan',
                 data = , #either put the name of your list here or delete this (if data is in local environment) 
                 iter = 10000,
                 chains = 4)
toc <- Sys.time()
toc-tic

## estimations and output
print(stan_fit)
plot(stan_fit)
pairs(stan_fit)

m <- as.matrix(stan_fit) %>%
    as.data.frame() %>%
    mutate(chain=rep(seq(1,4),each=5000),
           iteration=rep(seq(1,5000),4))
qplot(data=m, x=iteration, y=alpha, color=as.factor(chain), geom="line", alpha=0.6) +
    theme_bw()
