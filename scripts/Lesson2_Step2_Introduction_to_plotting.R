##### Set up environment
library("phyloseq")
library("dplyr")
library("ggplot2")
library("data.table")
library("tidyr")
library("forcats")

# http://deneflab.github.io/MicrobeMiseq/demos/mothur_2_phyloseq.html

# Let's erase any objects that might still be in your environment
rm(list=ls()) 

# Like in Lesson 2 step 1, we have to load all of our data into R first. 
# Lookover the script named "load_data.R". We made this script by just taking the pertinent code from Step 2 lesson 1

# We can run the script with the following command and load all of our data.
source("./scripts/load_data.R")

# Check out the R objects that were created:
ls()

# We'll use the 3 phyloseq objects, the "combined_diversity_values" object, and "sample_metadata" for all the steps below.

# The sample metadata file has 28 rows, one per sample.
# We can make a simple boxplot to visualize the values in a column. Y value (Observed) by (~) X value (Group) 
boxplot(sample_metadata$Shotgun_raw_reads ~ sample_metadata$Group)

# Check out all of the variables that we have in the combined_diversity_values.
# The first half is all of the diversity values we calculated with the function "estimate_richness()"
# The second half is the original metadata file
colnames(combined_diversity_values) # In addition to the "SeqType" variable, we also added the "DataType" variable. 

# This object is in "long" or "melted" form. 
# Meaning, we had 28 samples analyzed using 3 different approaches, 16S microbiome, shotgun microbiome, and shotgun resistome
# We calculated diversity values for each datatype and merged the results into the "combined_diversity_values" object
# Each sample and analysis type gets a row in the R object for a total of 84 rows:
combined_diversity_values$DataType

combined_diversity_values$SeqType # We used shotgun sequencing for both the microbiome and resistome

# Using the "base graphics", we went over a few examples in the past steps. 
# Here's a simple boxplot of the # of features Observed (Richness)
boxplot(combined_diversity_values$Observed ~ combined_diversity_values$DataType)

#
##
### ggplot layers
##
#

# We can create the initial plot by specifying the data that we'll be using and the x and y variables (columns)
# We'll group samples by treatment groups on the x-axis and plot the number of Shotgun raw reads for each sample
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads))

# A blank ggplot is drawn. Even though the x and y are specified, there are no points or lines in it.
# This is because, ggplot doesn’t assume that you meant a scatterplot or a line chart to be drawn.
# We've only told ggplot what dataset to use and what columns should be used for X and Y axis, but we 
# haven’t explicitly asked it to draw any points.

# Also note that aes() function is used to specify the X and Y axes. 
# That’s because, any information that is part of the source dataframe has to be specified inside the aes() function.

# To create a boxplot, we can add a "geom" layer, geom_boxplot()
# Other options include (and many others)
# geom_point()
# geom_line()
# geom_bar()

# Here's an example of a boxplot
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads)) + 
  geom_boxplot()

# Or we can turn this figure into a graph with points
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads)) + 
  geom_point()

# We can add color based on another variable
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot()


# Specifying the aesthetics "aes()" in the plot vs. in the layers
# Aesthetic mappings can be supplied in the initial ggplot() call, in individual layers, or in some combination of both. 
# All of these calls create the same plot specification:
ggplot(sample_metadata, aes(Group, Shotgun_raw_reads, color = Group)) + 
  geom_boxplot()
ggplot(sample_metadata, aes(Group, Shotgun_raw_reads)) + 
  geom_boxplot(aes(color = Group))
ggplot(sample_metadata, aes(Group)) + 
  geom_boxplot(aes(y = Shotgun_raw_reads, color = Group))
ggplot(sample_metadata) + 
  geom_boxplot(aes(Group, Shotgun_raw_reads, color = Group))

# Each of the labels has different arguments you can use to change the aesthetics.
ggplot(sample_metadata, aes(Group, Shotgun_raw_reads, color = Group)) + 
  geom_boxplot(fill= "grey")

# Or we can color based on unique factors
ggplot(sample_metadata, aes(Group, Shotgun_raw_reads, color = Group)) + 
  geom_boxplot(aes(fill= Group))

