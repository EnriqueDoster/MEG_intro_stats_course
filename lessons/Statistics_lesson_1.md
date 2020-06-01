# Lesson 1 - "Getting set up"

## Learning objectives
* Describe R, RStudio, and environment.
* Use RStudio to test basic R functionality
* Read-in data and provide basic summary information

## Task overview:
We will break up this lesson into 4 steps. We'll meet once a week to discuss each step and students will independently work on the "task" and associated "deliverable" that must be sent to meglab.metagenomics@gmail.com.
* [Step 1](#step-1---install-r-and-rstudio): Download and install R/RStudio
* [Step 2](#step-2---install-r-packages): Install R packages
* [Step 3](#step-3---introduction-to-r): Introduction to R
* [Step 4](#step-4---reading-in-data-to-r): Reading-in data to R


## Additional resources:
  * [R programming coursera course](https://www.coursera.org/learn/r-programming)
  * [Introduction to R workshop](https://bioinformatics.ca/workshops/2018-introduction-to-R/)
  * [R cheat sheets](https://rstudio.com/resources/cheatsheets/)


---

# Step 1 - Install R and Rstudio
### What is R and why do we use it?
["R"](https://www.r-project.org/about.html) is an open-source programming language that we use for analyzing microbiome and resistome results. R is highly extensible and provides access to a variety of statistical (linear and nonlinear modelling, classical statistical tests, time-series analysis, classification, clustering, …) and graphical techniques.
  * R is available as free software under the terms of the Free Software Foundation’s GNU General Public License in source code form. It compiles and runs on a wide variety of UNIX platforms and similar systems (including FreeBSD and Linux), Windows and MacOS.
  * R is used by entering commands into the R terminal.
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/R_Terminal.png/800px-R_Terminal.png" width="300" height="200" />

  * While using R in this command-line format can be beneficial for certain uses, we recommend the use of Rstudio.
  * [RStudio](https://rstudio.com/) is a GUI software that facilitates the use of R by breaking up information into 4 panels.
    * Source Editor, Console, Workspace Browser (and History), and Plots (and Files, Packages, Help). These can also be adjusted under the 'Preferences' menu.
<img src="https://sfg-ucsb.github.io/fishery-manageR/images/rstudio_ide.png" width="400" height="300" />  

#### Asking for help with R.
* If you find that you can’t answer a question or solve a problem yourself, you can ask others for help, either locally (if you know someone who is knowledgeable about R) or on the internet. In order to ask a question effectively, it helps to phrase the question clearly, and, if you’re trying to solve a problem, to include a small, self-contained, reproducible example of the problem that others can execute.
 * For information on how to ask R-related questions, see:
   * The [R mailing list posting guide](https://www.r-project.org/posting-guide.html)
   * The document about [how to create reproducible examples for R on Stack Overflow](https://stackoverflow.com/help/minimal-reproducible-example).

### Task
* Install R and R studio on your computer following [these instructions](https://www.datacamp.com/community/tutorials/installing-R-windows-mac-ubuntu).
  * For now, ignore the part about "installing packages", we'll revisit this in the next step.
* Explore these websites for troubleshooting errors with R.
  * [R mailing list](https://www.r-project.org/mail.html)
  * [Stack overflow](https://stackoverflow.com/questions/tagged/r)
* Watch the following videos from our workshop on Bioinformatics for Shotgun Metagenomic Research – December 2, 2017
Held in Conjunction with the Conference of Research Workers in Animal Diseases, Chicago, IL.
  * [Introduction to Genetic Sequencing for Metagenomic Research (46 min)](https://echo360.org/media/94fbcc5c-093e-423c-88e1-447e6888e3a0/public)
  * [Skillsets and Teams Needed for Metagenomic Research (11 min)](https://echo360.org/media/89db59b5-5dc8-4774-8b1b-37b9c560ff71/public)

### Step 1) Deliverable
* Using RStudio, run the command below and send a screenshot to "meglab.metagenomics@gmail.com"
```
sessionInfo()
```

# Step 2 - Install R packages
### Packages greatly enhance R functionality for statistical analysis
The basic functions included with base R are useful on their own, but the power of R comes from third-party add-on libraries.
R packages are developed for specific purposes and are often uploaded to public repositories, where they can be easily accessed. The most popular repositories for R packages are:
* The [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/) is the main repository for R packages and has > 10,000 packages and has been growing steadily since it R was developed.
<img src="https://revolution-computing.typepad.com/.a/6a010534b1db25970b01b8d2594d25970c-800wi" width="400" height="300" />  

* [Bioconductor](https://www.bioconductor.org/) is a repository emphasizing R packages for bioinformatics.
* [Github](https://github.com/) is not specifically for R packages, Github is probably the most popular repository for open source projects. However, unlike CRAN and Bioconductor, github does not have a review process associated with it.

For our metagenomic projects, we use R packages to help with data processing of bioinformatic results, count normalization, and statistical analyses.

Most packages can be installed using the simple command "install.packages()'. Like this:
```
install.packages("ggplot2")
```

Once the package is installed, you can load the package like this:
```
library(ggplot2)
```

In the task for Step 2, we'll install all of the R packages that are relevant to our research in the Microbial Ecology Group.


### Task
* Learn how to install R packages with the following [tutorial for installing R packages](https://www.datacamp.com/community/tutorials/r-packages-guide) and succesfully install all of the following packages in your environment:
  * From CRAN:
    * tidyr
    * vegan
    * ggplot2
    * data.table
    * dplyr (added this one late, sorry!)
  * From Bioconductor (try to install these, but move on if you are getting errors):
    * phyloseq
    * metagenomeSeq
* Watch the following videos from our previous workshop:
  * [Sequencer Output Files (19 min)](https://echo360.org/media/029c1462-2e28-4899-99b5-d759bd8f0d2b/public)

### Step 2) Deliverable
* Use "library()" to load each of the packages you just installed.
* Then, just like in Step 1, run "sessionInfo()" and send a screenshot to "meglab.metagenomics@gmail.com"


# Step 3 - Introduction to R
### R scripts and "R projects"
R code can be run directly in the R terminal, or can be organized in to a series of steps within an [R script](http://mercury.webster.edu/aleshunas/R_learning_infrastructure/R%20scripts.html). R scripts facilitate reproducibility as all your code can be stored in a single file and shared for others to replicate. It's also really helpful that you can leave comments in your code by starting a line with "#". This is really helpful for yourself and others to understand what your code is doing.

For example:
```
# If this was a script, this comment wouldn't be "run"
print("However, this line would work just fine")

# You can also leave comments after the command like this:
print("Nothing to the right of the hashtag will be printed") # You can only see this in the "code editor" panel and not the console

```


We use [RStudio projects](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) because it makes it easy to organize different datasets, each with their own working directory, workspace, history, and source documents.

The **working directory** is a location, or file path, on your computer that sets the default location for where R will look for files you try to load and where R will output any files you create.

In other words, a working directory is like a little flag somewhere on your computer which is tied to a specific analysis project.
* If you ask R to import a dataset from a text file, or save a dataframe as a text file, it will assume that the file is inside of your working directory, also known as the "relative path". For example, if you know that there is a folder in your working directory called "scripts" and it contains a "file.txt", you could specify it's relative location like this:

```
scripts/file.txt
```
* Alternatively, you can access files from anywhere in your computer if you know it's exact location, or "absolute path". For example, on windows computers you could specify the location of the "file.txt" on your desktop like this:

```
# Windows
c:\Users\username\Desktop\file.txt

# Linux
/home/username/Desktop/file.txt

# Mac
/Users/username/Desktop/file.txt
```

You can only have one working directory active at any given time. The active working directory is called your "current working directory". We simplify how to manage these working directories by creating a workspace for each of your projects.
  * To see your current working directory, use the following command:

```
getwd():
```

During an R session, you might define a large number of R-objects: variables, data structures, functions etc., and you might load packages and scripts.
* All of this information is stored in the so-called "Workspace". When you quit R you have the option to save the Workspace; it will then be restored in your next session.
  * Now, you might think: how convenient - I can just stop R, and when I restart it, it will go into the same state as it was. But no. Restoring the Workspace from a previous state is actually a bad idea: if you load data or variables in a startup script, they may be overwritten with a corrupted version that you happened to save in the workspace when you last quit.
    * This is very hard to troubleshoot. Essentially, when you save and reload your Workspace habitually, you have overlapping and potentially conflicting behavior of startup script and Workspace restore.
* Instead, we recommend the following workflow:
  * Once the Workspace is created, never save the workspace.
    * The one exception is if you have finalized all of your analyses for a manuscript and want to provide the entire workspace to co-authors or reviewers.
  * Always save and work from scripts.
    * I typically make a "scripts" folder in the workspace and store all necessary scripts with descriptive names.
    * In this case, you'll be using code from our [github stats course repository](https://github.com/EnriqueDoster/MEG_intro_stats_course).
      * It's **really important** to change the name of the script that you are modifying. That way, you can get the latest code from our repository by using the built-in "git" function and not worry about losing your edits.

  * Write your scripts so that you can easily recreate all objects you need to continue your analysis.
    * If some specific objects are expensive to compute (machine learning, networks, etc), you can always save() and later load() them explicitly. In fact, restoring the Workspace does the same thing, but you have less control regarding whether the version of your objects are correct, and what temporary variables may be loaded as well.
    * In this way, you work with explicit instructions, not implicit behaviour.
    * In coding, **"Explicit beats implicit"**
      * See the ["Zen of Python"](https://www.python.org/dev/peps/pep-0020/) for more programming-related guiding principles.


### Task
R task
1. Open RStudio.
2. Select File → NewProject…
3. Click on Version Control.
4. Click on Git.
5. Enter "https://github.com/EnriqueDoster/MEG_intro_stats_course" as the Repository URL
6. The project directory name should automatically fill out, or you could change it to anything else you want.
7. Click on Browse… navigate to where you want the project to be created on your computer.
8. Click Open.
9. Click Create Project which will cause the project files to be downloaded and RStudio should re-start with the new project data.
  * NB. Your working directory is now set to the location you selected in step 7 and should include all of the files in the course github directory.
10. Look at the bottom right panel in Rstudio to view the files in your new working directory.
  * Click on the "scripts" directory (NB This does not change your working directory)
  * Open the "Lesson1_step3_R_introduction.R" script by clicking on it.
  * Follow instructions on the script to get familiarized with R.
    * To move through the script one line at a time, you can use "CTRL + ENTER" or "CMD + ENTER" in the 

After playing around with R, watch the following videos from our previous workshop to prepare for Step 4:
  * [Sequence Data QC & Introduction to Computing Pipelines (17 min)](https://echo360.org/media/cbfa8587-ee54-4ba7-810c-cfefdd082258/public)
  * [Databases (19 min)](https://echo360.org/media/153f0f30-ad90-4949-93e9-cc12f19be9ce/public)
  * [Kmer Classification Algorithms (18 min)](https://echo360.org/media/bf9507a5-ad60-4528-bcb7-e70e5422595b/public)



### Step 3) Deliverable
* Answer the questions on this document ["Lesson1-Assignment1_IntrotoRandRStudio.docx"](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/lessons/deliverables/Lesson1-Assignment1_IntrotoRandRStudio.docx) and submit the answers to meglab.metagenomics@gmail.com



# Step 4 - Reading-in data to R
### Analyzing data from files

#### The goal of Step 4 is to teach you how to load in data to R and begin exploring the results from bioinformatic results from metagenomic sequencing analysis.

Undoubtedly, we couldn't do all of the cool statistics in R without importing data from the outside world. For example, in Step 3 we saw that you could manually input all of the data into an R object, but clearly this is highly inefficient for large datasets. Luckily, by using R in combination with other packages, we can read-in just about any type of file format.

From a statistical point of view, the output of both microbiome approaches, amplicon and shotgun sequencing, as well as resistome sequencing, is similar: an abundance table of counts representing the number of sequences per sample for a specific feature (e.g. taxa, AMR gene, etc.).


For example, we'll be using the following count matrix with AMR features in the rows (MEG..) and sample names in the colummns (CF..):

<img src="https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/example_pictures/example_megares_count_matrix.png" width="1200" height="400" />  


Depending on your goals and type of data, there are many different bioinformatic pipelines that you could use. Here are two pipelines we'll discuss in this course:
* [AMR++](https://github.com/meglab-metagenomics/amrplusplus_v2)
  * For resistome and microbiome analysis of shotgun metagenomic sequencing data
  * Uses alignment to the MEGARes resistance database for resistome characterization and kraken2 for k-mer based classification of the microbiome.
  * The results are comma-delimited (.csv) count matrices summarizing the counts of features in the rows for samples in the columns.
* [Qiime2](https://qiime2.org/)
  * For microbiome analysis of 16S sequencing data. 
  * Uses DADA2 to create "amplicon sequence variants" (ASVs) and classifies them using a bayesian classifier trained on the GreenGenes 16S rRNA sequence database. 
  * ASVs are basically the new "operational taxonomic unit (OTU)" that you might have seen in other manuscripts, but now defined by clustering reads with 100% sequence identity compared to the typical 97% used for manuscript.
  * Results are provided in the ".qza" format and can be analyzed using other plugins included with Qiime2.
  * As this can limit our analysis options, we export the results into a ".biom" format which contains the counts for each sample.
  

In this step, we'll go over how to read-in data from common text file formats, comma-delimited and tab-delimited. We'll introduce you to typical results from microbiome and resistome analysis by going over:
* count tables
* annotation files (taxonomic and for AMR)
* sample metadata

Additionally, we'll learn how to read-in results from analyzing 16S samples with Qiime2 by using phyloseq to import:
* count tables in the ".biom" format
* In the next steps we'll add:
  * phylogenetic trees
  * aligned fasta sequences

Once we have the data in R, we will learn how to explore bioinformatic results and describe:
* the number of rows and columns for each file
* what each file contains
* what the taxonomy file is used for and how it relates to the count tables.



### Task

Before moving on to the R script below, watch this video which highlights the output from our bioinformatic pipeline, AMR++. There are many other bioinformatic pipelines, but ultimately the results are a count matrix which we will learn to analyze statistically.
  * [AMR++ Pipeline Output (42 min)](https://echo360.org/media/6b50819b-0920-48eb-a6fa-9ca7996c723d/public)
Use the same R project from step 3 and follow instructions in the R script, "Lesson1_R_file_exploration.R".

To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
  * As long as you saved any changes you made with new file names, this will update everything else in the repository to catch up with the "master" branch.
5. Follow the instructions in the script, "Lesson1_step4_R_file_exploration.R"

### Step 4) Deliverable
After finishing the task in Lesson 1 step 4, use the skills you've learned so far to answer the questions on the following survey:
https://www.surveymonkey.com/r/XFS53GL


