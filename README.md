# Simulations of Tails and Variability
Researchers frequently underestimate the sample sizes needed to reliably detect typical group differences in variability and tail behavior. [Three simulation studies](https://github.com/rjwthree/Tail_Simulations/blob/master/Simulations.R) are implemented here to emphasize and delineate this issue. The code to download the output and create all of the plots below is [here](https://github.com/rjwthree/Tail_Simulations/blob/master/Sims%20Visualization.R). The evidence here is applied to some examples from academic research on sex differences, to illustrate how the researchers misjudged their results.

### Terms and acronyms

Levene's test - A test of homogeneity of variance, the median-based variant of which is highly robust (and also known as the Brown-Forsythe test).

Variance Ratio (VR) - The ratio of variance in one group to variance in another group. Its square root is the standard deviation ratio.

Tail Proportion Ratio (TPR) - A relational measure of density beyond a given cut-point in a distribution, which compares the proportions of two distributions above or below the cut-point in the form of a ratio. The location of the cut-point is defined by the combined distribution (e.g., the cut-point is at the 90th percentile and the tail contains all data above the 90th percentile).

Tail Size (TS) - The number of data points beyond a given cut-point. For instance, the tail size beyond a 10% cut-point in a sample of 300 is 30. Cut-point locations in the TPR simulation are identified by specifying (1) the left or right tail and (2) the tail fraction (TF), either 1% or 10%.

Real VR / Real TPR - The expected value of an observed VR/TPR when sampling from a given pair of distributions.

Directional Error Rate (DER) - A ratio of 1 indicates equality. Real VRs/TPRs in these simulations are always greater than 1, so observed VRs/TPRs less than 1 are qualitatively incorrect. The DER is the percentage of observed VRs/TPRs less than 1.

&nbsp;

## [VR Simulation](https://github.com/rjwthree/Tail_Simulations/blob/master/Simulations.R#L9)
Take the example of real variance ratio (VR) = 1.1 and n = 500. This simulation generates 250 data points from a normal distribution with mean 0 and variance 1, and another 250 from a distribution with mean 0 and variance 1.1. It then computes and records the observed VR. This is performed ten million times, and the result was a directional error rate (DER) of 22.63%. That is, 22.63% of observed VRs fell below 1, compared to a random baseline of 50%.

Real VRs range from 1.1 to 1.4 and sample sizes from 20 to 3,000. Higher real VRs and larger samples produce fewer observed VRs below 1.

All results are plotted in the [VR Figure](https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/VR%20Figure.png) below. You can see that large sample sizes are required to provide a DER that falls far below the random level of 50%. A paper published in a prominent educational journal by [Kersey et al. (2018)](https://www.nature.com/articles/s41539-018-0028-7) analyzed sex differences in cognitive test scores in samples of children ranging in size from 80 to 275. It is evident from the figure below that the error rate is quite high even for the largest sample, especially if the real VR were less than 1.3. Although Kersey and colleagues were conscious of statistical power for mean differences, they entirely neglected their insufficient power with regard to variance differences. This implies that although they reported VRs, their samples were not capable of producing a reliably accurate estimate of the VR.

<p align="center">
<img src="https://github.com/rjwthree/Tail_Simulations/blob/master/VR%20Figure.png" width="700" height="600"/>
</p>

&nbsp;

## [Levene Simulation](https://github.com/rjwthree/Tail_Simulations/blob/master/Simulations.R#L59)
Take the example of real VR = 1.3 and n = 1,000. This simulation generates 500 data points from a normal distribution with mean 0 and variance 1, and another 500 from a distribution with mean 0 and variance 1.3. It then uses the 'car' package to conduct the median-based Levene's test, and the _p_ value is recorded. This is performed ten million times, and the percentage of cases in which the variance difference is significant at the 5% level defines the power. The result was power = 77.94%.

This simulation computes the power to detect a variance difference with real VRs ranging from 1.1 to 1.4 and sample sizes from 20 to 15,000. Higher real VRs and larger samples produce greater power.

Results from sample sizes up to 1,000 are plotted [below](https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/Levene%201000%20Figure.png). The paper mentioned above by Kersey and colleagues (2018) performed Levene’s procedure on their test score data. Although they found homogeneous variance in every sample, it is clear from the figure below that their sample sizes made this conclusion nearly inevitable. As noted above, they calculated statistical power for mean differences but did not note that they were underpowered to detect variance differences using Levene's test.

<p align="center">
<img src="https://github.com/rjwthree/Tail_Simulations/blob/master/Levene%201000%20Figure.png" width="700" height="600"/>
</p>

&nbsp;

All results are plotted [here](https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/Levene%2015000%20figure.png):

<p align="center">
<img src="https://github.com/rjwthree/Tail_Simulations/blob/master/Levene%2015000%20figure.png" width="700" height="600"/>
</p>

&nbsp;

## [TPR Simulation](https://github.com/rjwthree/Tail_Simulations/blob/master/Simulations.R#L115)
There are two variants of this simulation. Take an example of the simple variant: real TPR = 1.2, tail fraction (TF) = 1%, tail size (TS) = 100. First, the total group size is calculated: since TF is 1%, the total group must be 100 times as large as the tail, which has size 100: 100 * 100 = 10,000. A [formula](https://github.com/rjwthree/Tail_Simulations/blob/master/TPR_simulation.pdf) then computes the standard deviation ratio (s) needed to produce an expected TPR of 1.2 in the top and bottom 1% of the combined distribution (with no mean difference, the tails are symmetric). About half of the 10,000 data points are generated from a normal distribution with mean 0 and sd 1, and the remainder from a distribution with mean 0 and sd s≈1.0298. The quantile function locates the 1st percentile of the combined distribution of observed data, and the TPR below that point is computed and recorded. This is performed ten million times, and the result was DER = 17.98%.

The simple variant uses real TPRs of 1.1, 1.2, and 1.5; tail fractions of 1% and 10%; and tail sizes between 10 and 1,000. The complex variant includes mean differences, expressed in terms of Cohen's _d_, and it experiments with higher real TPRs of 2 and 3. It has a more complicated [formula](https://github.com/rjwthree/Tail_Simulations/blob/master/TPR_simulation.pdf) for the standard deviation ratio. Higher real TPRs and larger tail sizes produce fewer observed TPRs below 1.

See the file [TPR_Simulation.pdf](https://github.com/rjwthree/Tail_Simulations/blob/master/TPR_simulation.pdf) for an explanation of the formulas for the standard deviation ratio.

Results from the simple variant are plotted [here](https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/TPR%20Figure.png):

<p align="center">
<img src="https://github.com/rjwthree/Tail_Simulations/blob/master/TPR%20Figure.png" width="700" height="600"/>
</p>
