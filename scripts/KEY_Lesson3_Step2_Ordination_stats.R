# key for Lesson 3 step 2 to analyze the resistome data
# Load the data
source("./scripts/load_data.R")

# In this script, we'll go over how to use ordination to compare the microbiome/resistome composition
# in our data.

# A lot of the following code was adapted from the following website:
# "http://joey711.github.io/phyloseq/plot_ordination-examples"


# Filtering low abundance phyla prior to normalization.
# For this example, we'll just choose an arbitrary value of 5 as the threshold for
# for filtering out ASVs with low abundance.
filtered_amr.ps = filter_taxa(amr.ps, function(x) sum(x) > 5, TRUE)

# We'll use CSS normalized values, so we need to convert to a metagenomeSeq object
filtered_amr.metaseq <- phyloseq_to_metagenomeSeq(filtered_amr.ps)

# This is where we perform the CSS normalization
amr.metaseq <- cumNorm(filtered_amr.metaseq)

# Like phyloseq, metagenomeSeq has it's own functions for accessing their data.
# Here, we need to use MRcounts() and re-make the phyloseq object with the normalized counts
CSS_amr_counts <- MRcounts(amr.metaseq, norm = TRUE)
# Use the new counts and merge with components from our original phyloseq object.

#
## NB. We had to remove the phy_tree() option that we used for the microbiome data.
#
CSS_normalized_qiime.ps <- merge_phyloseq(otu_table(CSS_amr_counts, taxa_are_rows = TRUE),sample_data(amr.ps),tax_table(amr.ps))

# Aggregate counts to class
CSS_normalized_class_qiime.ps <- tax_glom(CSS_normalized_qiime.ps, "class")

# Notice the y-axis values are counts and not proportions.
plot_css_qiime_class <- plot_bar(CSS_normalized_class_qiime.ps, fill = "class") + 
  facet_wrap(~ Group, scales = "free_x") +
  labs(title= "CSS normalized qiime amr counts") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 6, angle = 45),
        panel.background = element_blank(),
        legend.title = element_text( size=8), 
        legend.text=element_text(size=8))
plot_css_qiime_class



################################
#                              #
#         Ordination           #
#                              #
################################

# Calculate the distance matrix
# Check out this website for more options you can use in the "method" and "distance" flags
ordination_class_bray <- ordinate(CSS_normalized_class_qiime.ps, method = "NMDS" , distance="bray")

# We can use "plot_ordination()" to plot the distance matrix
# We specify that we want to compare "samples" and color the points by the "Group" metadata variable
plot_ordination(CSS_normalized_class_qiime.ps, ordination_class_bray, type = "samples",color = "Group")

# You can also view the ordination, this time comparing the taxa
plot_ordination(CSS_normalized_class_qiime.ps, ordination_class_bray, type = "taxa",color = "class")

# Another option is to use the "split" type to create 2 split figures
split_ord_plot <- plot_ordination(CSS_normalized_class_qiime.ps, ordination_class_bray, type = "split",color = "class", shape = "Group")
split_ord_plot

# We can visualize both comparisons at the same time using "biplot" 
biplot_ord_plot <- plot_ordination(CSS_normalized_class_qiime.ps, ordination_class_bray, type = "biplot",color = "class", shape = "Group")
biplot_ord_plot

#
## More plotting options
#

# Remember, we can make plots with phyloseq functions and then modify them with 
# ggplot2 layers.
class_ord_plot1 <- plot_ordination(CSS_normalized_class_qiime.ps, ordination_class_bray, type = "samples",color = "Group", shape = "Group")
class_ord_plot1

# For example, you can add a polygon around sample groups, but doesn't work as well 
# when the sample groups don't cluster
class_ord_plot1 +  geom_polygon(aes(fill=Group)) + 
  geom_point(size=5) +
  ggtitle("amr ordination at the class level by sample group")

# Here, we convert our metadata variable "Sample_block" from numeric to factor
sample_data(CSS_normalized_class_qiime.ps)$Sample_block <- as.factor(sample_data(CSS_normalized_class_qiime.ps)$Sample_block)
# Plot ordination and change point shape based on treatment "Group"
class_ord_plot2 <- plot_ordination(CSS_normalized_class_qiime.ps, ordination_class_bray, type = "samples",color ="Sample_block", shape = "Group")
class_ord_plot2

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

#
## NB. Had to erase the "DPCoA" method that we used for the microbiome because it requires a phylogenetic tree.
#
ord_meths = c("DCA", "CCA", "RDA",  "NMDS", "MDS", "PCoA")


