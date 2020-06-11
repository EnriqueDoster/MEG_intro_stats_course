##### Set up environment
library("phyloseq")
library("dplyr")
library("ggplot2")
library("data.table")

# Look at your Global Environment panel (usually top right)
# Unless you are saving the Workspace with R objects you created previously, this panel should be empty.
# If it isn't empty, we can remove all of those R objects and run our script from last week to re-load each R object.

# Let's check for any variables in your workspace
ls() # If you don't have any variables created, this will show "character(0)"

# To delete them all, we have to use the 
rm(list=ls())  # If your environment is empty already, this won't show anything

#
##
### Sample metadata
##
#

# Load sample metadata
sample_metadata <- read.table('./data/Lesson2_sample_metadata.csv', header=T, sep=',', row.names = 1)

# View the sample metadata again. Notice how variables starting with numeric values (16S) now have an added X to their name
# R prefers that column names and row names not start with a numeric value.
sample_metadata

# We can use the hist() function to view the distribution of 16S_Raw_paired_reads and Shotgun_raw_reads
hist(sample_metadata$X16S_Raw_paired_reads)
hist(sample_metadata$Shotgun_raw_reads)

# Now we can summarize counts by treatment using tools in "dplyr" like group_by() and summarize()
# Notice, we use "%>% to tell R that the next row is still part of the same command. This is specific to the dplyr package.
sample_metadata %>%
  group_by(Group) %>% # the name of the function allows us to understand that we are grouping samples based on the "Group" variable
  summarize(total_16S_counts = sum(X16S_Raw_paired_reads), mean_16S_counts = mean(X16S_Raw_paired_reads))

# As another example, we can use the mutate() function to create new variables
# Below, we make a new variable to calculate the percent of shotgun reads that were removed from raw reads.
sample_metadata %>%
  mutate(percent_host_removed = (Shotgun_raw_reads - Shotgun_nonhost_reads) / Shotgun_nonhost_reads)


#
##
### 16S microbiome results
##
#

# We import the .biom as in Lesson 1 step 4
microbiome <- import_biom("data/Exported_16S_qiime2_results/Lesson2_16S_asv_table.biom")

# We'll now  work to merge our phyloseq object with:
# updated taxa file, 
# metadata file
# and an additional phylogenetic tree that is part of the qiime2 output

str(microbiome) # only contains the counts right now

#
## Editing the 16S microbiome taxonomy file
#

# Load the taxonomy file from qiime2
taxa <- read.table("data/Exported_16S_qiime2_results/Lesson2_taxonomy.tsv", header=T, row.names=1, sep='\t')


# We'll change the rownames of the taxa to include entire taxonomic lineage in the first column
# We'll paste together these values and seperate them with the same format as in the lineage '; '
row.names(taxa) # This is what the row.names look like before
row.names(taxa) <- paste(row.names(taxa),taxa[,1], sep= '; ')
row.names(taxa) # This is what the row.names look like after editing

# There are many ways to do this next step, but we use the data.table library and make the object just using the new rownames we made
taxa.dt <- data.table(id=rownames(taxa)) # we'll make a column with the name "id"


# This part is a little more complicated, but you should be able to adopt this code for other similar uses.
# Notice that we are specifying the function after the comma, so in the columns.
# The main function we are using is "tstrsplit()". If you look at the documentation, you'll see that 
# "This is a convenient wrapper function to split a column using strsplit and assign the transposed result to individual columns"
# Here, we specify that we are splitting the "id" column by the characters "; "
# To the left of the ":=" we specify the column names for the values split from the id column
taxa.dt[, c('feature',
            'kingdom',
            'phylum',
            'class',
            'order',
            'family',
            'genus',
            'species') := tstrsplit(id, '; ', type.convert = TRUE, fixed = TRUE)]

# Now, we can see that the taxa.dt object has columns for each taxonomic level
taxa.dt

# We'll convert it back to data.frame. 
# Side note, I personally really like using "data.table" specially with really large datasets. 
# However, we won't explore this package much in this course because it functions like SQL and could require it's own course.
taxa.df <- as.data.frame(taxa.dt)

# erase the id column  
taxa.df <- within(taxa.df, rm(id))

# Use the feature variable to rename the row.names
row.names(taxa.df) <- taxa.df$feature
taxa.df <- within(taxa.df, rm(feature))


# We can use the read_tree() function to load the phylogenetic tree created with qiime2
# We'll use this tree in later to calculate beta diversity indices that can incorporate phylogenetic tree distances
microbiome_phylo_tree <- read_tree("./data/Exported_16S_qiime2_results/Lesson2_tree.nwk")

