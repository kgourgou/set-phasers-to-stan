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
# You will need three pieces of data, see path_data below. 


X = X.astype(int) # Casting the X vector as an integer

path_data = {
    'N' : n, # number of data points
    't' : tpath, # time steps, t_i=t_{i-1}+dt_i, dt_i provided by SSA
    'x' : X # The path provided by the SSA
}

# Add the name of the .stan file in the function below. 
fit = pystan.stan(file='',data=path_data,
                  iter=1000,chains=1)

print fit

# You can also extract the coefficients from the fit object. See Stan documentation. 

