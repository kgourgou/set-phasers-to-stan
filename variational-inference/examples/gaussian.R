# Simple example 1 


setwd("~/Dropbox/UMassCourses/set-phasers-to-stan/variational-inference/examples/")

library(ggplot2)
library(rstan)

# Normally distributed data
N <- 1000
y <- sqrt(2)*rnorm(N)+10


m <- stan_model(file="gaussian.stan")
f <- vb(m)

params<-extract(f,pars=c("mu","sigma"))

inf_mu <- mean(params$mu)
inf_sigma <- mean(params$sigma)

Y <- seq(inf_mu-2,inf_mu+2, length.out = 100 )
Y_Gaussian_model <- dnorm(Y,mean=inf_mu, sd=inf_sigma)
Y_Gaussian_exact <- dnorm(Y,mean=0, sd=1)

print(f)


## Plot those above at the same graph