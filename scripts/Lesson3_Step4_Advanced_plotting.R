# Load the data
# This script also loads any necessary libraries
source("./scripts/load_data.R")


#####################
##### Filter Data ####
######################

# First let's process normalize our counts with CSS normalization and aggregate counts at the phylum level
filtered_microbiome.ps = filter_taxa(microbiome.ps, function(x) sum(x) > 5, TRUE)
filtered_microbiome.metaseq <- phyloseq_to_metagenomeSeq(filtered_microbiome.ps)
cumNorm(filtered_microbiome.metaseq)
CSS_microbiome_counts <- MRcounts(filtered_microbiome.metaseq, norm = TRUE)
CSS_normalized_qiime.ps <- merge_phyloseq(otu_table(CSS_microbiome_counts, taxa_are_rows = TRUE),sample_data(microbiome.ps),tax_table(microbiome.ps), phy_tree(microbiome.ps))
CSS_normalized_phylum_qiime.ps <- tax_glom(CSS_normalized_qiime.ps, "phylum")


# In this script, we'll go over a few different types of plots
# Heatmaps
# Volcano plots


######################
#####  Heatmaps   ####
######################

# We can make easily make heatmaps using the "plot_heatmap" function
plot_heatmap(CSS_normalized_phylum_qiime.ps, taxa.label = "phylum")

# We can group our samples using metadata variabes.
# In the example below we change the order of samples and their labels.
plot_heatmap(CSS_normalized_phylum_qiime.ps,sample.order = "Group" ,sample.label="Group", taxa.label = "phylum")

# Or, we can make the same heatmap, but we can cluster samples using NMDS and the Bray-curtis distance
plot_heatmap(CSS_normalized_phylum_qiime.ps,method = "NMDS", distance = "bray", sample.label="Group",taxa.label = "phylum")

#
## Next here is an example of another library we can use for heatmap plots
#

#install.packages("pheatmap")
#install.packages("dendsort")
library(pheatmap)
library(dendsort)

# We can calculate distance measures to cluster samples
mat_cluster_cols <- hclust(dist(t(otu_table(CSS_normalized_phylum_qiime.ps))))
plot(mat_cluster_cols, main = "Unsorted Dendrogram", xlab = "", sub = "")

# We can also change the clustering of our samples using the function belowz
sort_hclust <- function(...) as.hclust(dendsort(as.dendrogram(...)))
sorted_mat_cluster_cols <- sort_hclust(mat_cluster_cols)
plot(sorted_mat_cluster_cols, main = "Sorted Dendrogram", xlab = "", sub = "")

# Now let's cluster the microbiome features
mat_cluster_rows <- sort_hclust(hclust(dist(otu_table(CSS_normalized_phylum_qiime.ps))))

# Remember, the features in the tax_table have unique IDs for each taxa, but those names
# don't get updated to the aggregated taxa labels. Instead, we'll pull out that information
# and use if for plotting below
phylum_taxa_labels <- as.data.frame(as(tax_table(CSS_normalized_phylum_qiime.ps),"matrix"))
phylum_taxa_labels$phylum

# Change the taxa names for your phyloseq object
taxa_names(CSS_normalized_phylum_qiime.ps) <- phylum_taxa_labels$phylum

# Here's an example of plotting a heatmap with the "pheatmap" package
# Notice we added a pseudocount, prior to log normalization.
# Without the pseudocount, CSS values < 1 are converted to negative values and cause an error
# Below are just a few examples of flags we can use, check out the pheatmap() documentation
# for more options.
pheatmap( log(otu_table(CSS_normalized_phylum_qiime.ps) + 1), cluster_cols = sorted_mat_cluster_cols,
          cluster_rows = mat_cluster_rows, 
          drop_levels = TRUE , fontsize = 10, treeheight_row = 10)

######################
###  Volcano plots ###
######################

# Now we'll use the code from Lesson 3 Step 3 to create the ZIG model
# We can use metagenomeSeq's function aggTax to aggregate counts as in phyloseq
phylum_microbiome.metaseq <- aggTax(filtered_microbiome.metaseq, lvl = "phylum")

# metagenomeSeq also has functions for filtering data
filtered_phylum_microbiome.metaseq <- filterData(phylum_microbiome.metaseq, present = 4)

