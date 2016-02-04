## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## moving to workdir
## setwd("D:/dataset/_coursera/coursera_3/week_4/project") 

library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Loading activity labels and features
actLab <- read.table("UCI HAR Dataset/activity_labels.txt")
actLab[,2] <- as.character(actLab[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracting only  mean and standard deviation
featuresSearched <- grep(".*mean.*|.*std.*", features[,2])
featuresSearched.names <- features[featuresSearched,2]
featuresSearched.names = gsub('-mean', 'Mean', featuresSearched.names)
featuresSearched.names = gsub('-std', 'Std', featuresSearched.names)
featuresSearched.names <- gsub('[-()]', '', featuresSearched.names)


# Loading the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresSearched]
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubj <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubj, trainAct, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresSearched]
testAct <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubj <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubj, testAct, test)

# merging datasets 
holdData <- rbind(train, test)
colnames(holdData) <- c("subject", "activity", featuresSearched.names)

# turning activities & subjects into factors
holdData$activity <- factor(holdData$activity, levels = actLab[,1], labels = actLab[,2])
holdData$subject <- as.factor(holdData$subject)

holdData.melted  <- melt(holdData, id = c("subject", "activity"))
holdData.mean <- dcast(holdData.melted, subject + activity ~ variable, mean)

write.table(holdData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)