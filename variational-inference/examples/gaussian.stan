# simple regression example
# in stan

data {
  int<lower=0> N;
  real y[N];
}


parameters {
  real mu;
  real<lower=0> sigma;
}

model {

  ## Need to define prior
  ## and likelihood here.

  for (n in 1:N)
    y[n] ~ normal(mu,sigma);

}