#####################################################################
################ Visualization of Simulation Studies ################
#####################################################################

library(ggplot2) # plotting beautifully
library(scales) # transparent colors

# download data from Github
F2 <- read.csv(url('https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/Levene%20data.csv'))
F3 <- read.csv(url('https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/VR%20data.csv'))
F4 <- read.csv(url('https://raw.githubusercontent.com/rjwthree/Tail_Simulations/master/TPR%20data%20(simple).csv'))



# Levene 15000 Figure
cap <- paste0('The median-based Levene\'s test was simulated on balanced samples ',
              'ranging in size from 20 to 15,000 for variance ratios (VRs) from ',
              '1.10 to 1.40.')

data <- data.frame(N = F2[,1],
                   Power = c(F2[,2], F2[,3], F2[,4], F2[,5]),
                   VR = rep(c('1.10', '1.20', '1.30', '1.40'), each = 140))

tiff(filename = 'Levene 15000 Figure.png', width = 10.5, height = 9,
     units = 'in', pointsize = 14, bg = 'white', res = 300) # image file

ggplot(data, aes(x = N, y = Power, group = VR)) +
  geom_line(aes(colour = VR), size = .6) +
  ggtitle('Power of Median-based Levene\'s Test') +
  theme(text = element_text(family = 'Optima', size = 14),
        panel.background = element_rect(fill = alpha('#45BCFF', .15)),
        plot.title = element_text(hjust = .5),
        axis.title.x = element_text(margin = margin(t = 10)),
        legend.position = 'bottom',
        plot.caption = element_text(size = 9.5, hjust = .5, margin = margin(t = 10))) +
  labs(x = 'Total Sample Size', y = 'Power (%)', colour = 'Real VR', caption = cap) +
  scale_x_continuous(breaks = seq(from = 0, to = 15000, by = 1000),
                     minor_breaks = seq(from = 0, to = 15000, by = 500),
                     limits = c(20, 15000)) +
  scale_y_continuous(breaks = seq(from = 0, to = 100, by = 10),
                     limits = c(3.5, 100)) +
  scale_color_manual(values = c('#E82728', '#87D180', '#3DA7EE', '#8000FF'))

dev.off() # write image to working directory



# Levene 1000 Figure
cap <- paste0('The median-based Levene\'s test was simulated on balanced samples ',
              'ranging in size from 20 to 1,000 for variance ratios (VRs) from ',
              '1.10 to 1.40.')

data <- data.frame(N = F2[1:50,1],
                   Power = c(F2[1:50,2], F2[1:50,3], F2[1:50,4], F2[1:50,5]),
                   VR = rep(c('1.10', '1.20', '1.30', '1.40'), each = 50))

tiff(filename = 'Levene 1000 Figure.png', width = 10.5, height = 9,
     units = 'in', pointsize = 14, bg = 'white', res = 300) # image file

ggplot(data, aes(x = N, y = Power, group = VR)) +
  geom_line(aes(colour = VR), size = .6) +
  ggtitle('Power of Median-based Levene\'s Test') +
  theme(text = element_text(family = 'Optima', size = 14),
        panel.background = element_rect(fill = alpha('#45BCFF', .15)),
        plot.title = element_text(hjust = .5),
        axis.title.x = element_text(margin = margin(t = 10)),
        legend.position = 'bottom',
        plot.caption = element_text(size = 9.5, hjust = .5, margin = margin(t = 10))) +
  labs(x = 'Total Sample Size', y = 'Power (%)', colour = 'Real VR', caption = cap) +
  scale_x_continuous(breaks = seq(from = 0, to = 1000, by = 100),
                     limits = c(20, 1000)) +
  scale_y_continuous(breaks = seq(from = 0, to = 100, by = 10),
                     limits = c(3.5, 100)) +
  scale_color_manual(values = c('#E82728', '#87D180', '#3DA7EE', '#8000FF'))

dev.off() # write image to working directory



# VR Figure
cap <- paste0('The directional error rate (i.e., rate of observed VRs < 1) ',
              'is plotted for different real variance ratios (VRs) in balanced ',
              'samples ranging in size from 20 to 3,000.')

data <- data.frame(N = F3[,1],
                   DER = c(F3[,2], F3[,3], F3[,4], F3[,5]),
                   VR = rep(c('1.10', '1.20', '1.30', '1.40'), each = 72))

tiff(filename = 'VR Figure.png', width = 10.5, height = 9,
     units = 'in', pointsize = 14, bg = 'white', res = 300) # image file

ggplot(data, aes(x = N, y = DER, group = VR)) +
  geom_line(aes(colour = VR), size = .6) +
  ggtitle('Directional Error Rate of Observed VRs') +
  theme(text = element_text(family = 'Optima', size = 14),
        panel.background = element_rect(fill = alpha('#45BCFF', .15)),
        plot.title = element_text(hjust = .5),
        axis.title.x = element_text(margin = margin(t = 10)),
        legend.position = 'bottom',
        plot.caption = element_text(size = 9.5, hjust = .5, margin = margin(t = 10))) +
  labs(x = 'Total Sample Size', y = 'Directional Error Rate (%)',
       colour = 'Real VR', caption = cap) +
  scale_x_continuous(breaks = seq(from = 0, to = 3000, by = 500),
                     limits = c(0, 3000)) +
  scale_y_continuous(breaks = seq(from = 0, to = 45, by = 5),
                     limits = c(0, 45)) +
  scale_color_manual(values = c('#E82728', '#87D180', '#3DA7EE', '#8000FF'))

dev.off() # write image to working directory



# TPR Figure
cap <- paste0('The directional error rate (i.e., rate of observed TPRs < 1) ',
              'is plotted for real tail proportion ratios (TPRs) of 1.10, 1.20, ',
              'and 1.50 with cut-points (CPs) of \n1% and 10% and tail sizes ranging ',
              'from 10 to 1,000. Each real TPR has similar outputs even with ',
              'different CPs, as emphasized by the three color pairs.')

data <- data.frame(N = F4[,1],
                   DER = c(F4[,2], F4[,3], F4[,4], F4[,5], F4[,6], F4[,7]),
                   TPR = rep(c('1.10', '1.20', '1.50'), each = 118),
                   CP = rep(c('1%', '10%'), each = 59, 3))

tiff(filename = 'TPR Figure.png', width = 10.5, height = 9,
     units = 'in', pointsize = 14, bg = 'white', res = 300) # image file

ggplot(data, aes(x = N, y = DER, group = interaction(TPR, CP))) +
  geom_line(aes(colour = TPR, linetype = CP), size = .4) +
  ggtitle('Directional Error Rate of Observed TPRs') +
  theme(text = element_text(family = 'Optima', size = 14),
        panel.background = element_rect(fill = alpha('#45BCFF', .15)),
        plot.title = element_text(hjust = .5),
        axis.title.x = element_text(margin = margin(t = 10)),
        legend.position = 'bottom',
        plot.caption = element_text(size = 9.5, hjust = .5, margin = margin(t = 10))) +
  labs(x = 'Tail Size', y = 'Directional Error Rate (%)',
       colour = 'Real TPR', caption = cap) +
  scale_x_continuous(breaks = seq(from = 0, to = 1000, by = 100),
                     limits = c(0, 1000)) +
  scale_y_continuous(breaks = seq(from = 0, to = 45, by = 5),
                     limits = c(0, 45)) +
  scale_color_manual(values = c('#E82728', '#87D180', '#8000FF')) +
  scale_linetype_manual(values = c('solid', 61))

dev.off() # write image to working directory




















