# Lesson 2 - "Data exploration and basic statistics"

## Learning objectives
* read-in count matrices from bioinformatic analysis of sequence data
* process annotations for microbiome taxa or resistome features
* create a "phyloseq" object containing counts, annotations, and sample metadata for the microbiome and resistome
* be able to explore and summarize bioinformatic results using diversity indices and plotting of summary statistics
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


Graphing:
* [ggplot2 tutorial](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html)
  * simple tutorial with example code for various ggplot2 figures
* [ggplot2 layers](https://rpubs.com/hadley/ggplot2-layers)
  * this page goes into details on ways you can modify ggplot2 figures 


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

### Learning objectives for step 1:
* Import counts, annotation file, and sample metadata into a "phyloseq" object to begin exploring the microbiome and resistome
* Begin calculating summary statistics for the microbiome and resistome
* Prepare the phyloseq objects for creating exploratory graphs and performing statistical analyses in the later steps.

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
Visualizing data is useful for exploring complex datasets and often makes up a critical component of research manuscripts. In Lesson 2 step 2 we'll build on the skills we learned in Step 1 and plot those summary statistics to explore our data.

### ggplot2 package for graphing

ggplot2 is the "most elegant and aesthetically pleasing graphics framework available in R."

With that power, unfortunately, comes a steep learning curve. The syntax for constructing ggplots could be puzzling if you are a beginner or work primarily with base graphics. The main difference is that, unlike base graphics, ggplot:
* works with dataframes and not individual vectors (remember using hist() with integer values)
  * the data needed to make the plot is typically be contained within the dataframe supplied to the ggplot() itself or can be supplied to respective "geoms". More on that later.
* you can keep enhancing the plot by adding more layers (and themes) to an existing plot created using the ggplot() function.

In lesson 2 step 2, we'll show you some of the ways that we explore microbiome and resistome results. As with other multivariate data, there isn't a single measure or statistical test that captures everything about your data. Therefore, we'll teach you the basics of how to use ggplot2 as we go over some of the typical figures that we use in the Microbial Ecology Group. We'll go over some basic plots for summary statistics and then learn how to test statistical comparisons between sample groups in lesson 2 step 3.


## Learning objectives for step 2
Become familiar with ggplot2 and the following ggplot2 components:
* layers
* labels
* themes
* facets

Calculate summary statistics and visualize the results using ggplot figures:
* boxplots
* scatterplots
* barplots
* relative abundance plots



### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson2_Step2_Introduction_to_plotting.R"

### Step 2) Deliverable 
* We made some minor changes to this on June 17, 2020. No worries if you finished the deliverable before the update!
* For Lessson 2, step 2 we'll be asking you create 2 figures using ggplot2 flags that we haven't showed you yet. This is meant to emulate the process you'll go through as you try making your own figures. You'll follow the instructions below to create two figures, export them figures into jpeg files, and then send those files to us at "meglab.metagenomics@gmail.com"

1. Create a boxplot comparing Shannon's diversity indices in the resistome at the AMR mechanism level
  * Plot sample groups on the x-axis
  * Color the boxplots by treatment group
  * add data points to the boxplots
  * look up how to flip the x and y axis by adding another ggplot layer
  * y-axis 
    * label it "Shannon's diversity index"
    * change the size of the "text" and "title" of the y axis to "18"
  * x-axis 
    * make x-axis labels be at a 45 degree angle
    * change the size of the "text" and "title" of the y axis to "18"
  * change the background grid color to "white" (hint: modify the theme)
  * change the title of the legend to "Treatment group"
  * change the set of colors you are using to grey scale. Look up the ggplot2 layer that allows you to easily do this.
 
2. Make a relative abundance plot of the kraken2 microbiome at the phylum level
  * Include phyla present at a relative abundance rate > 0.5% across all samples and change the label of all other phyla to "Low abundance phyla (<0.5%)"
  * Add a facet by treatment "Group" and correctly change the "scales"
  * Add a plot label that describes what's in the figure.
  * y-axis 
    * label it "Relative abundance"
    * change the size of the "text" and "title" of the y axis to "18"
  * x-axis 
    * make x-axis labels be at a 45 degree angle
    * change the size of the "text" and "title" of the y axis to "18"
  * change the colors by finding and using a different set of colors (hint: search for "palette")



# Step 3 - Basic statistical testing
### "There are lies, damn lies, and statistics..." -Anon
"Statistics are a tool, not an aim. Simple inspection of data, without statistical treatment, by an experienced and dedicated analyst may be just as useful as statistical figures on the desk of the disinterested." - [FAO](http://www.fao.org/3/W7295E/w7295e08.htm)

The value of statistics lies with organizing and simplifying data, to permit some objective estimate showing that an analysis is under control or that a change has occurred. Equally important is that the results of these statistical procedures are recorded and can be retrieved.This is where R scripts come in handy. Instead of just having a spreadsheet of p-values to record all of your results, you can save scripts that replicate all of your analyses.

In Step 3, we'll introduce you to using R for univariate statiscal testing of microbiome/resistome data. This means that there is only a single "dependent variable" involved. However, depending on the the type of dependent variable in question, we could use different statistical tests including t-tests, analysis of variance (ANOVA), analysis of covariance, linear regression, and generalized linear models such as binary logistic regression.  

### Learning objectives for step 3:
Statistical testing is necessary to assess differences between sample groups in a dataset. Students will learn to perform statistical comparisons of the following values:
* raw sequencing reads
* non-host reads
* mapped reads
* diversity indices

**Disclaimer:** We don't intend to go over the finer points of performing and interpreting statistical analyses. We are doing something much more dangerous. We will show you how to analyze metagenomic data and get p-values, but what you do with those values is then all up to you! That being said, we'd happy to try and help you interpret your data.

### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson2_Step3_Basic_stats.R"

### Step 3) Deliverable
* Follow along with the R code and then modify those commands to answer questions on the following survey:
https://www.surveymonkey.com/r/9CRJYJN
