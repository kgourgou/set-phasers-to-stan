# STAN file for the birth/death homework

# Notice how the file is still written in a mix
# of "C++/R" notation, even though it can be run
# within python (with pystan).

data{
  int<lower=0> N; ## number of time steps
  vector[N] t; ## time value at each time step
  int x[N]; ## population value at each time step
}

transformed data{
  real x0; ## starting population value

  x0 <- x[1];
}

parameters{
  real<lower=0> alpha; ## birth rate parameter
  real<lower=0> mu; ## death rate parameter
}

transformed parameters{
    real<lower=0> bd_ratio;

    bd_ratio <- alpha/mu;
}

model {
    // alpha ~ gamma(1.5, .05);
    // mu ~ gamma(1.5, .05);
    x ~ poisson(bd_ratio+(x0-bd_ratio)*exp(-mu*t));
}
