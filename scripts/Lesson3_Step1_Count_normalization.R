# Load the data
# This script also loads any necessary libraries
source("./scripts/load_data.R")

# So far, we've only used raw counts of "mapped" or "aligned" reads.
# In general, we use raw counts to report mapping statistics and to calculate diversity indices.

# On the other hand, for further analysis such as ordination and testing for differential
# feature abundance we typically have to "normalize" sample counts. In this script, we'll go over
# normalization methods to account for differences in sequencing depth between samples.

# We'll use the 16S microbiome dataset, go over why we need to normalize counts,
# and then go over a few examples of different normalization techniques.

# While we normalize counts based on the entire dataset (prior to taxa aggregation), in this step
# we'll aggregate counts to the phylum level for easier processing and visualization.
# If you are curious, you can try plotting the entire dataset to test how your computer handles it. 
phylum_qiime.ps <- tax_glom(microbiome.ps, "phylum")

# Just visually, we can observe differences in the number of total mapped reads between samples
plot_raw_qiime_phylum <- plot_bar(phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  labs(title= "Raw qiime microbiome counts") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 6, angle = 45),
        panel.background = element_blank(),
        legend.title = element_text( size=8), 
        legend.text=element_text(size=8))
plot_raw_qiime_phylum

# By looking at the mapped reads for each taxa, we can clearly see the variability of count 
# distribution for different taxa.
# Notice that some features are only present in a few samples, this is what a "sparse"
# dataset looks like.
plot_bar(phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ phylum, scales = "free") +
  theme_classic()


# For count normalization, we have a few options available including:
# median sequencing depth, total sum scaling, rarefying, and cumulative sum scaling. 

# Additionally, we might consider further processing our data prior to normalization.
# We'll review a few examples of how to filter our data and then move on to count normalization.

################################
#                              #
#       Data processing        #
#                              #
################################


#
## Filtering specific taxa
#

# In the figures above, you probably noticed the taxa named "p__". This signifies that some features
# were not classified at the phylum level and only received a label for the kingdom.
# Below, we'll remove this feature using "prune_taxa()"

# First, we need to know the name of the "ASV" feature that corrresponds with the phylum label "p__"
# This is trickier than it should be, but we can see the ASV name from the phylum aggregated counts.
tax_table(phylum_qiime.ps)

# We then need to take the taxa_names from the entire dataset and use "setdiff()" to get
# all of the taxa features we want to keep (excluding the "p__" feature)
goodTaxa <- setdiff(taxa_names(phylum_qiime.ps), "9f55ae2ce9e1a8f8ea202f5e507017d8")
# Use "prune_taxa()"
clean_phylum_qiime.ps = prune_taxa(goodTaxa, phylum_qiime.ps)

# Notice, just the phylum label "p__" is gone.
plot_bar(clean_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  theme_classic()


#
## Removing samples with low counts
#

# Alternatively, you might want to only keep samples containing more than X counts
test_clean_phylum_qiime.ps = prune_samples(sample_sums(clean_phylum_qiime.ps)>=100000, clean_phylum_qiime.ps)

# Notice, one sample was removed.
plot_bar(test_clean_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  theme_classic()


#
## Subsetting taxa
#

# We might want to focus on a specific taxon, so we can use the "subset_taxa()" function on
# the raw count dataset
firmicutes_microbiome.ps = subset_taxa(clean_phylum_qiime.ps, phylum=="p__Firmicutes")
# The error you get is due to the phylogenetic tree that we can't subset from the full dataset.

plot_bar(firmicutes_microbiome.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  theme_classic()

#
## Filtering low abundance taxa
#

# Prior to using the full dataset for count normalization, we might choose a threshold of 
# counts that each taxa much meet. For a simple example, we'll use "50" counts as the minimum threshold.
filtered_microbiome.ps = filter_taxa(microbiome.ps, function(x) sum(x) > 50, TRUE)
# Notice the change in taxa number, aggregate to phylum level
filtered_phylum_qiime.ps <- tax_glom(filtered_microbiome.ps, "phylum")

# Plot mapped counts for each sample, faceted by treatment group
plot_filtered_raw_qiime_phylum <- plot_bar(filtered_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  labs(title= "Raw qiime microbiome counts") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 6, angle = 45),
        panel.background = element_blank(),
        legend.title = element_text( size=8), 
        legend.text=element_text(size=8))
plot_filtered_raw_qiime_phylum

# Plot mapped counts for each sample, faceted by taxa
plot_bar(filtered_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ phylum, scales = "free") +
  theme_classic()

################################
#                              #
#        Normalization         #
#                              #
################################

# We went over a few different things above as we explored our data, but ultimately you'll
# have to decide on what filtering steps to run prior to count normalization.

# For the examples below, we'll use the full microbiome dataset and look at how the results
# at the phylum level are affected.

#
##
### Rarefying
##
#

# Another common method for 16S datasets is rarefying. In this approach, we find the sample
# with the lowest counts and then subsample the other samples down to this value.

# Because we are randomly subsampling our dataset, we have to set the "random seed" in our 
# R session for reproducibility.
set.seed(42) # choose any number, or use an R function to choose a random value for you.

# Rarefy using the filtered qiime2 dataset
rarefied_qiime.ps <- rarefy_even_depth(filtered_microbiome.ps, sample.size = min(sample_sums(filtered_microbiome.ps)))

# Here's an example of what it would look like if you try rarefying your raw count data.
# Notice that some OTUs (ASVs) are lost after rarefying.
test_rarefied_qiime.ps <- rarefy_even_depth(microbiome.ps, sample.size = min(sample_sums(microbiome.ps)))

# Aggregate counts to phylum
rarefied_phylum_qiime.ps <- tax_glom(rarefied_qiime.ps, "phylum")
# Bar plot to visualize results
plot_rarefied_qiime_phylum <- plot_bar(rarefied_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  labs(title= "Rarefied qiime microbiome counts") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 6, angle = 45),
        panel.background = element_blank(),
        legend.title = element_text( size=8), 
        legend.text=element_text(size=8))
plot_rarefied_qiime_phylum
#
##
### Normalizing using total sum scaling
##
#

# Normalize counts using total sum scaling
# Notice we multiple the proportions by 1000000.
tss_normalized_qiime.ps  = transform_sample_counts(filtered_microbiome.ps, function(x) x / sum(x) *1000000)

# Aggregate counts to phylum
tss_normalized_phylum_qiime.ps <- tax_glom(tss_normalized_qiime.ps, "phylum")

# Notice the y-axis values are counts and not proportions.
plot_tss_qiime_phylum <- plot_bar(tss_normalized_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  labs(title= "TSS normalized qiime microbiome counts") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 8, angle = 45),
        panel.background = element_blank(),
        legend.title = element_text( size=10), 
        legend.text=element_text(size=10))
