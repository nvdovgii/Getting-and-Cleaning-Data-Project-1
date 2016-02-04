# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Download the data source ```getdata_dataset.zip```. 
2. Put it into a folder on your local drive. 
3. Put ```run_analysis.R``` in the workdir with ```getdata_dataset.zip```
4. Set workdir using ```setwd()``` in RStudio.
5. Run ```source("run_analysis.R")```
6. A new file ```tiny.txt``` will be created in workdir.

## Dependencies

 ```reshape2``` used in this script 