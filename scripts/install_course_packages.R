# Use bioconductor to install packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c('phyloseq','metagenomeSeq'))

# Install packages from CRAN repository
install.packages(c("dplyr","ggplot2","data.table","tidyr","forcats", "vegan","plyr", "devtools",
                   "pheatmap","dendsort","ggrepel","ggpubr","Rtools","tidyverse","ggthemes"))

# Install "pairwiseAdonis" from github for adding pairwise comparisons to models build with the adonis() function
install_github("pmartinezarbizu/pairwiseAdonis/pairwiseAdonis")
library(pairwiseAdonis)

# Optional package used for comparing the results from multiple types of differential abundance tests
# install_github("Russel88/DAtest")
