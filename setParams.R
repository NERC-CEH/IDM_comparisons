###Set parameters

#genData
dim = c(300,300)
lambda = -3
env.beta = 1.2
plotdat = TRUE
seed = NULL
sigma2x = 0.5
kappa = 0.05

#genStrataLam
strata = 25
rows = 5
cols = 5
plot = TRUE

#addSpatialBias
# this is where we can control bias
probs = rep(c(0.5, 0.3, 0.1, 0.05, 0.01),5) ## Can this be a single number now?

#sampleStructured
nsamp = 150
plotdat = TRUE
qsize = 1

#correlation between bias and environment
rho = 0.99
correlation = FALSE

#general
resolution = c(10,10)

