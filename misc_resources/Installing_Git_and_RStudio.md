# Installing Git and RStudio

Once you have RStudio installed in your computer. We recommend using R projects to manage your various datasets. Additionaly, we recommend you use RStudio in combination with github for version control. In this course, we use github to store all of the material for the MEG intro stats course. By following the instructions below, we can each create an R project on our computer with the MEG course materials, but most importantly, we can update the code on our local computer to match any updates made to the code on the github repository. This is called "pulling" the branches for the latest update and will update all of the files besides any that you give a new name too. There are many other uses for this, but we'll focus on using it for this course. 

# Installing R studio
This tutorial shows you how to install R and R studio on your computer following [these instructions](https://www.datacamp.com/community/tutorials/installing-R-windows-mac-ubuntu).
* This installation can include "git", the software required to interface with github. If you run into issues using git, use the details below to troubleshoot the installation of git and connection with Rstudio.

# Creating an R project tied to a github account
1. Open RStudio.
2. Select File → NewProject…

<img src="
https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/example_pictures/example_Rstudio_github_make_project.PNG" width="1200" height="800" />  

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
    
    
# Troubleshooting missing Git on RStudio
