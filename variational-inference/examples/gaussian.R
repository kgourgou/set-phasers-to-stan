# setwd("~/Dropbox/UMassCourses/set-phasers-to-stan/variational-inference/examples/")
# Simple example 1

library(ggplot2)
library(rstan)

# Normally distributed data
N <- 1000
y <- sqrt(2)*rnorm(N)+10

m <- stan_model(file="gaussian.stan")
f <- vb(m,tol_rel_obj=0.00001,eval_elbo=10)

params<-extract(f,pars=c("mu","sigma"))

inf_mu <- mean(params$mu)
inf_sigma <- mean(params$sigma)

Y <- seq(inf_mu-2,inf_mu+2, length.out = 100 )
Y_Gaussian_model <- dnorm(Y,mean=inf_mu, sd=inf_sigma)
Y_Gaussian_exact <- dnorm(Y,mean=10, sd=sqrt(2))


## Plot those above at the same graph
ggplot() +
    geom_line(aes(x=Y,
                  y=Y_Gaussian_model,
                  color="Y_Gaussian_model",
                  linetype="Y_Gaussian_model")) +
    geom_line(aes(x=Y,
                  y=Y_Gaussian_exact,
                  color="Y_Gaussian_exact",
                  linetype="Y_Gaussian_exact")) +
    scale_y_continuous("Density") +
    scale_color_discrete("") +
    scale_linetype_discrete("") +
    theme_bw()
