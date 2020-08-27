# Introduction to statistical analysis of metagenomic sequencing data
## Course syllabus
Start Date: May 11, 2020

Email: meglab.metagenomics@gmail.com
  * Paul Morley - pmorley@tamu.edu
  * Noelle Noyes - nnoyes@umn.edu
  * Enrique Doster - enriquedoster@gmail.com

Slack group: https://meg-research.slack.com
  * Join us here for general discussion and help with course content
  * [Slack invite link](https://join.slack.com/t/meg-research/shared_invite/zt-ej7f576o-QfNwH_yfg0ljyvk3K~ORDg)
    * This link expires every 30 days, so let us know if it doesn't work for you.

[Dropbox link](https://www.dropbox.com/sh/1xvpvxecesddfsc/AADYGmwC1p52eBeYjy_4qJ_-a?dl=0)
  * This dropbox folder contains all of the videos from our zoom course sessions and recordings from a previous MEG bioinformatics workshop.


[![Binder](https://mybinder.org/badge_logo.svg)](https://hub.gke.mybinder.org/user/enriquedoster-m-ro_stats_course-ag2p4r3f/tree)

[![RStudio Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/EnriqueDoster/MEG_intro_stats_course/master?urlpath=rstudio)

https://mybinder.org/v2/gh/EnriqueDoster/MEG_intro_stats_course/master?urlpath=rstudio

## Course content
* [Course summary](#summary)
* [Learning objectives](#learning-objectives)
* [Resources](#resources)
* [Timeline](#timeline)
* [Deliverables](#deliverables)

### Summary
These lessons are designed to introduce researchers to the R programming language for statistical analysis of metagenomic sequencing data. While we are primarily developing these training resources for the Microbial Ecology Group (MEG), we would love to get your input on improvements to any component so that we can one day provide this as a useful public resource. As the lessons are meant to be an informal collection of resources and tutorials, we have have liberally used parts and pieces of other online lessons and tailored it for our purposes. We attempt to give credit when possible by linking the original source and we are happy to hear recommendations for other resources to include.

The focus of lesson 1 is to help students install R on their computer, install the necessary R packages, and start playing around with R's functionality. In Lesson 2, students will learn how to calculate and plot summary statistics, including alpha-diversity indices to summarize the microbiome and resistome. In Lesson 3, we'll dive into count normalization using cumulative sum scaling (CSS), ordination with non-metric multidimensional scaling, differential abundance testing with a zero-inflated Gaussian (ZIG) model, and advanced plotting using ggplot2.

This will be the first time that we attempt going through this lesson with a group of students, so please participate in the slack group and ask any questions you have!
* We'll organize a group to all take the same lesson together and **we'll have a virtual meeting once per week for 30 minutes** to go over each of the steps in that lesson. The majority of the work will be self-directed and on your own time, but we encourage you to work in groups and participate in asking questions in the slack group. If you don't have any questions and find this all extremely easy, please help others with their questions and help us improve our lessons.
  * There is 1 "deliverable" per step. Some steps require something be sent to "meglab.metagenomics@gmail.com" or will have a link to a corresponding set of questions.

### Techie time
We wholeheartedly encourage students to independently troubleshoot the majority of problems they might encounter by:
* googling it (or using another search engine)
* getting help from other students by using our slackgroup channel #2020-stats-tutorial-group
* searching bioinformatic forums such as (stackoverflow.com, biostars.org, seqanswers.com, etc.)

In addition, we will have "techie time" every Monday at 12pm-2pm MST on Slack to help address any ongoing issues.


### Learning objectives:
Upon completion of these lessons, students will:
* have their computer set up with the R and RStudio software
* know how to read-in count matrices from bioinformatic analysis of sequence data
* be able to explore and summarize bioinformatic results using
  * diversity indices and box plots
  * ordination with non-metric multidimensional scaling (NMDS)
  * heatmaps
* be familiar with common statistical techiniques such as:
  * Wilcoxon test
  * Generalized linear models
  * Analysis of similarities (ANOSIM)
  * Differential abundance testing using a zero-inflated Gaussian (ZIG) model

### Resources:
MEG resources
* [MEG bioinformatic term glossary](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Glossary.md)
* [AMR ++ pipeline overview](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/AMR%2B%2B_v2_pipeline_overview.pdf)
* [Bioinformatic AMR and 16S pipeline overview](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Bioinformatic_AMR_and_16S_pipeline_overview.pdf)
* [Bioinformatics statistics overview](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Bioinformatic_statistics_overview.pdf)

R programming
* [RStudio cheatsheets](https://rstudio.com/resources/cheatsheets/)
  * This website has tons of helpful cheatsheets for various R packages and analyses methods. Also includes cheatsheets translated to other languages.
* [YaRrr! The Pirate’s Guide to R](https://bookdown.org/ndphillips/YaRrr/)
  * This is a free online book that goes over many useful topics in a quirky, but fun way! Follow along with our simplified R scripts in Lesson 1 and reference this book if you have any other questions.
* [R programming coursera course](https://www.coursera.org/learn/r-programming)
  * This free coursera course goes in-depth with all of the functionality of R. It combines videos with example R scripts for you to follow along with. We recommend this course after you have been playing around with R a bit and want to learn more about the details into how R works.
* [Introduction to R workshop](https://bioinformatics.ca/workshops/2018-introduction-to-R/)
  * We haven't personally tried this workshop, but they have a combination of videos, slides, and R code for various topics.

Data visualization
* [dataviz project](https://datavizproject.com/)
  * This website is for a private company, but they have a great interface for exploring different figure types
* [Visual vocabulary](https://gramener.github.io/visual-vocabulary-vega/#)
   * Handy outline and explanation for the uses of different plots.
   * You can also check out [this interactive figure](http://ft-interactive.github.io/visual-vocabulary/) of the same material
* [FT Visual Journalism Team](https://www.ft.com/visual-and-data-journalism)
  * Awesome site with articles covering various topics and with the emphasis on creating awesome graphics to convey
* [Interactive Jupyter notebooks](https://voila-gallery.org/)
  * Also use [this site for neat jupyter tips and tricks](https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/)

Command-line
* [Explain shell](https://explainshell.com/)
  * cool website that explains bash commands piece by piece


Statistics
* [GUide to STatistical Analysis in Microbial Ecology (GUSTA ME)](https://mb3is.megx.net/gustame)
* [LHS 610: Exploratory Data Analysis for Health](https://kdpsingh.lab.medicine.umich.edu/lhs-610)
  * We haven't personally tried this course, but they provide great videos and code examples for learning how to explore data using R.
* [#bioinformatics live twitter feed](https://twitter.com/search?q=%23bioinformatics&src=hash)
* R-specific resources
  * [ggpubr](http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/76-add-p-values-and-significance-levels-to-ggplots/)
    * Nice package for "publication-ready" figures.
  * [Harvard's Data Science: R Basics](https://www.edx.org/course/data-science-r-basics)
* [Collaborative spreadsheet of resources](https://docs.google.com/document/d/1A9BbOCsrg1ikLaBltKhXVKj-eetlrBqR-1u-2V99I2c/edit#)
* [Choose the right test](https://stats.idre.ucla.edu/other/mult-pkg/whatstat/)
* Batch effects
  * [Tackling the widespread and critical impact of batch effects in high-throughput data](https://www.nature.com/articles/nrg2825)
  * [Why Batch Effects Matter in Omics Data, and How to Avoid Them](https://www.sciencedirect.com/science/article/pii/S0167779917300367?casa_token=HQ5ZeDg7XccAAAAA:djpolv0azNOtCZk9XaKjUw8Z1A055LbdgtwFg8CLf6_B4jZggIdVv4GI2dvrDzS8i-LBp9p1aQ)
  * [Beware the bane of batch effects](https://bitesizebio.com/20998/beware-the-bane-of-batch-effects/#:~:text=Batch%20effects%20occur%20whenever%20external,a%20wrench%20in%20your%20findings.)
  * [Mitigating the adverse impact of batch effects in sample pattern detection](https://academic.oup.com/bioinformatics/article/34/15/2634/4916062)
  * [Identifying and mitigating batch effects in whole genome sequencing data](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-017-1756-z)
  * [Why Batch Effects Matter in Omics Data, and How to Avoid Them](https://www.cell.com/trends/biotechnology/pdf/S0167-7799(17)30036-7.pdf)

## Timeline
We'll start on May 11, 2020 at 12pm MT and have weekly virtual meetings on zoom. Please check Slack for updates!

[Lesson 1 "Getting set-up with R"](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/lessons/Statistics_lesson_1.md)
* Step 1 - Download and install R/RStudio
  * Start: May 11, 2020
  * Requested completion: May 17, 2020
    * If you finish with time to spare, move on to Step 2. In the case that everyone finishes Step 2 before our next meeting on May 18, we can move on to Step 3 ahead of schedule.
* Step 2 - Install R packages
  * Start: May 18, 2020
  * Requested completion: May 31, 2020
* Step 3 - Introduction to R
  * Start: May 18, 2020
  * Requested completion: May 31, 2020
* Step 4 - Reading-in data to R
  * Start: June 1, 2020
  * Requested completion: June 7, 2020

[Lesson 2 - Data exploration and basic statistics](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/lessons/Statistics_lesson_2.md)
* Scheduled to begin June 8, 2020. Dates will be updated as we finalize scheduling.
* Step 1 - Calculating summary statistics
  * Start: June 9, 2020
  * Requested completion: June 14, 2020
* Step 2 - Introduction to plotting
  * Start: June 15, 2020
  * Requested completion: June 21, 2020
* Step 3 - Basic statistical testing (wilcoxon, linear models)
  * Start: June 22, 2020
  * Requested completion: June 28, 2020

[Lesson 3 - Advanced statistical analyses and plotting](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/lessons/Statistics_lesson_3.md)
* Scheduled to begin July 9, 2020. Dates will be updated as we finalize scheduling.
* Step 1 - Count normalization
  * Start: July 9, 2020
  * Requested completion: July 15, 2020
* Step 2 - Ordination with non-metric multidimensional and statistical comparisons
  * Start: July 16, 2020
  * Requested completion: July 22, 2020
* Step 3 - Differential abundance testing with a Zero-inflated Gaussian model
  * Start: July 23, 2020
  * Requested completion: July 29, 2020
* Step 4 - Advanced plotting (heatmaps, volcano plots, ordination)
  * Start: July 30, 2020
  * Requested completion: August 5, 2020
* Step 5 - Learn to run R GUI code for exploratory figures
  * Start: August 6, 2020
  * Requested completion: August 12, 2020

## Deliverables:
Lesson 1 deliverables
* For Step 1 and 2, students must send a screenshot of their "sessionInfo()" to ensure that R and R studio are installed in addition to the necessary R packages, respectively.
* Step 3 - After familiarizing themselves with some basic R functionality, students will submit a short quiz.
* Step 4 - Given a count matrix file, taxonomy file, and sample metadata file, students must read-in all data to R and submit a short quiz.

Lesson 2 deliverables
* Step 1 - Students will calculate summary statistics for the microbiome/resistome and will submit a quiz.
* Step 2 - Students will learn to create different figures using ggplot2. They will follow instructions to create and submit two custom figures.
* Step 3 - Using the summary statistics from step 2, students will test for statistical differences between sample groups.

Lesson 3 deliverables
* TBD

## Funding Information:
The development of this tutorial was supported in part by USDA NIFA Grant No. 2018-51300-28563, University of Minnesota College of Veterinary Medicine, The VERO Program at Texas A&M University and West Texas A&M University, and the State of Minnesota Agricultural Research, Education, Extension and Technology Transfer program.

