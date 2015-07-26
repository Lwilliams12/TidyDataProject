---
title: "README.md"
author: "Larry Williams"
date: "July 26, 2015"
output: html_document
---
# Turning 32 files into 1 tidy data set. 

How this R script (1 script) that carried out this data wrangling works.  
**run_analyis.R** includes the following Steps:  

***

* Read in raw data from **UCI Machine Learning Repository** ("data.zip"")
     + **Human Activity Recognition Using Smartphone Data Set**
     + See **CodeBook.md** for details
* Unzip the 32 files creating timestamp and save variables for paths to files.
* Explore the content of the files in the console (not in script)
* Merge the feature observations from the training set and test set
     + Use dply::bind_rows to add test set rows to bottom of training set
     + New data frame will have 561 columns and 10,299 observations
* Out of 561 variables select the ones with measurements on mean and std
* Create a new data frame (df) with the selected variables
* Create appropriate variable names for the columns
     + Start with original 561 feature names
     + Select the correct names that match selected columns
     + Transform these names into more appropriate tidy data names
     + Change the colnames of df into the new tidy data names
* Add 2 new variables at the front of the data frame.
     + **ID_Subject** will identify subject by number (1:30)
     + **Activity** will denote 6 activities subjects engaged in
          + Walking, Walking up, Walking down, Sitting, Standing,and Lying Down
     + Use dplyr::bind_cols to add these 2 variables to front of df
* Create final tidy data set by averaging each variable for each activity and subject
     + Use **aggregate** over activities and subjects with FUN=mean
     + Transform the two Group names into names that are more informative.
* Final Step:  write the tidy file as "tidydata2.txt" with no rownames.