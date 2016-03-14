# STAN file for the birth/death homework

# Notice how the file is still written in a mix
# of "C++/R" notation, even though it can be run
# within python (with pystan).

data{
  int<lower=0> N;
  vector[N] t;
  int<lower=0> x[N];
}

transformed data{
  real<lower=0> x0;

  x0 <- x[1];
}

parameters{
  real<lower=0> alpha;
  real<lower=0> mu;
}

model {
      x ~ poisson(); ## fill this part in
}