# Make the "zero" model with library size of the raw data
zero_mod <- model.matrix(~0+log(libSize(filtered_microbiome.metaseq)))
# Make model with "Group" variable
Group <- pData(phylum_microbiome.metaseq)$Group
design_group = model.matrix(~0 + Group)

# This next command creates the normalization factor. We need the norm factors for 
# the fitZig function, but notice that we use the flag, useCSSoffset = FALSE so that it does not use
# the normalization factor is not used and instead, we feed it the "zeroMod" which is
# based on the raw counts.
cumNorm(filtered_phylum_microbiome.metaseq)

zig_model <- fitZig(obj= filtered_phylum_microbiome.metaseq, mod = design_group, zeroMod=zero_mod, useCSSoffset = FALSE)

# Use Ebayes to adjust model fit
ebayes_zig_model <- eBayes(zig_model$fit)

zigFit_Group = zig_model$fit
finalMod_Group = zig_model$fit$design
contrast_Group = makeContrasts(GroupControl-GroupTreatment, levels=finalMod_Group)
zigFit_contrasts = contrasts.fit(zigFit_Group, contrast_Group)
EB_zigFit_contrasts = eBayes(zigFit_contrasts)

# Make table of results, you can output these results with "write.csv()"
# Explore this table for the results.
table_EB_zigFit_contrasts <- topTable(EB_zigFit_contrasts, coef=1, adjust.method="BH",number = 1000)


## We went over how to create basic volcano plots in Lesson 3 Step 3, here we'll go over
# a few more examples.


## Obtain logical vector regarding whether padj values are less than 0.05
threshold_OE <- table_EB_zigFit_contrasts$adj.P.Val < 0.05 
## Determine the number of TRUE values
length(which(threshold_OE))
# Add logical vector as a column (threshold) to the res_tableOE
table_EB_zigFit_contrasts$threshold <- threshold_OE 

## Volcano plot
# Notice that we use log10 transformation for the pvalues on the y-axis. 
# This is not necessary, but it can help make the plot easier to read. 
# Either way, the points will be colored based on the 0.05 value as specified above.
ggplot(table_EB_zigFit_contrasts) +
  geom_point(aes(x=logFC, y=-log10(adj.P.Val), colour=threshold)) +
  xlab("logFC") + 
  ylab("-log10 adjusted p-value") +
  #scale_y_continuous(limits = c(0,50)) +
  theme(legend.position = "none",
        plot.title = element_text(size = rel(1.5), hjust = 0.5),
        axis.title = element_text(size = rel(1.25))) 
  
# The figure above gives a great overall view of what's going on, but you might
# also want to figure out the top 5 features (lowest adjusted p-value) in our 
# differential abundance testing. 

# For this to work, we have to create a new dataframe sorted by adjusted p-value and
# create a logical vector to indicate which features we want to label.

# As you have come to find out, we'll be needing yet another R package.
# In this case, we'll use ggrepel which helps with labeling points in ggplot2 figures.
install.packages(ggrepel)
library(ggrepel)

## Sort by ordered adj.P.Val
ordered_table_EB_zigFit_contrasts <- table_EB_zigFit_contrasts[order(table_EB_zigFit_contrasts$adj.P.Val), ] 

## Create a column to indicate which genes to label
ordered_table_EB_zigFit_contrasts$genelabels <- ""
# Label only the first 5 genes as TRUE
ordered_table_EB_zigFit_contrasts$genelabels[1:5] <- TRUE

View(ordered_table_EB_zigFit_contrasts)

# Additionally, we can make the size of each point on the graph correspond with 
# the "average expression" of each feature (Phyla/AMR gene)
radius_phylum_node <- sqrt(ordered_table_EB_zigFit_contrasts$AveExpr/pi)


# Create plot
ggplot(ordered_table_EB_zigFit_contrasts) +
  geom_point(aes(x = logFC, y = -log10(adj.P.Val), colour = threshold, size = radius_phylum_node)) +
  geom_text_repel(aes(x = logFC, y = -log10(adj.P.Val), label = ifelse(genelabels == TRUE, rownames(ordered_table_EB_zigFit_contrasts),""))) +
  xlab("logFC") + 
  ylab("-log10 adjusted p-value") +
  theme(legend.position = "none",
        plot.title = element_text(size = rel(1.5), hjust = 0.5),
        axis.title = element_text(size = rel(1.25))) 
