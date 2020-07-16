# Load the data
# This script also loads any necessary libraries
source("./scripts/load_data.R")

# In this script, we'll go over how to use ordination to compare the microbiome/resistome composition
# in our data.

# A lot of the following code was adapted from the following website:
# "http://joey711.github.io/phyloseq/plot_ordination-examples"


# Filtering low abundance phyla prior to normalization.
# For this example, we'll just choose an arbitrary value of 5 as the threshold for
# for filtering out ASVs with low abundance.
filtered_microbiome.ps = filter_taxa(microbiome.ps, function(x) sum(x) > 5, TRUE)

# We'll use CSS normalized values, so we need to convert to a metagenomeSeq object
filtered_microbiome.metaseq <- phyloseq_to_metagenomeSeq(filtered_microbiome.ps)

# This is where we perform the CSS normalization
microbiome.metaseq <- cumNorm(filtered_microbiome.metaseq)

# Like phyloseq, metagenomeSeq has it's own functions for accessing their data.
# Here, we need to use MRcounts() and re-make the phyloseq object with the normalized counts
CSS_microbiome_counts <- MRcounts(microbiome.metaseq, norm = TRUE)
# Use the new counts and merge with components from our original phyloseq object.
CSS_normalized_qiime.ps <- merge_phyloseq(otu_table(CSS_microbiome_counts, taxa_are_rows = TRUE),sample_data(microbiome.ps),tax_table(microbiome.ps), phy_tree(microbiome.ps))

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



################################
#                              #
#         Ordination           #
#                              #
################################

# Calculate the distance matrix
# Check out this website for more options you can use in the "method" and "distance" flags
ordination_phylum_bray <- ordinate(CSS_normalized_phylum_qiime.ps, method = "NMDS" , distance="bray")

# We can use "plot_ordination()" to plot the distance matrix
# We specify that we want to compare "samples" and color the points by the "Group" metadata variable
plot_ordination(CSS_normalized_phylum_qiime.ps, ordination_phylum_bray, type = "samples",color = "Group")

# You can also view the ordination, this time comparing the taxa
plot_ordination(CSS_normalized_phylum_qiime.ps, ordination_phylum_bray, type = "taxa",color = "phylum")

# Another option is to use the "split" type to create 2 split figures
split_ord_plot <- plot_ordination(CSS_normalized_phylum_qiime.ps, ordination_phylum_bray, type = "split",color = "phylum", shape = "Group")
split_ord_plot

#
## More plotting options
#

# Remember, we can make plots with phyloseq functions and then modify them with 
# ggplot2 layers.
phylum_ord_plot <- plot_ordination(CSS_normalized_phylum_qiime.ps, ordination_phylum_bray, type = "samples",color = "Group", shape = "Group")
phylum_ord_plot

# For example, you can add a polygon around sample groups, but doesn't work as well 
# when the sample groups don't cluster
phylum_ord_plot +  geom_polygon(aes(fill=Group)) + 
  geom_point(size=5) +
  ggtitle("Microbiome ordination at the phylum level by sample group")

phylum_ord_plot <- plot_ordination(CSS_normalized_phylum_qiime.ps, ordination_phylum_bray, type = "samples",color = as.factor(Lot), shape = "Group")


################################
#                              #
#     Phyloseq ordination      #
#     method demonstration     #
#                              #
################################

# As you saw in the example above, the "ordinate()" function requires that you
# specify the ordination "method" and "distance" measure.

# Below, we'll use some fancy code from this website: 
# http://joey711.github.io/phyloseq/plot_ordination-examples#four_main_ordination_plots
# We'll make a bunch of figures to plot the results from using different ordination
# methods on our dataset.
library(plyr) # Another package here that we didn't install in Lesson 1, sorry!

# We'll use bray curtis
dist = "bray"
# And the following ordination methods. Look here for more information: https://mb3is.megx.net/gustame/dissimilarity-based-methods/nmds
ord_meths = c("DCA", "CCA", "RDA", "DPCoA", "NMDS", "MDS", "PCoA")
# Use the "llply()" function to go through our list of ord_meths, ordinate the data,
# and then add it all in a list called "plist"
plist = llply(as.list(ord_meths), function(i, physeq, dist){
  ordi = ordinate(physeq, method=i, distance=dist)
  plot_ordination(physeq, ordi, "samples", color="Group")
}, CSS_normalized_phylum_qiime.ps, dist)
names(plist) <- ord_meths # name the objects in the list

