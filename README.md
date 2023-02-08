# period-test-by-F-statistic
 A method of testing periodicity by the ratio of within-period variation to between-period variation

This method was given by: Truman L. Kelley (1943) The Evidence for Periodicity in Short Time Series, Journal of the American Statistical Association, 38:223, 319-326, DOI: 10.1080/01621459.1943.10501814



## Short description of this method

With the definition of the periodicity with length $T$:
$$
f(x)=f(x+kT)
$$
where $k=0,1,2,\dots$, suppose we have a periodic time series $\{X_t\}$, it is intuitive to divide the timepoints into several groups:
$$
t_1=1,1+T,1+2T,\dots\\
t_2=2,2+T,2+2T,\dots\\
\dots\\
t_T=T,T+T,T+2T,\dots
$$
and all the values from the same group $\{X_{t_k}\}$ should be the same. 

Now suppose $X_{t_k}\sim N(\mu_k,\sigma^2)$, we would consider a small $\sigma^2$ relative to the variation among $\mu_k$ as an indication of periodicity. Then, just like what we do in ANOVA, an F-test could be applied here. 



## How to use

The *PeriodTest.m* is the main function to do the test. A short demo was given.

The *PeriodMean.m* and *PeriodDetrend.m* could be used to find the shape of the periodicity, or detrend out the periodicity with specific *T* found by the test.  For detrending, one could minus out the estimated shape given by *PeriodMean.m* or by a *movmean* method given in *PeriodDetrend.m*. 

**The degree of freedom calculated in the function might not be accurate in specific conditions, one could use permutation or Monte Carlo method to test the F-statistic given by the function. An example of permutation is given in demo.m.**







