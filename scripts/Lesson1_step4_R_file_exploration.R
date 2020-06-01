# Lesson 1 - File exploration with R
# In this lesson we'll go over how to read in results from microbiome and resistome analysis.


# Using your computer's file explorer (in mac it's called "finder"), navigate to where you created the R project
# and contains the github repository. 
# Open the folder "data" and explore the file "test_AMR_analytic_matrix.csv" using excel or another program.
# This file contains the count results of bioinformatic analysis with AMR++ and alignment to the MEGARes resistance database.
# Based on the names on the spreadsheet, where are the samples and where can we find the gene accessions?

# It's easy to answer a lot of questions about your data using R. However, importing data into R can be done
# in many ways and can be the first challenge you face in analyzing your data.

# Often, data is in a text format and delimited by tabs (.tsv) or commas (.csv). 

# We''ll use an R command, read.table(), to read in the data, but we need to know a few things about the file.
# We'll give the R command extra information by filling in "flags" or "parameters" for that function. 
# Remember how to get more information about a function? That documentation will also show the parameters you can modify.

# Please notice that the file we are opening up has the following attributes and the flags we use to address it:
# column names "header=T", 
# and it is a comma seperated file "sep=','
# Load in the metadata file
sample_metadata <- read.table('./data/sample_metadata.csv', header=T, sep=',')

# Let's see the first 10 lines of the file
head(sample_metadata)

# View structure of the data
str(sample_metadata)


# Think back to viewing data frames in Lesson 1 step 3, how can you just see the first column?


# What about just the last column?
# hint, we can determine how many columns we have with results from "str" or by counting the number of columns

# We also know the names for the columns and they can be accessed like this:
sample_metadata$Sample

# We can check how many samples we have like this by seeing how many values we have in that column
length(sample_metadata$Sample)

# Now, we want to know many treatment groups we have in the column, "Group"
# Just using length() gives us a total count
length(sample_metadata$Group)

# But, we can specify that we only want the unique variables
unique(sample_metadata$Group)
length(unique(sample_metadata$Group))

# In Lesson 2 we'll use this metadata information to inform statistical comparisons.

#
##
###
####
##### Resistome results from alignment to the MEGARes database
####
###
##
#

# Load in the count table
# and it is a comma seperated file "sep=','
# column names "header=T", 
# the first column has names for each of rows "row.names=1", we add this flag to address a common format with count matrices
# If you open the AMR_analytic_matrix.csv file with excel, you'll notice the sample names (columns) appear to be shifted over incorrectly.
# However, the file actually contains an empty spot over that first column because we use it to specify "row.names" for the R object.
amr <- read.table('./data/AMR_analytic_matrix.csv', header=T, row.names=1, sep=',')

# look at data structure. Notice that the gene accessions don't show up as a column.
str(amr)

# This way, only the sample data is in the count table and you can easily sum values in these columns.
sum(amr)

# You can access the row.names like this:
row.names(amr)

# This almost works to just show you the results for a single sample, can you fix it?
# hint - difference is whether CF24 is a variable or a string
amr[,CF24]


# View the entire count table
View(amr)


# What samples did we analyze? 
colnames(amr)

# How many samples are in the "amr" project?
length(amr)

# Which genes were identified?
row.names(amr)

# How many genes were identified?
# hint: try nesting a function inside another function

# Can you think of how we might be able to determine how many total counts each sample had?
# hint: where in the data are the values you are trying to add?

# What about counts per feature? Try looking up a function that "sum" this for you. 


# We'll dive into this topic further in lesson 3, but let's take a look at the distribution of count for different AMR gene accessions
# First, we can take a look at just one of the row names in the data.frame and see those counts
amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",]

# We want to use the function "hist()" to create a simple histogram of the counts for the gene accession above, but
# we get an error when we run the following command:
hist(amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",])

# Take a look at the error, it says "x must be numeric".
# Our results from running amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",] looked "numeric", but 
# the outut also includes the row name and column names. Let's check the structure of the data
str(amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",]) # we can see it's a dataframe with numeric values 

# We can use "typeof()" to see the object type
typeof(amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",])

# Fortunately, we can convert between some R object types. For example we can use "as.integer()"
as.integer(amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",])

# Check what type of R object you get when using "as.integer()"


# Try the following command to create a simple histogram. 
hist(as.integer(amr["MEG_7240|Drugs|Tetracyclines|Tetracycline_inactivation_enzymes|TETX",]))

# Does this distribution seem to be normally distrubuted? What about the Poisson distribution?

# Take a look at a few other taxa, notice that a lot of them are poorly represented across samples in this study. 
# We refer to this as "sparse" data and this is a major consideration for decision-making around statistical analysis of metagenomic data.

#
##
###
####
##### Annotation file for MEGARes gene accessions
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
# hint: the difference is what is seperating the values in your text file. What does "\t" mean?
annotations <- read.table('data/megares_full_annotations_v2.0.csv', header=T, row.names=1, sep="\t")

# Explore the annotation object, which column matches the rows in the amr object?
annotations[,1]

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

#
##
###
####
##### Reading-in results from microbiome analysis
####
###
##
#


# As we went over in the notes for Lesson 1 step 4, depending on your bioinformatic analysis
kraken_microbiome <- read.table('./data/kraken_analytic_matrix.csv', header=T, row.names=1, sep=',')


# Take a look at the row names. As part of AMR++, we created a python script that can parse the kraken2 report
# and provide it in a better format for use with R. 
# Notice that the row names contain taxomic ranks  

# Use this object to answer questions for the Lesson 1 Step 4 deliverable




###
#### Qiime2 microbiome results
###

# Qiime2 is another common pipeline used for the analysis of 16S sequencing reads
# Qiime2 has their own type of file format (.qza) that works with their pipeline and built-in tools
# For our purposes, we use qiime2 to filter reads based on read quality and use DADA2 to create amplicon sequence variants (ASV).
# These ASV are then treated as the microbiome features that must be taxonomically classified (labeled) using a bayesian classifier.
# We use functions in qiime2 to export the results into a format we can use (https://docs.qiime2.org/2019.10/tutorials/exporting/)

# We need to load the phyloseq library which contains special functions, in this case to load .biom files
# NB. People often load libraries at the beginning of each script.
library(phyloseq)

# We can use the function "import_biom()" from the phyloseq object to read-in a file in the .biom format
microbiome <- import_biom("data/Exported_16S_qiime2_results/16S_asv_table.biom") # this has count table and phylogenetic tree

# Check out the file with the typical commands
head(microbiome)
# But notice, that it's not a data.frame and it's actually a otu_table.
str(microbiome)
# This is specific to the "phyloseq" package which we'll explore further in Lesson, so for now we can just convert it to a data.frame
microbiome.df <- as.data.frame(microbiome)

# You'll notice that the row.names or ASVs don't have useful names so we'll have to also use an annotation file 
# that gives us more information about how each ASV was classified.

# There is a file called "taxonomy.tsv" in the "data/Exported_16S_qiime2_results/" directory. Try loading it here:
taxa <- read.table()

# Take a look at the taxa object. We'll have to modify the row the data for easier use.
# We'll go deeper into this with Lesson 2.

# Now you can use all of the functions we tried above to explore the microbiome dataset
# Use this count table to answer questions for the Lesson 1 Step 4 deliverable

