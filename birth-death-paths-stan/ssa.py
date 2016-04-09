'''
  SSA code that simulates a birth-death process.
'''

import numpy as np
from numpy.random import randn, rand

def SSA(xinit, nsteps, a=10.0, mu=1.0):
    '''
        Using SSA to exactly simulate the death/birth process starting
        from xinit and for nsteps or up to time T.

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
