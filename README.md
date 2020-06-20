# Levene VR TPR Simulations
Simulation studies of group differences in variability and tails

Researchers frequently underestimate the sample sizes needed to reliably detect typical group differences in variability and tail behavior. Three simulation studies are implemented here to emphasize and delineate this issue.


VR - variance ratio: ratio of variance in one group to variance in another group. The square root of this is the standard deviation ratio.

TPR - tail proportion ratio: a relational measure of density in a specified range, which compares the proportions of two distributions above or below a given cut-point in the form of a ratio.

Levene's test - a test of homogeneity of variance, the median-based variant of which is highly robust.


Other terms:

Real VR / Real TPR: the expected value of an observed VR/TPR when sampling from a given pair of distributions.

DER - directional error rate: a ratio of 1 indicates equality. Real VRs/TPRs in these simulations are always greater than 1, so observed VRs/TPRs less than 1 are qualitatively incorrect. The DER is the percentage of observed VRs/TPRs less than 1.

TS - tail size: the number of data points beyond a given cut-point (CP). Cut-points in the TPR simulation specify the top or bottom 1% or 10%. The tail size beyond a 10% cut-point in a sample of 300 is 30.
