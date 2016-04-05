# simple regression example
# in stan

data {
  int<lower=1> N;
  int<lower=1> k;
  real y[N];
}
parameters {
  simplex[k] theta;
  real mu[k];
}
model {
  real ps[k];
  # priors. Pretty uninformative 

  for (i in 1:k){
    mu[i] ~ normal(0, 1.0e+2);
  }

# likelihood
for(i in 1:N){
    for(j in 1:k){
      ps[j] <- log(theta[j]) + normal_log(y[i], mu[j], 1.0);
    }
    increment_log_prob(log_sum_exp(ps));
  }

}