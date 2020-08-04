# This script starts after you have already loaded your data into a phyloseq object.
# Unlike other scripts in this course, this script will have minimal comments
# and will need further modification to fit your data.

# In particular, the code below is based on analysis of microbiome data and on
# analyzing the "Group" column. 

# Based on whatever you named your phyloseq object, the first step is to rename the 
# object to "microbiome.ps"
# source("./scripts/load_data.R") # This is how I loaded the test dataset

microbiome.ps

#################
# Summary stats #
#################

# This is using columns in your sample metadata file, so be sure it corresponds with your data
# Summarize for entire dataset
sample_data(microbiome.ps) %>%
  summarize(total_16S_counts = sum(X16S_Raw_paired_reads), mean_16S_counts = mean(X16S_Raw_paired_reads),
            min_16S_counts = min(X16S_Raw_paired_reads),max_16S_counts = max(X16S_Raw_paired_reads),
            median_16S_counts = median(X16S_Raw_paired_reads))

# Summarize by Group
sample_data(microbiome.ps) %>%
  group_by(Group) %>% 
  summarize(total_16S_counts = sum(X16S_Raw_paired_reads), mean_16S_counts = mean(X16S_Raw_paired_reads),
            min_16S_counts = min(X16S_Raw_paired_reads),max_16S_counts = max(X16S_Raw_paired_reads),
            median_16S_counts = median(X16S_Raw_paired_reads))

# Plot boxplot by Group
ggplot(sample_data(microbiome.ps), aes(x = Group , y = X16S_Raw_paired_reads, color = Group)) + 
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(title = "Metagenomic sequencing results", x = "Treatment group", y = "raw paired reads") + 
  theme(axis.text.x = element_text( size = 18),
        axis.text.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5),
        panel.background = element_blank())

# Test for differences in sequencing depth by Group
wilcox.test(sample_data(microbiome.ps)$X16S_Raw_paired_reads ~ sample_data(microbiome.ps)$Group)


##########################
#  Microbiome diversity  #
##########################

microbiome_16S_diversity_values <- estimate_richness(microbiome.ps)
microbiome_16S_diversity_values$Sample <- row.names(microbiome_16S_diversity_values)

# Remember, that with phyloseq objects have to convert to matrix first, then to dataframe
sample_metadata <- as.data.frame(as(sample_data(microbiome.ps), "matrix"))

# Make a column "Sample" to join the metadata file with the diversity indices
sample_metadata$Sample <- row.names(sample_data(sample_metadata))

# Now, we use left_join() to add the sample_metadata to the combined_diversity_values object
microbiome_16S_diversity_values <- left_join(microbiome_16S_diversity_values,sample_metadata, by = "Sample")

ggplot(microbiome_16S_diversity_values, aes(x = Group, y = Observed, color = Group)) +
  geom_boxplot() +
  geom_point() +
  labs(title = "Unique features by treatment group", x = "Treatment group", y = "Observed features") + 
  theme_classic()

# Test Observed diversity differences by Group
wilcox.test(microbiome_16S_diversity_values$Observed ~ microbiome_16S_diversity_values$Group )
# Test Shannon's diversity differences by Group
wilcox.test(microbiome_16S_diversity_values$Shannon ~ microbiome_16S_diversity_values$Group )


# Same analysis by phylum (raw data)
phylum_microbiome.ps <- tax_glom(microbiome.ps, "phylum")
phylum_16S_diversity_values <- estimate_richness(phylum_microbiome.ps)
phylum_16S_diversity_values$Sample <- row.names(phylum_16S_diversity_values)

phylum_16S_diversity_values <- left_join(phylum_16S_diversity_values,sample_metadata, by = "Sample")

ggplot(phylum_16S_diversity_values, aes(x = Group, y = Observed, color = Group)) +
  geom_boxplot() +
  geom_point() +
  labs(title = "Unique features by treatment group at the phylum level", x = "Treatment group", y = "Observed features") + 
  theme_classic()

# Test Observed diversity differences by Group
wilcox.test(phylum_16S_diversity_values$Observed ~ phylum_16S_diversity_values$Group )
# Test Shannon's diversity differences by Group
wilcox.test(phylum_16S_diversity_values$Shannon ~ phylum_16S_diversity_values$Group )


##########################
# Microbiome composition #
##########################


filtered_microbiome.ps = filter_taxa(microbiome.ps, function(x) sum(x) > 5, TRUE)
filtered_microbiome.metaseq <- phyloseq_to_metagenomeSeq(filtered_microbiome.ps)
cumNorm(filtered_microbiome.metaseq)
CSS_microbiome_counts <- MRcounts(filtered_microbiome.metaseq, norm = TRUE)
CSS_normalized_microbiome.ps <- merge_phyloseq(otu_table(CSS_microbiome_counts, taxa_are_rows = TRUE),sample_data(microbiome.ps),tax_table(microbiome.ps), phy_tree(microbiome.ps))
CSS_normalized_phylum_microbiome.ps <- tax_glom(CSS_normalized_microbiome.ps, "phylum")

plot_bar(CSS_normalized_phylum_microbiome.ps, fill = "phylum") + 
  facet_wrap(~ Group, scales = "free_x") +
  theme_classic()

# Convert OTU abundances to relative abundances
rel_phylum_microbiome.ps <- transform_sample_counts(CSS_normalized_phylum_microbiome.ps, function(x) x / sum(x) )

# We can plot these results, notice the y-axis relative abundance plots
plot_bar(rel_phylum_microbiome.ps, fill= "phylum")