# We can also add other layers
ggplot(sample_metadata, aes(Group, Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_point()

# There are many options for layers to add, so be sure to search online for your specific needs
ggplot(sample_metadata, aes(Group, Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1)


#
##
### ggplot labels
##
#

# We can also add layers with labels for the graph using ggtitle(), xlab(), ylab(), and labs
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  ggtitle("Shotgun metagenomic sequencing results")

# We can change the x and y axis labels with labs()
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  ggtitle("Shotgun metagenomic sequencing results") +
  labs(x = "Treatment group", y = "raw paired reads")

# Or we can use xlab() and ylab()
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  ggtitle("Shotgun metagenomic sequencing results") +
  ylab("raw paired reads") +
  xlab("Treatment group")

# You can add a caption
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(caption = "(based on data from...)")

# Or a tag, for when labelling a subplot with a letter
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(tag = "A")

#
##
### ggplot themes
##
#

# ggplot has a lot of ways to alter the color schemes and the overall aesthetic of the graph
# we like using "theme()" as an easy way to try other color formatting

# You can alter each specific part of the theme, or use predefined themes such as "theme_classic()" shown below
# Again, there are so many options for what you can modify in the theme(), so look up what you need online and you'll probably find it
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme(axis.text.x = element_text( size = 18),
        axis.text.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5),
        panel.background = element_blank())

# Here's "theme_classic()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic()
 
# Here's "theme_minimal()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_minimal()

# Here's "theme_bw()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_bw()

# Here's "theme_dark()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_dark()


#
##
### ggplot facets
##
#

# So far, we've only plotted one column at a time from our metadata file.
# With data in the "long" or "melted" form, we get a few more options for plotting more data

# For example, our sample_metadata file has 12 columns.
# We can "gather" these results so that the 4 column with read numbers is made into a unique row for each sample.
# We use the "-" to specify which variables to maintain in the new object, but not use for making unique combinations

melted_metadata <- gather(sample_metadata, Paired_reads, Value, -Group , -Sample, -Lot, -Host, -Matrix, -Head, -PREVCAT_A_APLUS, -PREVCAT_ALL)

# For the next command, we want to make a new variable, "SeqType"
# Notice we use the "ifelse()" function to check for rows in the $Paired_reads column that starts with "X16". 
# If it finds that name, it makes "16S sequencing" the new value for the new column SeqType,
# Else, the value is "shotgun sequencing"
melted_metadata <- melted_metadata %>% 
  mutate(SeqType = ifelse(startsWith(melted_metadata$Paired_reads, "X16S"), "16S sequencing", "shotgun sequencing")) %>%
  mutate(Paired_reads = fct_relevel(Paired_reads,"X16S_Raw_paired_reads", "X16S_Filtered_paired_reads","Shotgun_raw_reads","Shotgun_nonhost_reads"))

# Plot the results without ordering the factors
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic()

# Note that the factors are ordered alphabetically, but we can also change the order of the factors by using "fct_relevel"
melted_metadata <- melted_metadata %>% 

# Plot the results with ordered factors
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic()


# It can also be useful to make "facets" for splitting data into multiple figures
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() +
  facet_wrap( ~ SeqType)

# We can also make sure the scales are free to change depending on the facet.
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() +
  facet_wrap( ~ SeqType, scales = "free")



#
##
### Sample metadata figures
##
#


# A common figure we'll include is just a barplot of sequencing results
# Notice the extra flags we used in "geom_bar()". Below, we'll make a stacked bar plot leave out the "position" flag
fig1 <- ggplot(melted_metadata, aes(x = Sample , y = Value, fill = Paired_reads)) + 
  geom_bar(stat="identity", position = position_dodge()) +
  labs(title = "Shotgun metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() 
fig1

# We often present the differences in sequencing depth between treatment groups. 
# We can make a boxplot to show the spread of values by treatment group and sequencing type.
fig2 <- ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results by treatment group", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() +
  facet_wrap( ~ SeqType, scales = "free")
fig2

# Here's the corresponding summary values that we can include in a table
# We'll test for statistically significant differences between sample groups in Lesson 2 step 3
melted_metadata %>%
  group_by(Paired_reads) %>%
  summarize(mean_paired_reads = mean(Value), median_paired_reads = median(Value), 
            min_paired_reads = min(Value), max_paired_reads = max(Value))


# Other variables that should be tested for systematic bias in sequencing include:
# batch effects in collection, DNA extraction, and sequencing 



#
##
### Diversity indices
##
#

# We can use similar figures to explore the "combined_diversity_values" object
ggplot(combined_diversity_values, aes(x = Group, y = Observed, color = Group)) +
  geom_boxplot() +
  labs(title = "Unique features by data type", x = "Treatment group", y = "Observed features") + 
  theme_classic() +
  facet_wrap( ~ DataType, scales = "free")







#
##
### ggplot facets
##
#
