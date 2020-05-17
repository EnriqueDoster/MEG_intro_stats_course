# Lesson 1 - File exploration with R
# In this lesson we'll go over how to read in results from microbiome and resistome analysis.


# Using your computer's file explorer (finder), navigate to where you downloaded this github repository.
# Open the folder "data" and explore the file "test_AMR_analytic_matrix.csv" using excel

# We''ll use an R command, read.table(), to read in the data, but we need to know a few things about the file.
# Please notice that the file has:
# column names "header=T", the first column has names for each of rows "row.names=1", and it is a comma seperated file "sep=','
amr <- read.table('./data/AMR_analytic_matrix.csv', header=T, row.names=1, sep=',')

# View structure of the data
str(amr)

# Let's see the first 10 lines of the file
head(amr)

# Think back to viewing data frames, how can you just see the first column?


# What about just the last column?


# This almost works to just show you the results for a single sample, can you fix it?
amr[CF24_S72_L008]

# View the entire count table
View(amr)


# What samples did we analyze? How many samples are in the "amr" project?
colnames(amr)
length(amr)

# Which genes were identified?
row.names(amr)

# How many genes were identified?
length(row.names(amr))

#
## Can you think of how we might be able to determine how many total counts each sample had? What about counts per feature?
#




#
###
####
##### Annotation file for 
####
###
##
#

# Notice that each gene accession is labeled to include information regarding which drug class it confers resistance to,
# the mechanism it employs to confer resistance, and the gene's group.
# MEGARes has a seperate annotation file that contains this information as well and facilitates the aggregation of counts.
# For example, we might want to sum all counts to gene accessions that confer resistance to drugs in the Tetracycline class.
# We'll explore this further in Lesson 2.

# This almost works...
annotations <- read.table('data/megares_full_annotations_v2.0.csv', header=T, row.names=1, sep="\t")

# Explore the annotation object, which column matches the rows in the amr object?
annotations[1]

# Get all the row names for the "amr" object and place it in a new object called "amr_headers"
amr_headers <- row.names(amr)

# Try extracting all of the data from annotations that matches "amr_headers"
subset_annotations <- annotations[amr_headers,]

# Now, we we can use the "subset_annotations" object and see how many unique AMR classes and mechanisms we found
unique(subset_annotations$class)

# Notice that the output is numbered in brackets, but it seems different than the amount of "Levels" reported
unique(subset_annotations$class)

# We can then use "length" to count the number of unique values
length(unique(subset_annotations$class))

# This happens because the "class" column is a factor and it maintaned all of the different values obseved in the annotations file
# Check the structure of "annotations" and"subset_annotations"
str(annotations)
str(subset_annotations)

# This might seem like a pointless thing to bring up, but it can cause issues with other R functions that use factors
# Simple remove the extra factors using "droplevels"
subset_annotations <- droplevels(subset_annotations)
str(subset_annotations)

# Now, how many unique mechanisms did we identify in our data?
length(unique(subset_annotations$mechanism))


