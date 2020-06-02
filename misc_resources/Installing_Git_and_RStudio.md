# Installing RStudio and Git

Once you have RStudio installed in your computer. We recommend using R projects to manage your various datasets. Additionaly, we recommend you use RStudio in combination with github for version control. In this course, we use github to store all of the material for the MEG intro stats course. By following the instructions below, we can each create an R project on our computer with the MEG course materials, but most importantly, we can update the code on our local computer to match any updates made to the code on the github repository. This is called "pulling" the branches for the latest update and will update all of the files besides any that you give a new name too. There are many other ways you can use the connection with gitub, but we'll focus on the uses relevant for this course. 

## Table of contents
* [Installing R and RStudio](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Installing_Git_and_RStudio.md#creating-an-r-project-tied-to-a-github-repository)
* [Creating an R project tied to a github repository](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Installing_Git_and_RStudio.md#installing-r-and-rstudio)
* [Updating a local R project with Git](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Installing_Git_and_RStudio.md#updating-a-local-R-project-with-git)
* [Troubleshooting Git on RStudio](https://github.com/EnriqueDoster/MEG_intro_stats_course/blob/master/misc_resources/Installing_Git_and_RStudio.md#troubleshooting-git-on-rstudio)

# Installing R and RStudio
This tutorial shows you how to install R and R studio on your computer following [these instructions](https://www.datacamp.com/community/tutorials/installing-R-windows-mac-ubuntu).
* This installation can include "git", the software required to interface with github. If you run into issues using git, use the details below to troubleshoot the installation of git and connection with Rstudio.

# Creating an R project tied to a github repository

1. Open RStudio.

2. Select File → NewProject…
  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_make_project.PNG" width="1000" height="400" />  

3. Click on Version Control.
  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_make_project_version_control.PNG" width="500" height="400" />  

4. Click on Git.

  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_make_project_git.PNG" width="500" height="400" />  

5. Enter "https://github.com/EnriqueDoster/MEG_intro_stats_course" as the Repository URL
  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_make_project_git_repository.PNG" width="500" height="400" />  

6. The project directory name should automatically fill out, or you could change it to anything else you want.
7. Click on Browse… navigate to where you want the project to be created on your computer.
8. Click Open.
9. Click Create Project which will cause the project files to be downloaded and RStudio should re-start with the new project data.
  * NB. Your working directory is now set to the location you selected in step 7 and should include all of the files in the course github directory.
10. Look at the bottom right panel in Rstudio to view the files in your new working directory.
  * Click on the "scripts" directory (NB This does not change your working directory)
  * As an example, open the "Lesson1_step3_R_introduction.R" script by clicking on it.
  * Follow instructions on the script to get familiarized with R.
    * To move through the script one line at a time, you can use "CTRL + ENTER" or "CMD + ENTER" in the 
 
# Updating a local R project with Git
To ensure you have the most up-to-date code,
1. Open RStudio.
2. Select File → Open Project…
3. Find your R project from Lesson 1 → Click Open.
4. Click on Tools → Version Control → Pull branches
  * As long as you saved any changes you made with new file names, this will update everything else in the repository to catch up with the "master" branch.
5. Follow the instructions in the script, "Lesson1_step4_R_file_exploration.R"
 
 
    
# Troubleshooting Git on RStudio
Are you getting this error?

  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_error.PNG" width="500" height="400" />

Follow these steps to try and fix it:
1. Make sure you have Git installed on your computer. 
* Find the right version for your computer [here](https://git-scm.com/downloads)
* If you can find git on your computer and it seems to open up, move on to step 2.
2. Next, you have to change the settings on RStudio to find git. Click on "Tools" --> "Global Options"

  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_step1.PNG" width="1000" height="400" />

3. Click on the "Git/SVN" panel to pull up the following options:

  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_Rstudio_github_step2.PNG" width="500" height="400" />

4. Make sure the box is checked on to "Enable version control interface for RStudio projects"

5. Click on the button, "Browse...", find the Git executable on your computer using the finder and click "Open"
* On macOS and Linux, the path is usually something like this:
```
/usr/bin/git
```

* For Windows, you can often find it here:
```
C:/Program Files/Git/bin/git.exe
```

6. If it looks like the image below, go ahead and press "OK":
* On linux (similar to macOS)

  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_installed_linux_git.png" width="500" height="400" />

* On Windows

  <img src="https://raw.githubusercontent.com/EnriqueDoster/MEG_intro_stats_course/master/misc_resources/example_pictures/example_installed_windows_git.png" width="500" height="400" />

7. Re-start RStudio and try setting up the R project again.