# This next command reads the plist and converts it into a dataframe
pdataframe = ldply(plist, function(x){
  df = x$data[, 1:2]
  colnames(df) = c("Axis_1", "Axis_2")
  return(cbind(df, x$data))
})
# Change the name of the first column.
names(pdataframe)[1] = "method"

# Visualize the results
p = ggplot(pdataframe, aes(Axis_1, Axis_2, color=Group, shape=Group, fill=Group))
p = p + geom_point(size=4) + geom_polygon()
p = p + facet_wrap(~method, scales="free")
p = p + scale_fill_brewer(type="qual", palette="Set1")
p = p + scale_colour_brewer(type="qual", palette="Set1")
p


################################
#                              #
#     Phyloseq ordination      #
#   distance demonstration     #
#                              #
################################

# Now, we can modify the code above to instead demonstrate some of the different
# distance matrices that can be calculated.

# Let's select just a few different distance measures
dist_list = c("bray","manhattan", "euclidean", "jaccard","binomial","gower")
# Now we'll just use one method, NMDS
ord_meths = "NMDS"
# Use the "llply()" function to go through our list of ord_meths, ordinate the data,
# and then add it all in a list called "plist"
dist_list

plist = llply(as.list(dist_list), function(i, physeq, ord_meths){
  ordi = ordinate(physeq, method=ord_meths, distance=i)
  plot_ordination(physeq, ordi, "samples", color="Group")
}, CSS_normalized_phylum_qiime.ps, ord_meths)
names(plist) <- dist_list # name the objects in the list


# This next command reads the plist and converts it into a dataframe
pdataframe = ldply(plist, function(x){
  df = x$data[, 1:2]
  colnames(df) = c("Axis_1", "Axis_2")
  return(cbind(df, x$data))
})
# Change the name of the first column.
names(pdataframe)[1] = "distance_measure"

# Visualize the results
p2 = ggplot(pdataframe, aes(Axis_1, Axis_2, color=Group, shape=Group, fill=Group))
p2 = p2 + geom_point(size=4) + geom_polygon()
p2 = p2 + facet_wrap(~distance_measure, scales="free")
p2 = p2 + scale_fill_brewer(type="qual", palette="Set1")
p2 = p2 + scale_colour_brewer(type="qual", palette="Set1")
p2



################################
#                              #
#   Statistical comparisons    #
#                              #
################################

#
## Analysis of similarities (ANOSIM)
#

# The anosim function performs a non-parametric test of the significance of the 
# sample-grouping variable you provide against a permutation-based null distribution.

# First, make the R object with the sample grouping variable.
# ANOSIM only allows for the comparison of samples from 2 different groups.
group_variable = get_variable(CSS_normalized_phylum_qiime.ps,"Group")

# Phyloseq uses functions like "ordinate()" and "plot_ordination()" to wrap a bunch of 
# functions from other packages too. For the last few steps in this script, you'll see
# a bunch of functions from the "vegan" R package.
anosim_phylum_by_group = anosim(distance(CSS_normalized_phylum_qiime.ps, "bray"), group_variable)
anosim_phylum_by_group

plot(anosim_phylum_by_group)

#
## Permunation MANOVA (adonis)
#

# The creators of the vegan package suggest that using permunation MANOVA, as implemented
# in the "adonis()" function is a "more robust alternative". 
# Importantly, using "adonis()" allows us to make comparisons between sample groups 
# while modeling for the effect from multiple variables.

# We'll need to convert our data to a data.frame object
df = as.data.frame(sample_data(CSS_normalized_phylum_qiime.ps))
# Calculate distance on phyloseq object
d = distance(CSS_normalized_phylum_qiime.ps, "bray")
# Create the perMANOVA model
adonis_phylum_by_Group_Lot = adonis(d ~ Group + Lot, df)
adonis_phylum_by_Group_Lot

plot(adonis_phylum_by_Group_Lot$aov.tab)