plot_tss_qiime_phylum

#
##
### Cumulative sum scaling (CSS)
##
#

# CSS is currently our preferred count normalization method to use for ordination and 
# differential abundance testing with the zero-inflated Gaussian model (ZIG). 

# CSS calculates the quantile of the count distribution of samples where they all should be roughly 
# equivalent and independent of each other up to this quantile under the assumption that, 
# at this range, counts are derived from a common distribution.

# Both CSS normalization and the ZIG model are implemented in the "metagenomeSeq" R library

# First, we convert the phyloseq object to metagenomeSeq
library(metagenomeSeq)
microbiome.metaseq <- phyloseq_to_metagenomeSeq(filtered_microbiome.ps)

# Check out this object:
microbiome.metaseq

# This is where we perform the normalization
microbiome.metaseq <- cumNorm(microbiome.metaseq)

# Like phyloseq, metagenomeSeq has it's own functions for accessing their data.
# Here, we need to use MRcounts() and re-make the phyloseq object with the normalized counts
CSS_microbiome_counts <- MRcounts(microbiome.metaseq, norm = TRUE)

# Use the new counts and merge with components from our original phyloseq object.
CSS_normalized_qiime.ps <- merge_phyloseq(otu_table(CSS_microbiome_counts, taxa_are_rows = TRUE),sample_data(filtered_microbiome.ps),tax_table(filtered_microbiome.ps), phy_tree(filtered_microbiome.ps))

# Aggregate counts to phylum
CSS_normalized_phylum_qiime.ps <- tax_glom(CSS_normalized_qiime.ps, "phylum")

# Notice the y-axis values are counts and not proportions.
plot_css_qiime_phylum <- plot_bar(CSS_normalized_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  labs(title= "CSS normalized qiime microbiome counts") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 6, angle = 45),
        panel.background = element_blank(),
        legend.title = element_text( size=8), 
        legend.text=element_text(size=8))
plot_css_qiime_phylum

#
##
### Normalizing to the median sequencing depth
##
#

# Normalize the entire dataset to the median sequencing depth
median_normalized_qiime.ps = transform_sample_counts(filtered_microbiome.ps, function(x, t=median(sample_sums(filtered_microbiome.ps))) round(t * (x / sum(x))))

# Aggregate counts to phylum
median_normalized_phylum_qiime.ps <- tax_glom(median_normalized_qiime.ps, "phylum")

# Notice the y-axis values are counts and not proportions.
plot_bar(median_normalized_phylum_qiime.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  theme_classic()



################################
#                              #
#   Visualizing the results    #
#                              #
################################

# You don't have to install the next package, but below is an example of how we can group
# multiple plots in a page. The "ggpubr" package has a lot of great functions for making
# publication-ready figures in combination with ggplot2.
library(ggpubr) # use "install.packages()" first if you don't have this package

# Below, we can use the "ggarrange()" to group our 4 plots saved from above.
# Notice, we can use "common.legend" to specify that we only need one legend.
# We also can add a label for each plot.
combined_figures <- ggarrange(plot_filtered_raw_qiime_phylum  + rremove("x.text"),plot_tss_qiime_phylum  + rremove("x.text"),
          plot_rarefied_qiime_phylum,plot_css_qiime_phylum, common.legend = TRUE,
           legend = "right", labels = c("A)", "B)", "C)","D)"))
combined_figures

# Additionally, you can further annotate your figures using the "annotate_figure" function
annotate_figure(combined_figures,
                bottom = text_grob("Data source: 16S rRNA sequencing of beef feedlot cattle feces", color = "blue",
                                   hjust = 1, x = 1, face = "italic", size = 8))

