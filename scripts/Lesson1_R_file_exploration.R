# Lesson 1 - File exploration with R
# In this lesson we'll go over how to read in results from microbiome and resistome analysis.


# Using your computer's file explorer (finder), navigate to where you downloaded this github repository.
# Open the folder "data" and explore the file "test_AMR_analytic_matrix.csv" using excel

# We''ll use an R command, read.table(), to read in the data, but we need to know a few things about the file.
# Please notice that the file has column names "header=T", the first column has names for each of rows "row.names=1",
# and it is a comma seperated file "sep=','
amr <- read.table('data/test_AMR_analytic_matrix.csv', header=T, row.names=1, sep=',')

# View structure of the data
str(amr)

# View the entire count table
View(amr)

# What samples did we analyze and which genes were identified?
colnames(amr)
row.names(amr)

#
## Can you think of how we might be able to determine how many total counts each sample had? What about counts per feature?
#

# Notice that the AMR gene names contain information about each gene accession regarding which drug class it confers resistance to,
# the mechanism is employs to confer resistance, and the gene's group.
# MEGARes has a seperate annotation file that contains this information as well and facilitates the aggregation of counts.
# For example, we might want to sum all counts to gene accessions that confer resistance to Tetracycline drugs. We'll explore
# this further in Lesson 2.
annotations <- read.table('data/megares_annotations_v1.03.csv', header=T, row.names=1, sep=',')

# View annotations file