# only keep OTUs present in greater than 0.5% of all OTUs across all samples.
minTotRelAbun = 0.005
x = taxa_sums(CSS_normalized_phylum_microbiome.ps)
keepTaxa = (x / sum(x)) > minTotRelAbun
length(keepTaxa[keepTaxa ==TRUE])
pruned_phylum_microbiome.ps = prune_taxa(keepTaxa, CSS_normalized_phylum_microbiome.ps)
plot_bar(pruned_phylum_microbiome.ps, fill = "phylum")

rel_pruned_phylum_microbiome.ps <- transform_sample_counts(pruned_phylum_microbiome.ps, function(x) x / sum(x) )

plot_bar(rel_pruned_phylum_microbiome.ps, fill = "phylum")

library(pheatmap)
library(dendsort)

# We can calculate distance measures to cluster samples
mat_cluster_cols <- hclust(dist(t(otu_table(CSS_normalized_phylum_microbiome.ps))))

# We can also change the clustering of our samples using the function belowz
sort_hclust <- function(...) as.hclust(dendsort(as.dendrogram(...)))
sorted_mat_cluster_cols <- sort_hclust(mat_cluster_cols)

# Now let's cluster the microbiome features
mat_cluster_rows <- sort_hclust(hclust(dist(otu_table(CSS_normalized_phylum_microbiome.ps))))

# Remember, the features in the tax_table have unique IDs for each taxa, but those names
# don't get updated to the aggregated taxa labels. Instead, we'll pull out that information
# and use if for plotting below
phylum_taxa_labels <- as.data.frame(as(tax_table(CSS_normalized_phylum_microbiome.ps),"matrix"))
phylum_taxa_labels$phylum

# Change the taxa names for your phyloseq object
taxa_names(CSS_normalized_phylum_microbiome.ps) <- phylum_taxa_labels$phylum

# Here's an example of plotting a heatmap with the "pheatmap" package
# Notice we added a pseudocount, prior to log normalization.
# Without the pseudocount, CSS values < 1 are converted to negative values and cause an error
# Below are just a few examples of flags we can use, check out the pheatmap() documentation
# for more options.
pheatmap( log(otu_table(CSS_normalized_phylum_microbiome.ps) + 1), cluster_cols = sorted_mat_cluster_cols,
          cluster_rows = mat_cluster_rows, 
          drop_levels = TRUE , fontsize = 10, treeheight_row = 10)


###########################
#  Microbiome ordination  #
###########################

ordination_phylum_bray <- ordinate(CSS_normalized_phylum_microbiome.ps, method = "NMDS" , distance="bray")

# We can use "plot_ordination()" to plot the distance matrix
# We specify that we want to compare "samples" and color the points by the "Group" metadata variable
plot_ordination(CSS_normalized_phylum_microbiome.ps, ordination_phylum_bray, type = "samples",color = "Group")

plot_ordination(CSS_normalized_phylum_microbiome.ps, ordination_phylum_bray, type = "split",color = "phylum", shape = "Group")


group_variable = get_variable(CSS_normalized_phylum_microbiome.ps,"Group")

anosim(distance(CSS_normalized_phylum_microbiome.ps, "bray"), group_variable)



# perMANOVA with adonis()
df = as.data.frame(as(sample_data(CSS_normalized_phylum_microbiome.ps),"matrix"))
# Extract counts from the phyloseq object, convert to data.frame
ASV_counts = as.data.frame(as(otu_table(CSS_normalized_phylum_microbiome.ps),"matrix"))

adonis_phylum_by_Group_Sample_block = adonis(t(ASV_counts) ~ Group + as.factor(Sample_block), data = df, method = "bray")

adonis_phylum_by_Group_Sample_block

plot(adonis_phylum_by_Group_Sample_block$aov.tab)

coef <- coefficients(adonis_phylum_by_Group_Sample_block)["Group1",]
top.coef <- coef[rev(order(abs(coef)))[1:20]]
par(mar = c(3, 10, 2, 1))
barplot(sort(top.coef), horiz = T, las = 1, main = "Top taxa")


##################################
# Differential abundance testing #
##################################

# We can use metagenomeSeq's function aggTax to aggregate counts as in phyloseq
phylum_microbiome.metaseq <- aggTax(filtered_microbiome.metaseq, lvl = "phylum")

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

## Obtain logical vector regarding whether padj values are less than 0.05
threshold_OE <- table_EB_zigFit_contrasts$adj.P.Val < 0.05 
## Determine the number of TRUE values
length(which(threshold_OE))
# Add logical vector as a column (threshold) to the res_tableOE
table_EB_zigFit_contrasts$threshold <- threshold_OE 

library(ggrepel)

## Sort by ordered adj.P.Val
ordered_table_EB_zigFit_contrasts <- table_EB_zigFit_contrasts[order(table_EB_zigFit_contrasts$adj.P.Val), ] 

## Create a column to indicate which genes to label
ordered_table_EB_zigFit_contrasts$genelabels <- ""
# Label only the first 5 genes as TRUE
ordered_table_EB_zigFit_contrasts$genelabels[1:5] <- TRUE

# Additionally, we can make the size of each point on the graph correspond with 
# the "average expression" of each feature (Phyla/AMR gene)
radius_phylum_node <- sqrt(ordered_table_EB_zigFit_contrasts$AveExpr/pi)

# Create volcano plot
ggplot(ordered_table_EB_zigFit_contrasts) +
  geom_point(aes(x = logFC, y = -log10(adj.P.Val), colour = threshold, size = radius_phylum_node)) +
  geom_text_repel(aes(x = logFC, y = -log10(adj.P.Val), label = ifelse(genelabels == TRUE, rownames(ordered_table_EB_zigFit_contrasts),""))) +
  xlab("logFC") + 
  ylab("-log10 adjusted p-value") +
  theme(legend.position = "none",
        plot.title = element_text(size = rel(1.5), hjust = 0.5),
        axis.title = element_text(size = rel(1.25))) 


