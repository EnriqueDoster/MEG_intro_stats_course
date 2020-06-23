######## Basic statistics ######
##### Set up environment
# Please excuse us if you keep finding new packages here for you to install.
# We'll try to minimize the use of additional packages
library("phyloseq")
library("dplyr")
library("ggplot2")
library("data.table")
library("tidyr")
library("forcats")
library("vegan")
library("ggpubr") # we'll use the function "ggqqplot()" for this step

# Let's erase any objects that might still be in your environment
rm(list=ls()) 

# Load the data
source("./scripts/load_data.R")


#
##
### Exploring the distribution of data
##
#

# R comes with many of the common distributions built in, for example:

# normal distribution example below, but you can easily find others online
pnorm(25, mean = 50, sd = 20) # direct look-up
qnorm(0.1056498, mean = 50, sd = 20) # inverse look-up
dnorm(25, mean = 50, sd = 20) # density
rnorm(4, mean = 50, sd = 20) # random variates following distribution

# The distribution of the dependent variable is important for deciding the correct test.
# For example, we might want to compare the number of raw reads between treatment groups

# Here's an example of how we can select just the values from certain sample groups
# notice the use of parantheses followed by the "$" to access the column:
(sample_metadata %>% 
    filter(Group == "Control"))$Shotgun_raw_reads

# We can check if these values approximate a normal distribution across all samples
hist.plot <- hist(sample_metadata$Shotgun_raw_reads)
xfit<-seq(min(sample_metadata$Shotgun_raw_reads),max(sample_metadata$Shotgun_raw_reads),length=40)
yfit<-dnorm(xfit,mean=mean(sample_metadata$Shotgun_raw_reads),sd=sd(sample_metadata$Shotgun_raw_reads))
yfit <- yfit*diff(hist.plot$mids[1:2])*length(sample_metadata$Shotgun_raw_reads)
lines(xfit, yfit, col="blue", lwd=2)

# This doesn't look to be normally distrubuted, but we should also check for each sample group
ctrl_shotgun_raw_reads <- (sample_metadata %>% 
        filter(Group == "Control"))$Shotgun_raw_reads

ctrl.hist.plot <- hist(ctrl_shotgun_raw_reads)
xfit<-seq(min(ctrl_shotgun_raw_reads),max(ctrl_shotgun_raw_reads),length=40)
yfit<-dnorm(xfit,mean=mean(ctrl_shotgun_raw_reads),sd=sd(ctrl_shotgun_raw_reads))
yfit <- yfit*diff(ctrl.hist.plot$mids[1:2])*length(ctrl_shotgun_raw_reads)
lines(xfit, yfit, col="blue", lwd=2)

# Treatment group
trt_shotgun_raw_reads <- (sample_metadata %>% 
                             filter(Group == "Treatment"))$Shotgun_raw_reads

trt.hist.plot <- hist(trt_shotgun_raw_reads)
xfit<-seq(min(trt_shotgun_raw_reads),max(trt_shotgun_raw_reads),length=40)
yfit<-dnorm(xfit,mean=mean(trt_shotgun_raw_reads),sd=sd(trt_shotgun_raw_reads))
yfit <- yfit*diff(trt.hist.plot$mids[1:2])*length(trt_shotgun_raw_reads)
lines(xfit, yfit, col="blue", lwd=2)



## create a Q-Q plot
# "draws the correlation between a given sample and the normal distribution.
# A 45-degree reference line is also plotted."
ggqqplot(sample_metadata$Shotgun_raw_reads)

ggqqplot((sample_metadata %>% 
        filter(Group == "Control"))$Shotgun_raw_reads)

ggqqplot((sample_metadata %>% 
        filter(Group == "Treatment"))$Shotgun_raw_reads)

# We can also use a normality test, such as "shapiro.test()" 
shapiro.test(sample_metadata$Shotgun_raw_reads)

shapiro.test((sample_metadata %>% 
            filter(Group == "Control"))$Shotgun_raw_reads)

shapiro.test((sample_metadata %>% 
            filter(Group == "Treatment"))$Shotgun_raw_reads)


