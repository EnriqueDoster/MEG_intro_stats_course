# Lesson 3 - "Advanced statistical analyses and plotting"

## Learning objectives for Lesson 3
* normalize count matrices to account for differences in sequence depth
* visualize multivariate data with ordination and statistically compare sample clustering
* compare differential abundance for individual taxa using a Zero-inflated Gaussian model
* learn to make ordination plots, heatmaps, and volcano plots
* be able to run MEG's R GUI code to automate data processing and the creation of exploratory figures

## Lesson 3 overview:
We will break up this lesson into 5 steps. We'll meet once a week to discuss each step and students will independently work on the "task" and associated "deliverable" that must be sent to meglab.metagenomics@gmail.com.
* [Step 1](#step-1---count-normalization): Count normalization
* [Step 2](#step-2---ordination-with-non-metric-multidimensional-scaling-and-statistical-comparisons): Ordination with non-metric multidimensional scaling and statistical comparisons
* [Step 3](#step-3---differential-abundance-testing-with-a-zero-inflated-gaussian-model): Differential abundance testing with a Zero-inflated Gaussian model
* [Step 4](#step-4---advanced-plotting): Advanced plotting (heatmaps, volcano plots, ordination)
* [Step 5](#step-5---learn-to-run-meg-r-gui-code-for-exploratory-figures): Learn to run MEG R GUI code for exploratory figures


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
* [Waste Not, Want Not: Why Rarefying Microbiome Data Is Inadmissible](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003531)
* [Comparison of normalization methods for the analysis of metagenomic gene abundance data](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-018-4637-6)
* [Normalization and microbial differential abundance strategies depend upon data characteristics](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5335496/)


---

# Step 1 - Count normalization

### Addressing bias with count normalization
As we have been reviewing in this course, there are multiple sources of bias that can be introduced in any step of a metagenomic sequencing study. It is important to remember that this course only goes over the stastistal analysis component of a multi-stage process involved in analyzing metagenomic sequencing samples.

  <img src="https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/example_pictures/metagenomic_workflow.png" width="1100" height="300" />  
 

Please review the recording of our class session on July 9, 2020(in the dropbox folder) as we discuss how count normalization can help address sources of bias. 

In particular, we'll focus on addressing differences in sequencing depth between samples, but below are a few other examples for your consideration. Adapted the following figures from the HBC training course, ["Intro to DGE"](https://hbctraining.github.io/DGE_workshop/).
* Sequencing depth: Accounting for sequencing depth is necessary for comparison of gene expression between samples. In the example below, each gene appears to have doubled in expression in Sample A relative to Sample B, however this is a consequence of Sample A having double the sequencing depth.

  <img src="https://hbctraining.github.io/DGE_workshop/img/normalization_methods_depth.png" width="600" height="300" />  
    
      NOTE: In the figure above, each pink and green rectangle represents a read aligned to a gene. Reads connected by dashed lines connect a read spanning an intron.
    
* Gene length: Accounting for gene length is necessary for comparing expression between different genes within the same sample. In the example, Gene X and Gene Y have similar levels of expression, but the number of reads mapped to Gene X would be many more than the number mapped to Gene Y because Gene X is longer.

  <img src="https://hbctraining.github.io/DGE_workshop/img/normalization_methods_length.png" width="500" height="300" />  
  
  * Gene length might have not greatly impact your 16S rRNA sequencing projects, but this is an important consideration when targeting genes with variable sequence lengths (e.g. virulence factors, mobile genetic elements, metabolic genes, etc). 
  * We won't go over this example in our course, but we have also previously used the equation described by [Li et. al. 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4611512/?report=reader) to normalize resistome counts by bacterial abundance and AMR gene length. Equation shown below:

  <img src="https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/example_pictures/Li_equation_AMR_gene_abundance.png" width="600" height="200" />  

     In the equation above, N<sub>AMR−likesequence</sub> is defined as the number of alignments to one specific AMR gene sequence; L<sub>reads</sub> as the sequence length of the Illumina reads (125 nt); L<sub>AMRreferencesequence</sub> as the sequence length of the corresponding AMR gene sequence; N<sub>16Ssequence</sub> as the number of alignments to 16S sequences; and L<sub>16Ssequence</sub> as the average length of the 16S sequences in the Greengenes database (mean = 1,401 nt). 
    
## Learning Objectives:

**Disclaimer) As in Lesson 2 Step 3, we can't go over all the nuances of selecting the best normalization method for your data, and as we have discussed, the statistical analyses for metagenomic studies require many nuanced decisions, each of which has the potential to substantially impact study results**

In lesson 3, step 1 you'll learn how to perform the following normalization methods:
* Rarefying - randomly “downsample” every sample to a level even with the sample with the lowest number of reads
* Total Sum Scaling (TSS) - the number of ”feature” reads divided by the total number of sequenced reads (can then be multiplied by X to get absolute abundance)
* Cumulative Sum Scaling (CSS) - applies a normalization scale quantile, which is derived from the data itself



### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson3_Step1_Count_normalization.R"


### Lesson 3 Step 1) Deliverable
Use the script from this step, "Lesson3_Step1_Count_normalization.R", to answer the questions on the following survey: https://www.surveymonkey.com/r/ZYLND8N




---

# Step 2 - Ordination with non-metric multidimensional scaling and statistical comparisons
### Multivariate analysis
**Figures and information adapted from the following sites:**
* https://sites.google.com/site/mb3gustame/
* https://archetypalecology.wordpress.com/2018/02/21/permutational-multivariate-analysis-of-variance-permanova-in-r-preliminary/
* http://ordination.okstate.edu/overview.htm
* https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/vegdist


So far, we've looked at the microbiome and resistome composition and calculated alpha diversity values (richness, Shannon's index) to compare samples by treatment group. In Lesson 3 step 2 we'll use multivariate analysis to compare beta-diversity (between-sample diversity),visualize our results using ordination, and then test for differences between sample groups. 

As with alpha-diversity, there are many different ways to calculate beta-diversity including Euclidean distances and the Bray-Curtis dissimilarity index. Beta-diversity is calculated on a count matrix with samples on the rows and features on the column (A panel) and the results are stored in a (dis)similarity matrix (B panel).

  <img src="https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/example_pictures/beta_diversity_tables.png" width="500" height="300" />  

Then with ordination, this multidimensional data is represented into a reduced number of orthogonal axes. Again, there are different ordination methods to choose from, but they all attempt to maintain the main trends of the data to help with visualizing in 2 (or 3) dimensions. Three of the most common methods of ordination are; Principal component analysis (PCA), Principal Coordinates Analysis (PCoA), and Non-metric multidimensional scaling (NMDS).

  <img src="http://ordination.okstate.edu/overvi5.gif" width="500" height="300" />  

     Example Figure 1. Principal Coordinates Analysis (PCoA) as a projection of samples connected by distances.

Finally, we can test the beta-diversity measures to test for clustering of samples by specific metadata variables. In this step, we'll discuss 2 permutation-based statistical methods:
  * Analysis of similarities (ANOSIM) 
  * Permutational Multivariate Analysis of Variance Using (PERMANOVA)


## Learning Objectives:
At the end of step 2, you'll know how to:
* Calculate beta-diversity on microbiome/resistome data
* Visualize beta-diversity using ordination
* Test for statistical differences between sample clusters


### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson3_Step2_Ordination_stats.R"
6. Explore the website https://sites.google.com/site/mb3gustame/ for more information on multivariate analysis and (dis)similarity measures.

### Lesson 3 Step 2) Deliverable
After completing the task for Lesson 3 step 2:
* Create an ordination plot using the "bray-curtis" distance of the resistome data at the "Class" level (with any additional flair you want to add). 
  * NB. If you try to replicate all the code for the resistome data, delete the "DPCoA" method from the "ord_meths" R object. DPCoA requires a phylogenetic tree and will cause an error with the resistome data.
* Then, use "adonis()" to test for differences between the "Group" metadata variable. 
* Export the ordination plot and send it to us at "meglab.metagenomics@gmail.com" along with a short description of your findings and your model selection.
  * Don't worry about giving us the perfect answer, the goal is just to use your comments as a starting point for discussing statistics at the next course session.



---
# Step 3 - Differential abundance testing with a Zero-inflated Gaussian model
### Identifying differentially abundant features
In Lesson 3 step 2, we looked at comparing the microbiome/resistome composition of sample groups. With perMANOVA, we were able to estimate the influence of certain taxa on differences between sample groups, but we did not test for significant differences in the abundance of each feature.

Differential abundance (DA) testing is often a critical component in your analysis, but as we've re-iterated again and again, there is no "gold-standard" for many of these analyses. Additionaly, the correct method for testing differential abundance in compositional and sparse count data is still under debate, with new methods being published almost yearly. Therefore, similar to in step 2, we'll show you a few different methods that you can use for DA. Then, we'll focus on the DA method that MEG currently uses, a zero-inflated Gaussian model (ZIG).

### Learning objectives
* Test for differential abundance of features in the microbiome/resistome between treatment "Group" using the zero-inflated Gaussian model.
* Create basic plots of the ZIG results.

### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project for this Course → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson3_Step3_Differential_abundance_testing.R"

### Step 3) Deliverable
* Modify the code from "Lesson3_Step3_Differential_abundance_testing.R" and use a ZIG model to test for differential abundance of resistome features between treatment "Group" at the class level. Create a simple volcano plot that shows the ZIG results. Send an email to meglab.metagenomics@gmail.com with your figure and include short description of what the ZIG results suggest about the data. Keep in mind the ordination and adonis() results from Lesson 3 Step 2.
  * Again don't worry about giving a perfect description, just keep summarize the overall trends (e.g. X features were significantly different, etc)

---

# Step 4 - Advanced plotting
### Many options for plotting figures
As we've seen thus far, there are many ways to visualize your metagenomic data. In Lesson 3 Step 4, we'll go over a few more examples for ways to plot your data with heatmaps and volcano plots.


### Learning objectives
* Be able to plot different types of heatmaps, with sample and feature clustering
* Create informative volcano plots to visualize differential abundance testing results.

### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project for this Course → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson3_Step4_Advanced_plotting.R"


### Step 4) Deliverable
* This is the final deliverible for our course. Instead of assigning a specific deliverable, play around with the code you have learned to use so far and make a figure that you think summarizes the main trends in the microbiome data. Send your figure to "meglab.metagenomics@gmail.com".

---

# Step 5 - Learn to run MEG R GUI code for exploratory figures
###

### Task

### Step 5) Deliverable



