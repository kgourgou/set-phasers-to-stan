# Homework 5
# by Kostis, Stephen, and Jie
# Assigned : March 15, 2016

# Sample file for the homework on STAN.

## Let us import some libraries!

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

# Load the data from the SSA here.



def SSA(xinit, nsteps, a=10.0, mu=1.0):
    '''
        Using SSA to exactly simulate the death/birth process starting
        from xinit and for nsteps. 

        a and mu are parameters of the propensities.

        Returns
        =======
        path : array-like, the path generated. 
        tpath: stochastic time steps
    '''
    path = np.zeros(nsteps)
    tpath= np.zeros(nsteps)

    path[0] = xinit # initial population
    u = rand(2,nsteps) # pre-pick all the uniform variates we need

    for i in xrange(1,nsteps):
        # The propensities will be normalized
        tot_prop = path[i-1]*mu+a
        prob = path[i-1]*mu/tot_prop # probability of death 

        if(u[0,i]<prob):
            # Death 
            path[i] = path[i-1]-1 
        else:
            # Birth
            path[i] = path[i-1]+1

        # Time stayed at current state
        tpath[i] = -np.log(u[1,i])*1/tot_prop
    tpath = np.cumsum(tpath)
    return path, tpath


def runMe(xinit=100,nsteps=100,alpha=1.0,mu=1.0, iter=1000, fit=None):
    '''

     Arguments
     ==========
      xinit : int, initial value for the SSA simulation.
      nsteps : int, number of samples to generate from SSA.
      alpha : real, non-negative, parameter controlling death rate.
      mu : real, positive, parameter controlling birth rate.
      iter : int, number of iterations to run in stan. 

    '''
    X, tpath = SSA(xinit,nsteps,a=alpha,mu=mu)

    X = X.astype(int) # Casting the X vector as an integer

    path_data = {
        'N' : nsteps, # number of data points
        't' : tpath, # time steps, t_i=t_{i-1}+dt_i, dt_i provided by SSA
        'x' : X # The path provided by the SSA
    }

    if(fit == None):
        fit = pystan.stan(file='poisson-model.stan',data=path_data,
                      iter=iter,chains=1, verbose=False)

    else :
        fit = pystan.stan(fit=fit, data=path_data, iter=iter, chains=1, verbose=False)


    print fit
    print '\nRemember : alpha=' + str(alpha) + ' and mu=' + str(mu)



    return fit

fit = runMe(nsteps=100);


