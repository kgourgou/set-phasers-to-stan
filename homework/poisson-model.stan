# STAN file for the SSA homework

# Notice how the file is still written in a mix
# of "C++/R" notation, even though it can be run
# within python (with pystan).

data{
  int<lower=0> N; ## number of time steps
  vector[N] t; ## time value at each time step
  int<lower=0> x[N]; ## population value at each time step
}

transformed data{
  int<lower=0> x0; ## starting population value

  x0 <- x[1];
}

parameters{
  real<lower=0> alpha; ## birth rate parameter 
  real<lower=0> mu; ## death rate parameter
}

model {
      x ~ poisson(alpha/mu+(x0-alpha/mu)*exp(-mu*t)); 
}
