from matplotlib.pyplot import plot
import seaborn as sns

from ssa import SSA

from pystan import stan

# Test 1 : Generate long path with SSA
# and then recover the parameters with
# STAN. This should fail.

# x holds the path
# t holds the time steps

N = 1000
alpha = 1.0
mu = 10

x, t = SSA(100,N,a=alpha,mu=mu)

x = x.astype(int) # path data supposed to be integers.

path_data = {
    'N' : N,
    't' : t,
    'x' : x
}



# Setup STAN :
model_description = """
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

transformed parameters{
  real<lower=0> a_over_mu;
  a_over_mu <- alpha/mu;
}


model {
      x ~ poisson(a_over_mu+(x0-a_over_mu)*exp(-mu*t));
}
"""

# Attempting to recover coefficients from long-path. Won't work.
fit = stan(model_code=model_description, data=path_data, chains=1)

print fit

print 'alpha=', alpha
print 'mu=', mu
print 'Ratio of alpha/mu', alpha/mu

fit.plot()



