# STAN file for the birth/death homework

# Notice how the file is still written in a mix
# of "C++/R" notation, even though it can be run
# within python (with pystan).

data{

  int<lower=0> N;
  int<lower=0> M;

  matrix[N,M] x;
  real y[N];
}

transformed data{
  vector[N] cons;
  matrix[N,M+1] X;

  cons <- rep_vector(1,N);
  X <- append_col(cons,x);
}

parameters{
  vector[M+1] beta;
  real<lower=0> sigma;
}

model {
      y ~ normal(X*beta, sigma);
}