# Another option is to use kernel density plots
plot(density(sample_metadata$Shotgun_raw_reads))
density(sample_metadata$Shotgun_raw_reads)


#
##
### Comparing means - T-test
##
#

# If you decide that the dependent variable is normally distributed, 
# you can use the t.test() function
t.test(sample_metadata$Shotgun_raw_reads ~ sample_metadata$Group)

# Other flags include "paired", "mu","var.equal", and "alternative" to better fit your needs


#
##
### Comparing means - non-parametric tests 
##
#

# We might decide that our dependent variable is not normally distributed and resort to
# non-parametric tests, such as the Wilcoxon test.


# Like with the hist() function, first we specify the column with numeric values
# Then we use the "~" followed by the column with the grouping variable you want to test
wilcox.test(sample_metadata$Shotgun_raw_reads ~ sample_metadata$Group)

# You can also add the "paired" flag to use the "Wilcoxon Signed Rank Test"

# Or, you can use the "Friedman test" to also include a blocking factor:
# NB: the "friedman.test()" function does not accept data.frame columns as input.
# instead, we have to make the variables first. This can be a requirement for other functions too.
shotgun_reads <- sample_metadata$Shotgun_raw_reads
sample_groups <- sample_metadata$Group
sample_blocks <- sample_metadata$Sample_block

friedman.test( shotgun_reads ~  sample_groups| sample_blocks)




#
##
### Multiple Linear Regression
##
#

# We can also use multiple linear regression to model the relationship between two or more
# independent variables and a dependent variable by fitting a linear equation to the observed data.

# We can fit a model using lm()
# NB: we use the same y ~ x1 + x2 notation to describe the formula
# Also, we use use "as.factor()" on the Sample_block column. If you don't convert these values to a factor,
# the model will treat the variable as a continuous variable.
fit_shotgun_reads <- lm(data=sample_metadata, Shotgun_raw_reads ~ Group + as.factor(Sample_block))
fit_shotgun_reads

# we can also use "*" to include the interaction of two variables
fit_shotgun_reads <- lm(data=sample_metadata, Shotgun_raw_reads ~ Group * as.factor(Sample_block))
fit_shotgun_reads

# Get more information about model
summary(fit_shotgun_reads) # model summary
coefficients(fit_shotgun_reads) # model coefficients
confint(fit_shotgun_reads, level = 0.95) # CIs for model parameters
fitted(fit_shotgun_reads) # predicted values
residuals(fit_shotgun_reads) # model residuals
vcov(fit_shotgun_reads) # covariance matrix for model parameters
influence(fit_shotgun_reads) # regression diagnostics
anova(fit_shotgun_reads) # anova table, this is typically what we report

# Diagnostic plots
# Just plotting the model fit will cause 4 plots to be displayed, one at a time.
plot(fit_shotgun_reads)

# You can access each plot within the list like this:
plot(fit_shotgun_reads[[1]]) # View the first plot

# There are many other functions to work with these fitted models from 
# comparing multiple models to step-wise selection of variables, you can 
# find just about anything with a quick online search.

# Additionally, generalized linear models allow the expansion of modeling options
# including logistic and poisson regression.
# See here for some examples: https://www.statmethods.net/advstats/glm.html

# In the deliverable for Lesson 2 step 3, you'll practice using these statistical
# tests to compare different values between relevant sample groups. 

# Here's a quick example with the combined_diversity_values object to get you started
# Notice, this is quite messy but try to understand everything that is going on,
# if you prefer, you can also just subset the data into smalller subsets.

# Full command, subsetting just data from the 16S microbiome data
# NB: we can move to other lines because the command is within "()"
wilcox.test(
 (combined_diversity_values %>% filter(DataType == "16S microbiome"))$Shannon 
 ~ (combined_diversity_values %>% filter(DataType == "16S microbiome"))$Group
)

# Or, subset the data first
diversity_16S_microbiome <- combined_diversity_values %>% filter(DataType == "16S microbiome")
# wilcox
wilcox.test(diversity_16S_microbiome$Shannon ~ diversity_16S_microbiome$Group)
# linear model
anova(lm(Shannon ~ Group + as.factor(Sample_block), data = diversity_16S_microbiome))

