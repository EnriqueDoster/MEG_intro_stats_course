##### Set up environment
library("phyloseq")
library("dplyr")
library("ggplot2")
library("data.table")
library("tidyr")
library("forcats")
library("vegan")

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
  ggtitle("Metagenomic sequencing results")

# We can change the x and y axis labels with labs()
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  ggtitle("Metagenomic sequencing results") +
  labs(x = "Treatment group", y = "raw paired reads")

# Or we can use xlab() and ylab()
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  ggtitle("Metagenomic sequencing results") +
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
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme(axis.text.x = element_text( size = 18),
        axis.text.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5),
        panel.background = element_blank())

# Here's "theme_classic()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic()
 
# Here's "theme_minimal()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_minimal()

# Here's "theme_bw()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_bw()

# Here's "theme_dark()" 
ggplot(sample_metadata, aes(x = Group , y = Shotgun_raw_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
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
# We use the "-" to specify which variables to maintain in the new object, but should not be used for making unique combinations

melted_metadata <- gather(sample_metadata, Paired_reads, Value,
                          -Group , -Sample, -Lot, -Host, -Matrix, -Head, -PREVCAT_A_APLUS, -PREVCAT_ALL,
                          -Sample_block, -shotgun_seq_lane, -shotgun_mean_phred_scores)

# For the next command, we want to make a new variable, "SeqType"
# Notice we use the "ifelse()" function to check for rows in the $Paired_reads column that starts with "X16". 
# If it finds that name, it makes "16S sequencing" the new value for the new column SeqType,
# Else, the value is "shotgun sequencing"
melted_metadata <- melted_metadata %>% 
  mutate(SeqType = ifelse(startsWith(melted_metadata$Paired_reads, "X16S"), "16S sequencing", "shotgun sequencing"))

# Plot the results without ordering the factors
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic()

# Note that the factors are ordered alphabetically, but we can also change the order of the factors by using "fct_relevel"
melted_metadata <- melted_metadata %>% 
  mutate(Paired_reads = fct_relevel(Paired_reads,"X16S_Raw_paired_reads", "X16S_Filtered_paired_reads","Shotgun_raw_reads","Shotgun_nonhost_reads"))

# Plot the results with ordered factors
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic()


# It can also be useful to make "facets" for splitting data into multiple figures
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() +
  facet_wrap( ~ SeqType)

# We can also make sure the scales are free to change depending on the facet.
ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
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
  labs(title = "Metagenomic sequencing results", x = "Sample", y = "raw paired reads") + 
  theme_classic() 
fig1

# We often present the differences in sequencing depth between treatment groups. 
# We can make a boxplot to show the spread of values by treatment group and sequencing type.
fig2 <- ggplot(melted_metadata, aes(x = Group , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Metagenomic sequencing results by treatment group", x = "Treatment group", y = "raw paired reads") + 
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
# sample blocks made in the study design, batch effects in sample collection, DNA extraction, and sequencing 

# As an example, here's a plot comparing shotgun sequencing results based on study design sample block
# Notice that we used "as.factor()" because the values in Sample_block are integers. Check what happens if you don't use as.factor()
fig3 <- ggplot(melted_metadata, aes(x = as.factor(Sample_block) , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results by sample block", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() +
  facet_wrap( ~ SeqType, scales = "free")
fig3

# For another example, we are often interested in the effect of sequencing lane with shotgun metagenomic sequencing
fig4 <- ggplot(melted_metadata, aes(x = as.factor(shotgun_seq_lane) , y = Value, color = Paired_reads)) + 
  geom_boxplot() +
  labs(title = "Shotgun metagenomic sequencing results by sequencing lane", x = "Treatment group", y = "raw paired reads") + 
  theme_classic() +
  facet_wrap( ~ SeqType, scales = "free")
fig4



#
##
### Diversity indices
##
#

# We use diversity indices to summarize the # of unique features (richness) and how the counts are distributed (evenness)

# Here, we plot the observed values for by treatment group, faceted by DataType
fig5 <- ggplot(combined_diversity_values, aes(x = Group, y = Observed, color = Group)) +
  geom_boxplot() +
  labs(title = "Unique features by treatment group and data type", x = "Treatment group", y = "Observed features") + 
  theme_classic() +
  facet_wrap( ~ DataType, scales = "free")
fig5

# And here, we can plot the evenness using Shannon's index
fig6 <- ggplot(combined_diversity_values, aes(x = Group, y = Shannon, color = Group)) +
  geom_boxplot() +
  labs(title = "Unique features by data type", x = "Treatment group", y = "Observed features") + 
  facet_wrap( ~ DataType, scales = "free")+
  scale_color_grey()
fig6


# Remember, these diversity indices were calculated based on the entire dataset containing all features.
# Often, you'll want to aggregate your counts to other taxonomic levels and calculate diversity indices on those counts.

# Here's an example of how we can do that at the phylum level for the microbiome and drug class level for the resistome
# The code below is just like what you saw in Lesson 2 step 1

# Aggregate counts to the phylum level, calculate diversity values, and mutate the object to include SeqType and DataType
phylum_kraken.ps <- tax_glom(kraken_microbiome.ps, "phylum")
phylum_kraken_shotgun_diversity_values <- estimate_richness(phylum_kraken.ps)
phylum_kraken_shotgun_diversity_values <- phylum_kraken_shotgun_diversity_values %>%
  mutate(SeqType = "shotgun", DataType = "shotgun microbiome", Sample = row.names(phylum_kraken_shotgun_diversity_values))

# Aggregate counts to the phylum level, calculate diversity values, and mutate the object to include SeqType and DataType
phylum_qiime.ps <- tax_glom(microbiome.ps, "phylum")
phylum_qiime_diversity_values <- estimate_richness(phylum_qiime.ps)
phylum_qiime_diversity_values <- phylum_qiime_diversity_values %>%
  mutate(SeqType = "16S", DataType = "16S microbiome", Sample = row.names(phylum_qiime_diversity_values))

# Aggregate counts to the drug class level, calculate diversity values, and mutate the object to include SeqType and DataType
class_amr.ps <- tax_glom(amr.ps, "class")
class_amr_shotgun_diversity_values <- estimate_richness(class_amr.ps)
class_amr_shotgun_diversity_values <- class_amr_shotgun_diversity_values %>%
  mutate(SeqType = "shotgun", DataType = "resistome", Sample = row.names(class_amr_shotgun_diversity_values))

# Now we can merge these tables based on identical row
phylum_and_class_combined_diversity_values <- bind_rows(phylum_kraken_shotgun_diversity_values, phylum_qiime_diversity_values,class_amr_shotgun_diversity_values)

# Add the metadata file to the new object
phylum_and_class_combined_diversity_values <- left_join(phylum_and_class_combined_diversity_values, sample_metadata, by = "Sample")

# Create boxplots for observed features at the phylum and drug class levels
fig7 <- ggplot(phylum_and_class_combined_diversity_values, aes(x = Group, y = Observed, color = Group)) +
  geom_boxplot() +
  labs(title = "Unique phyla and resistome AMR drug classes by data type", x = "Treatment group", y = "Observed features") + 
  theme_classic() +
  facet_wrap( ~ DataType, scales = "free")
fig7


#
##
### Microbiome plots
##
#

# When plotting the microbiome, we often focus on aggregate counts
# We saw that we can use phyloseq to easily make barplots like this:
plot_bar(phylum_qiime.ps, fill = "phylum")

# The cool thing is that phyloseq plays nicely with ggplot and you use what you learned above to modify these figures
plot_bar(phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  theme_classic()

# You can also make facets based on the unique phyla in the phyloseq object
# Notice we had to specify that we want "free" scales on both axes
plot_bar(phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ phylum, scales = "free") +
  theme_classic()


#
##
### Filtering out low abundance samples
##
#

# As you saw in the figures above, you can end up with too many features that make your figures messy.
# To solve this, we can filter out features that are in low abundance

# only keep OTUs present in greater than 0.5% of all OTUs across all samples.
minTotRelAbun = 0.005
x = taxa_sums(phylum_qiime.ps)
keepTaxa = (x / sum(x)) > minTotRelAbun
length(keepTaxa[keepTaxa ==TRUE])
pruned_phylum_qiime.ps = prune_taxa(keepTaxa, phylum_qiime.ps)
plot_bar(pruned_phylum_qiime.ps, fill = "phylum")


#
##
### Converting data to relative abundances
##
#

# We'll talk more about how to we can account for differences in sequencing depth between samples with count normalization.
# One of the easiest way we can begin to compare the microbiome and resistome composition is by plotting relative abundance
##### Convert OTU abundances to relative abundances
phylum_qiime.ps.rel <- transform_sample_counts(phylum_qiime.ps, function(x) x / sum(x) )

# We can plot these results, notice the y-axis relative abundance plots
plot_bar(phylum_qiime.ps.rel, fill= "phylum")

# We can use the phyloseq object for some of these exploratory figures, but we recommend converting the data into "long" format
phylum_qiime.ps.rel.melt <- psmelt(phylum_qiime.ps.rel)
head(phylum_qiime.ps.rel.melt)

# We can see that we still have 40 unique phyla in this object
unique(phylum_qiime.ps.rel.melt$phylum)

# Lets change the names of phyla to "low abundance phyla" for features present at a relative
# proportion less than 0.05 across all samples
phylum_qiime.ps.rel.melt <- phylum_qiime.ps.rel.melt %>%
  group_by(phylum) %>%
  mutate(mean_phylum_rel_abundance = mean(Abundance))

phylum_qiime.ps.rel.melt$phylum <- as.character(phylum_qiime.ps.rel.melt$phylum)
phylum_qiime.ps.rel.melt$mean_phylum_rel_abundance <- as.numeric(phylum_qiime.ps.rel.melt$mean_phylum_rel_abundance)

phylum_qiime.ps.rel.melt$phylum[phylum_qiime.ps.rel.melt$mean_phylum_rel_abundance < 0.005] <- "Low abundance phyla"

##### Plot phyla relative abundances
ggplot(phylum_qiime.ps.rel.melt, aes(x = Sample, y = Abundance, fill = phylum)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Group, scales = "free") +
  theme_classic()


## We can use the data in long form with the dplyr functions we learned to summarize the results

# Mean relative abundance of phyla across all samples
phylum_qiime.ps.rel.melt %>%
  group_by(phylum) %>%
  summarize(mean_rel_abundance = mean(Abundance)) %>%
  arrange(-mean_rel_abundance)

# Mean relative abundance of phyla by treatment group
phylum_qiime.ps.rel.melt %>%
  group_by(Group, phylum) %>%
  summarize(mean_rel_abundance = mean(Abundance)) %>%
  arrange(-mean_rel_abundance)



#
##
### Rarefaction plots
##
#

# Rarefaction is a technique used to estimate how many features (labeled "species") would be identified
# at different sequencing depths (labeled "Sample Size"). 

# Generally, if the curves are relatively flat at the actual sample size, this suggests adequate sequencing depth.
# Alternatively, steep curves suggest that increasing the sequencing depth 

# Rarefaction for the qiime2 microbiome at the phylum level
# Notice, that we had to get the "otu_table()" from the phyloseq object, then we had use "t()" to transpose the table
phylum_qiime_rarefaction <- rarecurve(t(otu_table(phylum_qiime.ps)), step = 200, se = TRUE)
# Let's see if the rarefaction looks different at the genus level
genus_qiime.ps <- tax_glom(microbiome.ps, "genus")
genus_qiime_rarefaction <- rarecurve(t(otu_table(genus_qiime.ps)), step = 200, se = TRUE)

# Rarefaction for the kraken microbiome at the phylum level
# All samples had 40 phyla
phylum_kraken_rarefaction <- rarecurve(t(otu_table(phylum_kraken.ps)), step = 200, se = TRUE)
# Let's see if the rarefaction looks different at the genus level
genus_kraken.ps <- tax_glom(kraken_microbiome.ps, "genus")
genus_kraken_rarefaction <- rarecurve(t(otu_table(genus_kraken.ps)), step = 200, se = TRUE)

# Rarefaction for the resistome at the AMR drug class level
class_amr_rarefaction <- rarecurve(t(otu_table(class_amr.ps)), step = 200, se = TRUE)
# Let's see if the rarefaction looks different at the AMR gene group level
group_amr.ps <- tax_glom(amr.ps, "group")
group_amr_rarefaction <- rarecurve(t(otu_table(group_amr.ps)), step = 200, se = TRUE)


#
##
### Exporting figures
##
#

# To export figures, we can output a jpeg file if we first run the command to view the plot, then run ggsave()
fig1
# This will save to your working directory
ggsave("fig1_barplot_sequencing_results_by_sample.jpeg", width = 60, height = 30, units = "cm") 

fig2
ggsave("fig2_barplot_sequencing_results_by_sequencing_type.jpeg", width = 60, height = 30, units = "cm") 



