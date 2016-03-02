# Load Stan from CRAN
library(rstan)

N <- 100
M <- 1

x <- seq(0,10,length.out = N)
y <- x + rnorm(N)


# ... and convert it to a named list (careful with types here)
stan_data <- list(N=N, M=M, y=y, x=x)

fitted.model <- stan(file = 'model.stan', 
                     model_name='Multi_Reg', 
                     data=stan_data, 
                     iter=5000, chains=2)
