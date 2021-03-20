#########################################################################
#########################################################################
##### Simulation Studies of Group Differences in Variance and Tails #####
#########################################################################
#########################################################################


#########################
##### VR Simulation #####
#########################

# simulate the percentage of observed VRs < 1 (directional error rate, DER)
# in balanced, normally distributed samples of total size 'n' and with
# st dev ratio 's', where s > 1 and the expected value of an observed VR is s^2


# vector for sqrt of real variance ratio (VR): VR = 1.1, 1.2, 1.3, 1.4
s_v <- rep(sqrt(c(1.1, 1.2, 1.3, 1.4)), each = 72)

# vector for total number of participants: 20 ≤ n ≤ 3000
n_v <- rep(c(seq(20, 40, 2), seq(50, 200, 10), seq(220, 500, 20), seq(550, 1000, 50), seq(1100, 3000, 100)), 4)

c <- 0 # count

VRSim <- function(s, n) {
  nSims <- 10^7 # number of samples
  nIter <- 10^6 # progress updates will print at multiples of this number
  nb <- n/2 # number of participants per group
  OVRs <- numeric(nSims) # empty container for observed variance ratios
  
  c <<- c + 1 # print global progress and unique info, then print start
  print(paste0(c, '/', length(s_v), ', VR = ', s^2, ', n = ', n), quote = F)
  print(paste0('Start at ', Sys.time()), quote = F)
  
  for (i in 1:nSims) { # for each sample
    sim_x <- rnorm(n = nb, sd = 1) # simulate nb participants in condition x
    sim_y <- rnorm(n = nb, sd = s) # simulate nb participants in condition y
    
    OVRs[i] <- var(sim_y)/var(sim_x) # observed VR
    
    if (i %% nIter == 0) {print(paste0(i, ' at ', Sys.time()), quote = F)} # print updates
  }
  DER <- sum(OVRs < 1)/length(OVRs)*100 # directional error rate
  return(data.frame(DER, VR = s^2, n))
}

VRDER <- data.frame(t(mapply(FUN = VRSim, s_v, n_v))) # DER given s, nb


# Caveat for VR Sim
# It is not necessary to compute DERs at higher sample sizes once DER has reached 0
# For 10^7 sims, DER sinks to 0 at about n = 2000 for VR = 1.4 and n = 3000 for VR = 1.3
# DER does not reach 0 for VR = 1.1 and VR = 1.2




#############################
##### Levene Simulation #####
#############################

# simulate the power of the median-based Levene's test of equality of variances
# for two independent, normally distributed groups, each of size 'nb' and with st dev ratio 's'
# this section adapted from code for Fig 1 in Delacre, Lakens, & Leys (2017) doi 10.5334/irsp.82

library(car) # Levene's test

# vector for sqrt of real variance ratio (VR): VR = 1.1, 1.2, 1.3, 1.4
s_v <- rep(sqrt(c(1.1, 1.2, 1.3, 1.4)), each = 150)

# vector for total number of participants: 20 ≤ n ≤ 15000
n_v <- rep(c(seq(20, 1000, 20), seq(1050, 2000, 50), seq(2100, 5000, 100), seq(5200, 15000, 200)), 4)

c <- 0 # count

PowerSim <- function(s, n) {
  nSims <- 10^7 # number of samples
  nIter <- 10^6 # progress updates will print at multiples of this number
  nb <- n/2 # number of participants per group
  
  condition <- rep(c('x', 'y'), each = nb) # condition labels
  p <- numeric(nSims) # empty container for Levene's test p values
  
  c <<- c + 1 # print global progress and unique info, then print start
  print(paste0(c, '/', length(s_v), ', VR = ', s^2, ', n = ', n), quote = F)
  print(paste0('Start at ', Sys.time()), quote = F)
  
  for (i in 1:nSims) { # for each sample
    sim_x <- rnorm(n = nb, sd = 1) # simulate nb participants in condition x
    sim_y <- rnorm(n = nb, sd = s) # simulate nb participants in condition y
    
    d <- data.frame(xy = c(sim_x, sim_y), condition) # dataframe for Levene's test
    
    p[i] <- leveneTest(y = d$xy ~ d$condition, data = d)$'Pr(>F)'[1] # Levene's test p value
    
    if (i %% nIter == 0) {print(paste0(i, ' at ', Sys.time()), quote = F)} # print updates
  }
  power <- sum(p < .05)/nSims*100 # calculate power as a percentage
  return(data.frame(Power = power, VR = s^2, n))
}

LevPower <- data.frame(t(mapply(FUN = PowerSim, s_v, n_v))) # power given s, n


# Caveat for Levene Sim
# If four significant digits are desired (as here), it is not necessary to compute power
# estimates at higher sample sizes once power has exceeded 99.995%; all will round to 100.00%.
# This threshold is surpassed at about n = 2800 for VR = 1.4, n = 4600 for VR = 1.3,
# and n = 9500 for VR = 1.2; it is not surpassed for VR = 1.1.




##########################
##### TPR Simulation #####
##########################

# simulate the percentage of observed TPRs < 1 (directional error rate, DER) in normally
# distributed samples with combined sample size 'n', beyond a cut-point dictated by a fraction 'TF'
# there is a real tail proportion ratio > 1, 'TPR', which is the expected value of an observed TPR
# there are two variants; the complex one accomodates mean differences


### simple variant