# Use the "llply()" function to go through our list of ord_meths, ordinate the data,
# and then add it all in a list called "plist"
plist = llply(as.list(ord_meths), function(i, physeq, dist){
  print(i)
  ordi = ordinate(physeq, method=i, distance=dist)
  plot_ordination(physeq, ordi, "samples", color="Group")
}, CSS_normalized_class_qiime.ps, dist)

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
}, CSS_normalized_class_qiime.ps, ord_meths)
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
group_variable = get_variable(CSS_normalized_class_qiime.ps,"Group")

# Phyloseq uses functions like "ordinate()" and "plot_ordination()" to wrap a bunch of 
# functions from other packages too. For the last few steps in this script, you'll see
# a bunch of functions from the "vegan" R package.
anosim_class_by_group = anosim(distance(CSS_normalized_class_qiime.ps, "bray"), group_variable)
anosim_class_by_group

plot(anosim_class_by_group)

#
##
### Permunation MANOVA (adonis)
##
#

# The creators of the vegan package suggest that using permunation MANOVA, as implemented
# in the "adonis()" function is a "more robust alternative". 
# Importantly, using "adonis()" allows us to make comparisons between sample groups 
# while modeling for the effect from multiple variables.

# We'll need to convert our data to a data.frame object
# There is probably a better way to extract the data than using
# all of the nested functions you'll see below, but this works for us!
df = as.data.frame(as(sample_data(CSS_normalized_class_qiime.ps),"matrix"))
# Extract counts from the phyloseq object, convert to data.frame
ASV_counts = as.data.frame(as(otu_table(CSS_normalized_class_qiime.ps),"matrix"))
# Notice that the features still have their full ID name
ASV_counts

# Instead, we might want to change those names to their corresponding class classification
class_taxa = as.data.frame(as(tax_table(CSS_normalized_class_qiime.ps), "matrix"))
class_taxa$class

row.names(ASV_counts) <- class_taxa$class

# Now we can see the updated names
ASV_counts

# Create the perMANOVA model
# NB. We have to tranpose the counts so that ASV features are columns
adonis_class_by_Group_Sample_block = adonis(t(ASV_counts) ~ Group + as.factor(Sample_block), data = df, method = "bray")

# View results
adonis_class_by_Group_Sample_block

# View model plots
plot(adonis_class_by_Group_Sample_block$aov.tab)

# Check assumption of similar multivariate spread among the treatment groups.
# PERMANOVA works with the assumption that dispersion of the data in your 
# samples is the ~same among each other, so before running PERMANOVA,
# you must run the betadisper->permutest to know if the dispersions are the 
# same. For that to be true, the permutest has to have a 
# non-significant p-value. Knowing the previous, 
# then you can run the PERMANOVA test, otherwise your interpretations will be wrong”

# Above, the adonis() function calculated the bray distance matrix as part
# of it's calculation. Now, we'll calculate that seperately.
class_bray_dist <- distance(CSS_normalized_class_qiime.ps, "bray")

# We are most interested in differences between treatment "Group".
# The result from this test is non-significant and suggests we can continue
# with our perMANOVA analysis.
permutest(betadisper(class_bray_dist, df$Group), pairwise = TRUE)


# We can pull out the model coefficients and plot wich taxa contribute most
# to the community differences.
coef <- coefficients(adonis_class_by_Group_Sample_block)["Group1",]
top.coef <- coef[rev(order(abs(coef)))[1:20]]
par(mar = c(3, 14, 2, 1))
barplot(sort(top.coef), horiz = T, las = 1, main = "Top taxa")


#
##
### Permunation MANOVA with sequential, marginal, and overall tests (adonis2)
##
#

# We are less familiar with adonis2, but it adds functions you might find useful
adonis2_class_by_Group_Sample_block = adonis2(t(ASV_counts) ~ Group + as.factor(Sample_block), data = df, method = "bray")
adonis2_class_by_Group_Sample_block

marginal_adonis2_class_by_Group_Sample_block = adonis2(t(ASV_counts) ~ Group + as.factor(Sample_block), data = df, method = "bray", by = NULL)

# With adonis2, we can perform pairwise contrasts but we'll need an additional
# library from github. Try the following commands to see if you can get 
# everything installed.
library(devtools)
install_github("pmartinezarbizu/pairwiseAdonis/pairwiseAdonis")
#install.packages("Rtools")
library(pairwiseAdonis)

# With pairwise.adonis2() , we can specify the "strata" factor which controls for
# nested (e.g. block) designs
posthoc_group_comparison <-pairwise.adonis2(class_bray_dist ~ Group ,data=df, strata="Sample_block")
# NB, the order of the variables changed, so be sure to look at the structure of the data
posthoc_group_comparison
posthoc_group_comparison$Control_vs_Treatment