# Due to requirements from phyloseq, we have to
## convert the taxa.df object to a matrix and we have to specify that this is the tax_table()
## specify that the sample_16S_metadata object is the sample_data()
## specity that the microbiome_phylo_tree object is the phy_tree()
microbiome.ps <- merge_phyloseq(microbiome, phy_tree(microbiome_phylo_tree), tax_table(as.matrix(taxa.df)), sample_data(sample_metadata))


# Check out this new phyloseq object
microbiome.ps
# We can access the individual components like this:
# Look at this site for a few more examples: https://joey711.github.io/phyloseq/import-data.html
otu_table(microbiome.ps)
tax_table(microbiome.ps)
sample_data(microbiome.ps)
phy_tree(microbiome.ps)

# Here are some other functions that provide information about the phyloseq object
# Just the sample names
sample_names(microbiome.ps)
# Taxonomic rank names
rank_names(microbiome.ps)
# Variables in the metadata
sample_variables(microbiome.ps)
# Easy sums of counts by sample
sample_sums(microbiome.ps)

# How can we get the total counts by adding across all samples?



#
## Agglomerate ASV counts to different taxonomic levels
#

# Using tax_glom(), we can easily aggregate counts to different levels (taxonomic or AMR annotation levels)
phylum.ps <- tax_glom(microbiome.ps, "phylum")
phylum.ps

# We can get sample counts at the phylum level.
sum(sample_sums(phylum.ps))

# By summing counts at each taxonomic level, we can observe the reduction in sample counts in lower taxonomic levels.
# Note the stop sign on the right hand side of the Console panel, when you see this it means R is running a command.
# You can click on the stop sign to stop the run.
species.ps <- tax_glom(microbiome.ps, "species") # Depending on your computer and file size, this can take a couple of seconds to a few minutes

# We can get sample counts at the species level.
sum(sample_sums(species.ps))

# We can calculate the percentage of counts at the species level out of classified at the phylum level.
sum(sample_sums(species.ps))  /  sum(sample_sums(phylum.ps)) * 100

# In this data, we had a high percentage of ASVs classified down to the species level. 
# This can vary widely by dataset and is an important consideration.
# For example, we might not emphasize results from the species-level counts in a manuscript if they only made up ~ 50% of counts.



#
## Visualize the microbiome composition
#

# We can observe the counts using a simple bar chart using plot_bar()
# We have to specify that we'll fill the bar charts using the phylum counts ()
plot_bar(microbiome.ps)

plot_bar(phylum.ps, fill = "phylum")

# We can specify a "facet_grid" to organize the plot
plot_bar(phylum.ps, fill = "phylum", facet_grid = "Group")


# We group counts by the treatement Group
plot_bar(phylum.ps, fill = "phylum", x = "Group")


##### Convert OTU abundances to relative abundances
phylum.ps.rel <- transform_sample_counts(phylum.ps, function(x) x / sum(x) )

# We can plot these results, notice the y-axis relative abundance plots
plot_bar(phylum.ps.rel, fill= "phylum")





#
## Microbiome diversity indices 
#

# Alpha-diversity indices are a common measurement to summarize the composition of the microbiome and resistome.
# "Richness" or "Observed" simply describes the number of unique taxa identified in a sample
# On the other hand, we use "Shannon's index" or "Inverse Simpsons's index" to describe "evenness", or
# distribution of counts among taxa in a sample

# Find more infomation about diversity indices here: http://www.jmb.or.kr/submission/Journal/027/JMB027-12-02_FDOC_2.pdf

# Estimating richness and diversity using the easy-to-use function estimate_richness()
microbiome_16S_diversity_values <- estimate_richness(microbiome.ps)

# We can do the same for the phylum counts
estimate_richness(phylum.ps) # Notice the error you get.
# Microbiome papers usually report diversity indices at the ASV level (before aggregation), but also for different taxa levels

# We can easily plot these values using the plot_richness() function, we'll just pick 3 commonly used alpha diversity indices
plot_richness(phylum.ps, x = "Group", color = "Group", measures = c("Observed", "Shannon", "InvSimpson")) 

# We can then modify this figure using ggplot2 functions like geom_boxplot() by using the "+" sign 
# We'll explore further options in later steps
plot_richness(phylum.ps, x = "Group", color = "Group", measures = c("Observed", "Shannon", "InvSimpson")) + 
  geom_boxplot()





#
##
### Loading the kraken2 microbiome results (shotgun reads)
##
#

# Load the kraken count table                                        
kraken_microbiome <- read.table('./data/kraken_analytic_matrix.csv', header=T, row.names=1, sep=',')