# vector for tail fractions: TF = 1%, 10%
TF_v <- rep(c(.01, .1), each = 59, times = 3)

# vector for real tail proportion ratios: TPR = 1.1, 1.2, 1.5
TPR_v <- rep(c(1.1, 1.2, 1.5), each = 118)

# vector for tail sizes: 10 ≤ TS ≤ 1000
TS_v <- rep(c(seq(10, 100, 5), seq(110, 200, 10), seq(220, 500, 20), seq(525, 750, 25), seq(800, 1000, 50)), 6)

c <- 0 # count

TPRSimple <- function(TF, TPR, TS) {
  nSims <- 10^7 # number of samples
  nIter <- 10^6 # progress updates will print at multiples of this number
  n <- TS/TF # total group size
  s <- qnorm(2*TF/(TPR+1))/qnorm(2*TF*TPR/(TPR+1)) # st dev ratio for a given TF and TPR
  OTPRs <- numeric(nSims) # empty container for observed tail proportion ratios
  
  c <<- c + 1 # print global progress and unique info, then print start
  print(paste0(c, '/', length(TF_v), ', TF = ', TF*100, '%, TPR = ', TPR, ', TS = ', TS), quote = F)
  print(paste0('Start at ', Sys.time()), quote = F)
  
  for (i in 1:nSims) { # for each sample
    # alternating +1 and -1 from half prevents TPRs from occasionally landing at exactly 1 (unrealistic)
    if (i %% 2 == 1) {nb1 <- n/2 + 1} else (nb1 <- n/2 - 1)
    nb2 <- n-nb1 # nb2 is the complement
    
    sim_x <- rnorm(n = nb1, sd = 1) # simulate nb1 participants in condition x
    sim_y <- rnorm(n = nb2, sd = s) # simulate nb2 participants in condition y
    
    # location of the selected quantile in the left tail of the mixed distribution
    tail <- quantile(x = c(sim_x, sim_y), probs = TF)
    
    OTPRs[i] <- sum(sim_y < tail)/nb2/(sum(sim_x < tail)/nb1) # observed TPR
    
    if (i %% nIter == 0) {print(paste0(i, ' at ', Sys.time()), quote = F)} # print updates
  }
  DER <- sum(OTPRs < 1)/nSims*100 # directional error rate
  return(data.frame(DER, TF = TF*100, TPR, TS))
}

TPRDER.s <- data.frame(t(mapply(FUN = TPRSimple, TF_v, TPR_v, TS_v))) # DER given TF, TPR, TS


### complex variant

# vector for tail fractions: TF = 1%, 10%
TF_v <- rep(c(.01, .1), times = 275)

# vector for real tail proportion ratios: TPR = 1.1, 1.2, 1.5, 2, 3
TPR_v <- rep(c(1.1, 1.2, 1.5, 2, 3), each = 110)

# vector for Cohen's d values: -.8 ≤ d ≤ .8
d_v <- rep(c(-.8, -.5, -.3, -.1, -.05, 0, .05, .1, .3, .5, .8), each = 10, times = 5)

# vector for tail sizes: 10 ≤ TS ≤ 1000
TS_v <- rep(c(10, 50, 100, 500, 1000), each = 2, times = 55)

c <- 0 # count

TPRSim <- function(TF, TPR, d, TS) {
  nSims <- 10^7 # number of samples
  nIter <- 10^6 # progress updates will print at multiples of this number
  n <- TS/TF # total group size
  a <- qnorm(2*TF/(TPR+1))
  b <- qnorm(2*TF*TPR/(TPR+1))
  s <- (a*b-d*sqrt(a^2+b^2-d^2))/(b^2-d^2) # st dev ratio for a given TF, TPR, d
  M <- d*sqrt((s^2+1)/2) # raw mean difference
  OTPRs <- numeric(nSims) # empty container for observed tail proportion ratios
  
  c <<- c + 1 # print global progress and unique info, then print start
  print(paste0(c, '/', length(d_v), ', TF = ', TF*100, '%, TPR = ', TPR, ', d = ', d, ', TS = ', TS), quote = F)
  print(paste0('Start at ', Sys.time()), quote = F)
  
  for (i in 1:nSims) { # for each sample
    # alternating +1 and -1 from half prevents TPRs from occasionally landing at exactly 1 (unrealistic)
    if (i %% 2 == 1) {nb1 <- n/2 + 1} else (nb1 <- n/2 - 1)
    nb2 <- n-nb1 # nb2 is the complement
    
    sim_x <- rnorm(n = nb1, mean = 0, sd = 1) # simulate nb1 participants in condition x
    sim_y <- rnorm(n = nb2, mean = M, sd = s) # simulate nb2 participants in condition y
    
    # location of the selected quantile in the right tail of the mixed distribution
    tail <- quantile(x = c(sim_x, sim_y), probs = 1-TF)
    
    OTPRs[i] <- sum(sim_y > tail)/nb2/(sum(sim_x > tail)/nb1) # observed TPR
    
    if (i %% nIter == 0) {print(paste0(i, ' at ', Sys.time()), quote = F)} # print updates
  }
  DER <- sum(OTPRs < 1)/nSims*100 # directional error rate
  return(data.frame(DER, TF = TF*100, TPR, d, TS))
}

TPRDER <- data.frame(t(mapply(FUN = TPRSim, TF_v, TPR_v, d_v, TS_v))) # DER given TF, TPR, d, TS




















