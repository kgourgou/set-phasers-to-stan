# simple regression example
# in stan

data {
  int<lower=0> N;
  int<lower=0> M;
  real x[N];
}


parameters {
  vector[M+1] beta;
  real<lower=0> sigma;
}

model {
  y ~ normal(X * beta, sigma);
}