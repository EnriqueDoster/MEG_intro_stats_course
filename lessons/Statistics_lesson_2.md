# Lesson 2 - "Data exploration and basic statistics"

## Learning objectives
* read-in count matrices from bioinformatic analysis of sequence data
* process annotations for microbiome taxa or resistome features
* be able to explore and summarize bioinformatic results using diversity indices basic plots
* make statistical comparisons between sample groups


## Lesson 2 overview:
We will break up this lesson into 3 steps. We'll meet once a week to discuss each step and students will independently work on the "task" and associated "deliverable" that must be sent to meglab.metagenomics@gmail.com.
* [Step 1](#step-1---calculating-summary-statistics): Calculating summary statistics
* [Step 2](#step-2---introduction-to-plotting): Introduction to plotting
* [Step 3](#step-3---basic-statistical-testing): Basic statistical testing


## Additional resources:
MEG resources
* [MEG bioinformatic term glossary](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Glossary.md)
* [AMR ++ pipeline overview](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/AMR%2B%2B_v2_pipeline_overview.pdf)
* [Bioinformatic AMR and 16S pipeline overview](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Bioinformatic_AMR_and_16S_pipeline_overview.pdf)
* [Bioinformatics statistics overview](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Bioinformatic_statistics_overview.pdf)


Statistics
* [GUide to STatistical Analysis in Microbial Ecology (GUSTA ME)](https://mb3is.megx.net/gustame)
  * This is a great resource that summarizes a lot of the statistical methods we use
* [LHS 610: Exploratory Data Analysis for Health](https://kdpsingh.lab.medicine.umich.edu/lhs-610)
  * We haven't personally tried this course, but they provide great videos and code examples for learning how to explore data using R
* [#bioinformatics live twitter feed](https://twitter.com/search?q=%23bioinformatics&src=hash)
  * Stay up to date with other researchers doing bioinformatics


---

# Step 1 - Calculating summary statistics
### The many ways to summarize metagenomic data
As with many multivariate data, the analysis is not typically limited to just a single statistical method.

Before getting the more complicated statistical analyses, it is important to explore:
  * Sequencing statistics - "Are there differences in sequencing depth (total raw reads) between sample groups?"
  * Mapping statistics - "Are there differences in the number of reads mapped to the microbiome and resistome?"
  * Counts mapped to each taxonomic level - "What percentage of reads mapped to each taxonomic level (i.e. Phylum, Class, Order, etc.)?"

In this step we'll go over how we can use the "phyloseq" object to answer these questions.

### Task
* First, [watch this video](https://www.dropbox.com/s/hc0eu3e3povstvy/Video-Introduction_to_dataset.mp4?dl=0) for a description of the dataset we'll be using for the rest of the course.
* Then, to ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
  * As long as you saved any changes you made with new file names, this will update everything else in the repository to catch up with the "master" branch.
5. Follow the instructions in the script, "Lesson2_Step1_R_Data_summary_statistics.R"

### Step 1) Deliverable
* Use the script from the task above to explore the data and answer questions in this survey: https://www.surveymonkey.com/r/HML87W3





# Step 2 - Introduction to plotting
### A picture is worth a thousand words
Visualizing data is useful for exploring complex datasets and often makes up a critical component of research manuscripts. In Step 2 we'll build on the skills we learned in Step 1 and plot those summary statistics. Specifically, we'll learn to make:
* boxplots
* relative abundance plots
* rarefaction plots


### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson2_basic_plotting.R"

### Step 2) Deliverable
* Create a boxplot comparing raw reads by "Treatment" group.
  * Color the boxplots by sample
  * Label the y-axis accordingly
  * Make the x-axis labels be at a 45 degree angle
  * Look up how to remove the grid and change the background color to any color you want
* Make a relative abundance plot of the microbiome at the phylum level
  * Make another another plot that only includes phyla present at a relative abundance rate > 5% across all samples (or a number of your choice).
  * Make sure both files have descriptive titles
* Create a rarefaction curve for resistome counts, compare this to rarefaction curves for the microbiome.
  * Which dataset would have benefited the most from deeper sequencing?



# Step 3 - Basic statistical testing
### "There are lies, damn lies, and statistics..." -Anon
"Statistics are a tool, not an aim. Simple inspection of data, without statistical treatment, by an experienced and dedicated analyst may be just as useful as statistical figures on the desk of the disinterested." - [FAO](http://www.fao.org/3/W7295E/w7295e08.htm)

The value of statistics lies with organizing and simplifying data, to permit some objective estimate showing that an analysis is under control or that a change has occurred. Equally important is that the results of these statistical procedures are recorded and can be retrieved.

This is where R scripts come in handy. Instead of just having a spreadsheet of p-values to record all of your results, you can save scripts that replicate all of your analyses. In Step 3, we'll learn how to use the Wilcoxon test and linear models to compare values between sample groups. We'll start with univariate tests to compare:
* raw sequencing reads
* non-host reads
* mapped reads
* diversity indices


**Disclaimer:** We don't intend to go over the finer points of performing statistical analyses. We are doing something much more dangerous. We will show you how to get metagenomic data and get p-values. What you do with those values is then all up to you!

### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson3_basic_statistical_testing.R"

### Step 3) Deliverable
* For both the microbiome and resistome, test for statistical differences between:
  * non-host reads
  * mapped reads
    * at phylum and species level for the microbiome
    * at the class and gene level for the microbiome
  * diversity indices
    * at phylum and species level for the microbiome
    * at the class and gene level for the microbiome
