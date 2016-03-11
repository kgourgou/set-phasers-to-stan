# STAN file for the birth/death homework

# Notice how the file is still written in a mix
# of "C++/R" notation, even though it can be run
# within python (with pystan).

data{

  int<lower=0> N;
  vector[N] x;
  real y[N];
}

transformed data{
  vector[N] cons;
  matrix[N, 2] X;

  cons <- rep_vector(1,N);
  X <- append_col(cons,x);
}

parameters{
  vector[2] beta;
  real<lower=0> sigma;
}

model {
      y ~ normal(X*beta, sigma);
}
