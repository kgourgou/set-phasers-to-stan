# simple regression example 
# in stan 

data {
  int<lower=0> N;
  int<lower=0> M;
  vector[N] x;
  vector[N] y;
}


transformed data {
    vector[N] cons;
    matrix[N, M+1] X;

    cons <- rep_vector(1, N);
    X <- append_col(cons, x);
}

parameters {
    vector[M+1] beta;
    real<lower=0> sigma;
}

model {
    y ~ normal(X * beta, sigma);
}