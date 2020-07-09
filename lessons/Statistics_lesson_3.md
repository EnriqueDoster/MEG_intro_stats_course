# Lesson 3 - "Advanced statistical analyses and plotting"

## Learning objectives
* normalize count matrices to account for differences in sequence depth
* visualize multivariate data with ordination and statistically compare sample clustering
* compare differential abundance for individual taxa using a Zero-inflated Gaussian model
* be able to run MEG's R GUI code to automate data processing and the creation of exploratory figures
* learn to make ordination plots, heatmaps, and volcano plots

## Lesson 3 overview:
We will break up this lesson into 5 steps. We'll meet once a week to discuss each step and students will independently work on the "task" and associated "deliverable" that must be sent to meglab.metagenomics@gmail.com.
* [Step 1](#step-1---count-normalization): Count normalization
* [Step 2](#step-2---ordination-with-non---metric-multidimensional-scaling-and-statistical-comparisons): Ordination with non-metric multidimensional scaling and statistical comparisons
* [Step 3](#step-3---differential-abundance-testing-with-a-zero---inflated gaussian-model): Differential abundance testing with a Zero-inflated Gaussian model
* [Step 4](#step-4---learn-to-run-meg-r-gui-code-for-exploratory-figures): Learn to run MEG R GUI code for exploratory figures
* [Step 5](#step-5---advanced-plotting): Advanced plotting (heatmaps, volcano plots, ordination)


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

# Step 1 - Count normalization

### Addressing bias with count normalization
As we have been reviewing in this course, there are multiple sources of bias that can be introduced in a metagenomic sequencing study. Please review the recording of our class session on July 9, 2020(in the dropbox folder) as we discuss how count normalization can help address sources of bias.

In this course, we'll focus on addressing differences in sequencing depth, but below are a few other examples for your consideration. Adapted the following figures from the HBC training course, ["Intro to DGE"](https://hbctraining.github.io/DGE_workshop/).
* Sequencing depth: Accounting for sequencing depth is necessary for comparison of gene expression between samples. In the example below, each gene appears to have doubled in expression in Sample A relative to Sample B, however this is a consequence of Sample A having double the sequencing depth.

  <img src="https://hbctraining.github.io/DGE_workshop/img/normalization_methods_depth.png" width="600" height="300" />  
    
      NOTE: In the figure above, each pink and green rectangle represents a read aligned to a gene. Reads connected by dashed lines connect a read spanning an intron.
    
* Gene length: Accounting for gene length is necessary for comparing expression between different genes within the same sample. In the example, Gene X and Gene Y have similar levels of expression, but the number of reads mapped to Gene X would be many more than the number mapped to Gene Y because Gene X is longer.

  <img src="https://hbctraining.github.io/DGE_workshop/img/normalization_methods_length.png" width="500" height="300" />  
  
  * Gene length might have not greatly impact your 16S rRNA sequencing projects, but this is an important consideration when targeting genes with variable sequence lengths (e.g. virulence factors, mobile genetic elements, metabolic genes, etc). We won't go over this example in our course, but we have also previously used the equation first described by [Li et. al. 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4611512/?report=reader). Equation shown below:

  <img src="https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/example_pictures/Li_equation_AMR_gene_abundance.png" width="600" height="200" />  

     In the equation above, N<sub>AMR−likesequence</sub> is defined as the number of alignments to one specific AMR gene sequence; L<sub>reads</sub> as the sequence length of the Illumina reads (125 nt); L<sub>AMRreferencesequence</sub> as the sequence length of the corresponding AMR gene sequence; N<sub>16Ssequence</sub> as the number of alignments to 16S sequences; and L<sub>16Ssequence</sub> as the average length of the 16S sequences in the Greengenes database (mean = 1,401 nt). 
    
## Learning Objectives:
** Disclaimer) As in Lesson 2 Step 3, we can't go over all the nuances of selecting the best normalization method for your data, and as we have discussed, the statistical analyses for metagenomic studies require many nuanced decisions, each of which has the potential to substantially impact study results **

In lesson 3, step 1 you'll learn how to perform the following normalization methods**:
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






---

# Step 2 - Ordination with non-metric multidimensional scaling and statistical comparisons
###

### Task
* To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
5. Follow the instructions in the script, "Lesson2_basic_plotting.R"

### Step 2) Deliverable





---

# Step 3 - Differential abundance testing with a Zero-inflated Gaussian model
###

### Task

### Step 3) Deliverable




---

# Step 4 - Learn to run MEG R GUI code for exploratory figures
###

### Task

### Step 4) Deliverable




---

# Step 5 - Advance plotting
###

### Task

### Step 5) Deliverable