# Convert to format that phyloseq likes with otu_table()                                      
kraken_microbiome <- otu_table(kraken_microbiome, taxa_are_rows = TRUE)

# Repeat similar steps to what we did with the qiime2 taxonomy
kraken_taxonomy <- data.table(id=rownames(kraken_microbiome))
kraken_taxonomy[, c('domain',
                     'kingdom',
                     'phylum',
                     'class',
                     'order',
                     'family',
                     'genus',
                     'species') := tstrsplit(id, '|', type.convert = TRUE, fixed = TRUE)]

# Conver to data.frame
kraken_taxonomy <- as.data.frame(kraken_taxonomy)

# Use the id variable to rename the row.names
row.names(kraken_taxonomy) <- kraken_taxonomy$id
# Remove the "id" column
kraken_taxonomy <- within(kraken_taxonomy, rm(id))

# Create kraken phyloseq object
kraken_microbiome.ps <- merge_phyloseq(kraken_microbiome, tax_table(as.matrix(kraken_taxonomy)), sample_metadata)

# We can now use the same functions as shown above with the 16S microbiome to explore the kraken microbiome counts
plot_bar(kraken_microbiome.ps)

# Estimating richness and diversity using the easy-to-use function estimate_richness()
microbiome_shotgun_diversity_values <- estimate_richness(kraken_microbiome.ps)



#
##
### Loading the resistome results (shotgun reads)
##
#
                                         
# Load MEGARes counts                                         
amr <- read.table('./data/AMR_analytic_matrix.csv', header=T, row.names=1, sep=',')

# We can convert our amr count object to the otu_table format required for phyloseq
amr <- otu_table(amr, taxa_are_rows = TRUE)

# Remember how we had to split up the taxa names for the microbiome features?
# Well, our MEGARes annotation file allows us to skip that step.
annotations <- read.table('data/megares_full_annotations_v2.0.csv', header=T, row.names=1, sep=",")
                                                      
annotations

# However, if you didn't have the annotations file, we created the AMR gene accession header to provide the information you need.
row.names(amr)

# Use the feature variable to rename the row.names
row.names(annotations)

# We can now merge these objects to make a phyloseq object
amr.ps <- merge_phyloseq(amr, tax_table(as.matrix(annotations)), sample_data(sample_metadata))

# We can now use the same functions as shown above with the 16S microbiome to explore the resistome counts
plot_bar(amr.ps)



#
##
### Merge diversity values for the microbiome
##
#


# We can make a new column, named "SeqType" and give it the value of "16S"


microbiome_16S_diversity_values <- microbiome_16S_diversity_values %>%
  mutate(SeqType = "16S", Sample = row.names(microbiome_16S_diversity_values))

# We can make a new column, named "SeqType" and give it the value of "shotgun"
microbiome_shotgun_diversity_values <- microbiome_shotgun_diversity_values %>%
  mutate(SeqType = "shotgun", Sample = row.names(microbiome_shotgun_diversity_values))



# Now we can merge these tables based on identical row
combined_diversity_values <- bind_rows(microbiome_16S_diversity_values, microbiome_shotgun_diversity_values)

# To help us better summarize the results, we can add the metadata information 
# First, we need to add a "Sample" column in the sample_metadata like in the combined_diversity_values object
sample_metadata$Sample <- row.names(sample_metadata)

# Now, we use left_join() to add the sample_metadata to the combined_diversity_values object
combined_diversity_values <- left_join(combined_diversity_values, sample_metadata, by = "Sample")

# Now try using "mutate" to get the average "Observed" and "Shannon" diversity values by SeqType
# Modify the code below to answer questions on the online quiz
# Check out this website for some more ways we can use "dplyr" to summarize our data: https://blog.dominodatalab.com/manipulating-data-with-dplyr/
combined_diversity_values %>%
  group_by(SeqType) %>%
  summarize(mean_observed = mean(Observed), mean_shannon = mean(Shannon))



#
##
### Export phyloseq object to "melted" format for summary statistics
##
#

# While phyloseq has built-in functions for easy plotting, we might want to export these counts for easier use with ggplot2

##### Convert phyloseq object with relative abundance to data.frame
phylum.ps.melt <- psmelt(phylum.ps.rel)

head(phylum.ps.melt)

##### Plot phyla abundances
plot.phylum.rel.bar <- ggplot(phylum.ps.melt, aes(x = Sample, y = Abundance, fill = phylum)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Group, scales = "free") +
  theme_bw()

plot.phylum.rel.bar


