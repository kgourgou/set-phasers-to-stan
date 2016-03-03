# Load Stan from CRAN
library(rstan)
set.seed(1)

N <- 100
M <- 1

x <- matrix(sample(0:10, N*M, replace = T), nrow = N, ncol=M)
y <- x[,1] + rnorm(N)


# ... and convert it to a named list (careful with types here)
# stan_data <- list(N=N, M=M, y=y, x=x)

fitted.model <- stan(file = 'regression-example/model.stan',
                     model_name='Multi_Reg',
                     # data=stan_data,
                     iter=5000, chains=2)

plot(fitted.model)
