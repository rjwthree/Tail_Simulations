# Levene VR TPR Simulations
Simulation studies of group differences in variability and tails

See the PDF file for an explanation of the formula for the standard deviation ratio in the TPR simulation.

Researchers frequently underestimate the sample sizes needed to reliably detect typical group differences in variability and tail behavior. Three simulation studies are implemented here to emphasize and delineate this issue.


VR - variance ratio: ratio of variance in one group to variance in another group. The square root of this is the standard deviation ratio.

TPR - tail proportion ratio: a relational measure of density in a specified range, which compares the proportions of two distributions above or below a given cut-point in the form of a ratio.

Levene's test - a test of homogeneity of variance, the median-based variant of which is highly robust.


Other terms:

Real VR / Real TPR: the expected value of an observed VR/TPR when sampling from a given pair of distributions.

DER - directional error rate: a ratio of 1 indicates equality. Real VRs/TPRs in these simulations are always greater than 1, so observed VRs/TPRs less than 1 are qualitatively incorrect. The DER is the percentage of observed VRs/TPRs less than 1.

TS - tail size: the number of data points beyond a given cut-point (CP). Cut-points in the TPR simulation specify the top or bottom 1% or 10%. The tail size beyond a 10% cut-point in a sample of 300 is 30.

# VR Simulation
Real VRs range from 1.1 to 1.4, and sample sizes range from 20 to 3,000. Higher real VRs produce fewer observed VRs below 1, and larger samples produce less deviation of observed VRs around the real VR.

Take the example of real VR = 1.1 and n = 500. This simulation generates 250 data points from a normal distribution with mean 0 and variance 1, and another 250 from a distribution with mean 0 and variance 1.1. It then computes and records the observed VR. This is performed ten million times, and the result upon running it was that the DER was 22.63%. That is, 22.63% of observed VRs fell below 1.
