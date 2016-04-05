# second try with the bimodal 
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


m <- stan_model(file="bimodal.stan")
f <- vb(m)

params <- extract(f, pars=c("theta[1]","theta[2]","mu[1]","mu[2]"))



Y <- seq(-10,10, length.out = 100 )
Y_model <- 0.57*dnorm(Y,mean=-0.02) + 0.43*dnorm(Y, mean=4.54)


ggplot() + 
  geom_line(aes(x=Y, y=Y_model, color="Y_model", linetype="Y_model")) +
  geom_density(aes(x=y)) +
  theme_bw()
