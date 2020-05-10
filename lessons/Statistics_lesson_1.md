# Lesson 1 - "Getting set up"

## Learning objectives
* Describe R, RStudio, and environment
* Use RStudio to test basic R functionality
* Read-in data and provide basic summary information

## Tasks:
We will break up this lesson into 4 steps. We'll meet once a week to discuss each step and students will independently work on the "task" and associated "deliverable" that must be sent to meglab.metagenomics@gmail.com.
* [Step 1](#step-1---install-r-and-rstudio): Download and install R/RStudio
* [Step 2](#step-2---install-r-packages): Install R packages
* [Step 3](#step-3---introduction-to-r-programming): Introduction to R
* [Step 4](#step-4---reading-in-data): Learn how to read-in data to R and provide general information about files.


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

In the task for Step 2, we'll install all of the R packages that are relevant to our research in the Microbial Ecology Group.


### Task
* Learn how to install R packages with the following [tutorial for installing R packages](https://www.datacamp.com/community/tutorials/r-packages-guide) and succesfully install all of the following packages in your environment:
  * From CRAN:
    * tidyr
    * vegan
    * ggplot2
    * data.table
    * gridExtra
    * geometry
    * rgl
    * scales
    * RColorBrewer
    * ggthemes
  * From Bioconductor (try to install these, but move on if you are getting errors):
    * phyloseq
    * metagenomeSeq
### Step 2) Deliverable
* Just like in Step 1, run "sessionInfo()" and send a screenshot to "meglab.metagenomics@gmail.com"


# Step 3 - Introduction to R programming
### R scripts and "projects"
R code can be run directly in the R terminal, or can be organized in to a series of steps within an [R script](http://mercury.webster.edu/aleshunas/R_learning_infrastructure/R%20scripts.html). R scripts facilitate reproducibility as all your code can be stored in a single file and shared for others to replicate.

[RStudio projects](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) make it easy to organize different datasets, each with their own working directory, workspace, history, and source documents.
* The working directory is just a file path on your computer that sets the default location of any files you read into R, or save out of R. In other words, a working directory is like a little flag somewhere on your computer which is tied to a specific analysis project.
  * If you ask R to import a dataset from a text file, or save a dataframe as a text file, it will assume that the file is inside of your working directory.
  * You can only have one working directory active at any given time. The active working directory is called your current working directory. We simplify how to manage these working directories by creating a workspace for each of your projects or datasets.
  * To see your current working directory, use
```
getwd():
```
* During an R session, you might define a large number of R-objects: variables, data structures, functions etc., and you might load packages and scripts.
* All of this information is stored in the so-called "Workspace". When you quit R you have the option to save the Workspace; it will then be restored in your next session.
  * Now, you might think: how convenient - I can just stop R, and when I restart it, it will go into the same state as it was. But no. Restoring the Workspace from a previous state is actually a bad idea: if you load data or variables in a startup script, they may be overwritten with a corrupted version that you happened to save in the workspace when you last quit.
    * This is very hard to troubleshoot. Essentially, when you save and reload your Workspace habitually, you have overlapping and potentially conflicting behaviour of startup script and Workspace restore.
  * Instead, we recommend the following:
    * Once the Workspace is created, never save the workspace.
      * The one exception is if you have finalized all of your analyses for a manuscript and want to provide the entire workspace to co-authors
    * Always save and work from scripts.
      * I typically make a "scripts" folder in the workspace to store all necessary scripts. 
    * Write your scripts so that you can easily recreate all objects you need to continue your analysis.
    * If some objects are expensive to compute, you can always save() and later load() them explicitly. In fact, restoring the Workspace does the same thing, but you have less control regarding whether the version of your objects are correct, and what temporary variables may be loaded as well.
  * In this way, you work with explicit instructions, not implicit behaviour.
  * Explicit beats implicit.


### Task
1. Open Rstudio and set working directory to the newly downloaded directory, "MEG_onboarding_lessons"
2. Create a new R project called "Lesson 1 project" and follow the instructions to familiarize yourself with basic R functions.
3. Open RStudio.
4. Select File → NewProject…
5. Click on Version Control.
6. Click on Git.
7. Enter "https://github.com/EnriqueDoster/MEG_training_tutorials" as the Repository URL
8. The project directory name should automatically fill out, or you could change it to anything else you want.
9. Click on Browse… to find where you want the project to be created.
10. Click Open.
11. Click Create Project; the project files should be downloaded and RStudio should re-start with the new project data.
  * NB. Your working directory is now wherever you selected to download the github files. 
12. Look at the bottom right panel in Rstudio to view files in your new working directory.
  * Click on the "Statistics" directory
  * Open the "Lesson1_R_introduction.R" script by clicking on it.
  * Follow instructions on the script to get familiarized with R. 

### Step 3) Deliverable
* Answer the questions for ["Lesson1-Assignment1_IntrotoRandRStudio.docx"](https://github.com/EnriqueDoster/MEG_onboarding_lessons/blob/master/Statistics/Lesson1-Assignment1_IntrotoRandRStudio.docx) and submit the answers to meglab.metagenomics@gmail.com

# Step 4 - Reading-in data
### Getting microbiome and resistome results into R

### Task

* Follow instructions in the R script, (XXXX), to load all three files and calculate summary statistics for each file.
* Given a count matrix file, taxonomy file, and sample metadata file, students must read-in all data to R and submit an email with the following information:
  * The number of rows and columns for each file.
  * A short description of what kind of samples are being analyzed.
  * A short description of what the taxonomy file contains and how it relates to the count table.


