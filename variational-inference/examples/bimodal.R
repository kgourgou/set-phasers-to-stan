# Simple example 2
# Bi-modal distribution 

setwd("~/Dropbox/UMassCourses/set-phasers-to-stan/variational-inference/examples/")

library(ggplot2)
library(rstan)

# multimodal by a mixture of gaussians
N <- 1000
k <- 2
y1 <- rnorm(N)
y2 <- log(100) + rnorm(N)
mix <- rbinom(N,size=1, prob=0.4)
y <- (1-mix)*y1 + mix*y2

qplot(y, geom="density")


m <- stan_model(file="gaussian.stan")
f <- vb(m)

params<-extract(f,pars=c("mu","sigma"))

inf_mu <- mean(params$mu)
inf_sigma <- mean(params$sigma)

Y <- seq(inf_mu-7,inf_mu+7, length.out = 100 )
Y_Gaussian_model <- dnorm(Y,mean=inf_mu, sd=inf_sigma)

print(f)


ggplot() + 
  geom_line(aes(x=Y, y=Y_Gaussian_model, color="Y_Gaussian_model", linetype="Y_Gaussian_model")) +
  geom_density(aes(x=y)) +
  theme_bw()

