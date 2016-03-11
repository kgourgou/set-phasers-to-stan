# Sample file for the homework on STAN.

## Let us import some libraries

# Plotting
from matplotlib.pyplot import plot
import matplotlib.pyplot as pl

# Random numbers
from numpy.random import randn, rand

# Setting some options
from pylab import rcParams
rcParams['figure.figsize'] = 10,5 # large figures


import numpy as np # for all the numerical stuff

import pystan # for stan commands

# optionally, import the seaborn library
# for cooler plots
try:
    import seaborn as sns
except:
    print 'Looks like seaborn is not installed on your system. :-('
    print 'Consider installing it! It is worth it! :-)' 

print 'All libraries loaded OK'

# Euler-Maruyama for the Birth/Death system

def EM(xinit,T,Dt=0.1,a=10.0,mu=2.0):
    '''
        Returns the solution of the CLE with parameters a, mu
        
        Arguments
        =========
        xinit : real, initial condition.
        Dt    : real, stepsize of the Euler-Maruyama. (optional)
        T     : real, final time to reach. 
        a     : real, controls the rate of birth. (optional)
        mu    : real, controls the rate of death. (optional)

       Returns
       =======
       X      : array-like, the approximation to the solution
                of the SDE.

       Warnings
       =======

       1) If the population, X[n*Dt], becomes negative at some point,
       then the function will fail due to the square root calculation
       below.

       2) Check that the code below is actually correct and the results make sense.

    '''

    # Just in case a,mu are integers.
    a = float(a)
    mu= float(mu)

    n = int(T/Dt) # number of steps to reach T
    X = np.zeros(n)
    z = randn(n) # generate all random numbers from the start.

    X[0] = xinit # Initial condition
    
    tpath = np.linspace(0,T,n) # Let us also store the steps used

    # EM method
    for i in xrange(1,n):
        X[i] = X[i-1] + Dt* (a-mu*X[i-1])+(np.sqrt(a)-np.sqrt(mu*X[i-1]))*np.sqrt(Dt)*z[i]
        
    return X, tpath,n

# Let's plot a bunch of paths for different initial conditions

T = 10

pl.figure()

for _ in xrange(3):
    X, tpath,n = EM(xinit=10*rand(),T=T)
    plot(tpath,X)

pl.xlabel('Time')
pl.ylabel('Path')
pl.title('Some paths with random initial conditions.')
#pl.show()

# We will use the last path generated as data.

path_data = {
    'N' : n, # number of data points
    'x' : tpath,
    'y' : X
}

fit = pystan.stan(file='model.stan',data=path_data,
                  iter=1000,chains=1)

posterior_means = fit.get_posterior_mean()
b0 = posterior_means[0]
b1 = posterior_means[1]

linear_model = lambda t: b0 + b1*t

pl.figure() # open new figure
plot(tpath, X)
plot(tpath, linear_model(tpath))
pl.xlabel('Time')
pl.ylabel('Path')


# OK, that is not a super interesting fit.
# Let's try something more interesting.
# Polynomial fitting in STAN
# y = b0+b1*t+b2*t^2 + ... bn*t^n

t = np.array([tpath,tpath**2,tpath**3]).T

path_data = {
    'N' : n, # number of data points
    'M' : 3, # order of the fit
    'x' : t,
    'y' : X
}


fit2 = pystan.stan(file='model2.stan',data=path_data,
                   iter=1000,chains=1)

# polynomial fitting
coeff = fit2.get_posterior_mean()

model2 = lambda t: coeff[0] + coeff[1]*t + coeff[2]*t**2 + coeff[3]*t**3;

plot(tpath,model2(tpath))

pl.legend(['SDE','Linear Fit','Cubic fit'],loc=0)
pl.show()


