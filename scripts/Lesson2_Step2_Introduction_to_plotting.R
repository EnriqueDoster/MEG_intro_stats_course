
# http://deneflab.github.io/MicrobeMiseq/demos/mothur_2_phyloseq.html

# We can run a quick Wilcoxon test to compare the number of raw reads between treatment groups
# Like with the hist() function, first we specify the column with numeric values, sample_metadata$X16S_Raw_paired_reads
# Then we use the "~" followed by the column with the grouping variable you want to test
wilcox.test(sample_metadata$X16S_Raw_paired_reads ~ sample_metadata$Group)
wilcox.test(sample_metadata$Shotgun_raw_reads ~ sample_metadata$Group)

# We can use the same format as above to make a quick boxplot
boxplot(sample_metadata$X16S_Raw_paired_reads ~ sample_metadata$Group)
boxplot(sample_metadata$Shotgun_raw_reads ~ sample_metadata$Group)