#' Demonstrate different parameter combinations for models
#' 
#' Import default parameters
#' 
source("setParams.R")

library(viridis)

lambda <- -3 #manageable number
#env.beta <- 3 #stronger env effect

#' The default parameters are as follows:
#' 
#' - simulation is conducted on a grid of 300*300  
#' - environmental covariate coefficient of NULL
#' - scale parameter kappa for matern covariance of 0.05  
#' - variance parameter sigma2x of matern covariance of 2  
#' - mean log intensity of point process of -3  
#' - 500 structured samples  - to simulate "perfect" coverage
#' - 3 strata  
#' - probability of sampling strata at 1, 1 and 1 used for thinning point process (i.e no thinning)  
#' - qsize of 1

#' Here we can change default parameters:
#' 
#' e.g. we want to simulate a point process with a smaller mean intensity

lambda <- -1
dim = c(100,100)
seed = 100

#' ## Generate data from parameters

#' 
#' This script generates data using the parameters specified above. The key steps are:
#' 
#' 1. Simulate a log Gaussian Cox process with the lambda, kappa, sigma2x and dimensions specified above. This creates a point process and a realisation from this point process which is then thinned to create the unstructured data. If the env.beta parameter is not set to NULL then the point process is simulated to be dependent on an environmental covariate with the coefficient of this effect specified by env.beta. The environmental covariate is simple and has three levels distributed equally across the surface.
#' 
#' 2. Thin the point process to create spatially biased unstructured data. Currently this is done by strata, and the user can specify the number of strata and the probabilities of sampling each point in each stratum.
#' 
#' 3. Create a new realisation from the same point process which will become the structured data. 
#' 
#' 4. Sample the new points over an area (roughly speaking) by generating stratified random points (to ensure global coverage) and then denoting presence as the presence of one or more point process realisation in the 5x5 neighbourhood surrounding the stratified random points. Absence is denoted as the absence of any point process realisation in this "quadrat".
#' 
#' 
#' ### Plots of the data generation process
#' 
#+ warning = FALSE, message = FALSE, error = FALSE, include = FALSE
source("Functions to generate data and sample.R")

g1 <- genDataFunctions(dim = dim, lambda = lambda, env.beta = env.beta, seed = seed, kappa = kappa, sigma2x = sigma2x, strata = strata, rows = rows, cols = cols, probs = probs, nsamp = nsamp, qsize = 1)

structured_data <- g1$structured_data
unstructured_data <- g1$unstructured_data
biasfield <- g1$biasfield
dat1 <- g1$dat1
biascov <- g1$biascov
strata1 <- g1$strata1

#new points for structured sample

newpoints <- rpoispp(lambda = dat1$Lam)

#' Visualise the random field and covariate pattern
#+ echo = FALSE 
par(mfrow=c(1,3)) 
image.plot(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), main='log-Lambda', asp=1) 
points(dat1$xy, pch=19)
image.plot(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$gridcov)), main='Covariate', asp=1, viridis(50))
image.plot(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(biascov)), main='Bias covariate', asp=1)

#' Visualise the strata and associated probabilities of sampling
#+ echo = FALSE 
par(mfrow=c(1,1), xpd = TRUE) 
par(mar=c(4,4,4,7))
palette(viridis(50))
plot(biasfield$y ~ biasfield$x, col = biasfield$stratprobs*100)
legend(110,100, col = c(50,40,30,20,10), pch = 20, legend = c("0.4-0.5", "0.3-0.4", "0.2-0.3", "0.1-0.2", "0.01-0.1"), title = "Probability")

#' Visualise thinned unstructured data
#+ echo = FALSE 
par(mfrow=c(1,1))
image.plot(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), main='Thinned unstructured data', asp=1) 
points(unstructured_data$x, unstructured_data$y, pch = 20)#note rescale again - plotting back on original

#' Visualise structured data
#+ echo = FALSE  
par(mfrow=c(1,1))
image.plot(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), main='Structured data', asp=1) 
points(structured_data$x,structured_data$y, pch = 21, bg = structured_data$presence, col = "black")
par(xpd = TRUE)
legend(-10,360,c("Absence", "Presence"), pch = 21, col = "black", pt.bg = c(0,1))

##Figure 1

#png("Figure 1 CC v2.png", height = 180, width = 200, units = "mm", res = 100, pointsize = 16)

par(mfrow=c(1,1))
par(mar=c(1,1,1,1))

#edit to plot separately without axes

#env
image.plot(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$gridcov)), asp=1, col = viridis(50))


png("1_environment.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
image(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$gridcov)), asp=1, col = viridis(50), xaxt = "n", yaxt = "n",bty = "n")
dev.off()

#intensity

png("2_intensity.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
image(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), asp=1, col  = viridis(50), xaxt = "n", yaxt = "n", bty = "n")
dev.off()


# species locs

#for plotting thin by factor of 10 otherwise hard to visualise

idx <- seq(1, nrow(dat1$xy), 10)

points1 <- dat1$xy[idx,]

points2 <- newpoints[idx,]



png("3_specieslocs1.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
image(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), col = viridis(50), xaxt = "n", yaxt = "n", bty = "n") 
points(points1, pch=19)
dev.off()


png("3_specieslocs2.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
image(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), asp=1, col = viridis(50), xaxt = "n", yaxt = "n", bty = "n") 
points(points2$y ~ points2$x, pch=19)
dev.off()


#strata

png("4_detection.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
palette(viridis(50))
plot(biasfield$y ~ biasfield$x, col = biasfield$stratprobs*100, cex = 3, pch = 15,xaxt = "n", yaxt = "n", bty = "n")
dev.off()

# PO data

#thin for plotting
idx <- seq(1, nrow(unstructured_data), 5)
uns_points <- unstructured_data[idx,]

png("5_POdata.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
image(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), col = viridis(50), xaxt = "n", yaxt = "n", bty = "n") 
points(uns_points$x, uns_points$y, pch = 19)
dev.off()


#strata

png("6_strata.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
palette(viridis(25))
plot(biasfield$y ~ biasfield$x, col = "white", cex = 3, pch = 15, yaxt = "n", xaxt = "n", bty = "n", xlim = c(0,100), ylim = c(0,100), xaxs = "i", yaxs = "i")
par(xpd = FALSE)
abline(h = 0); abline(h = 20);abline(h = 40); abline(h = 60); abline(h = 80); abline(h = 100)
abline(v = 0); abline(v = 20);abline(v = 40); abline(v = 60); abline(v = 80); abline(v = 100)
dev.off()


#structured data
png("7_PAdata.png")
par(mfrow=c(1,1))
par(mar=c(1,1,1,1))
image(list(x=dat1$Lam$xcol, y=dat1$Lam$yrow, z=t(dat1$rf.s)), asp=1, col = viridis(50), yaxt = "n", xaxt = "n", bty = "n") 
points(structured_data$x,structured_data$y, pch = 21, bg = structured_data$presence, col = "black", cex = 3)
dev.off()

#dev.off()
