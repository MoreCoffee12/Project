# Set the working directory
setwd("C:/Users/Brian/OneDrive/DataScience/GettingAndCleaningData/Project")

## You should create one R script called run_analysis.R that does the following. 

## ----------------------------------------------------------------
## 1. Merges the training and the test sets to create one data set.
## ----------------------------------------------------------------

# Begin with the dataset descriptor files
strFeatures <- "./UCI HAR Dataset/features.txt"
Features <- read.csv(strFeatures, header = FALSE, sep ="", stringsAsFactors = FALSE)

# Read in the activity labels
strActLabels <- "./UCI HAR Dataset/activity_labels.txt"
ActLabels <- read.csv(strActLabels, header = FALSE, sep ="", stringsAsFactors = FALSE)
names(ActLabels) <- c("ActivityLabel", "ActivityText")

# Read in the the test subject files
strSubjectTestPath <- "./UCI HAR Dataset/test/subject_test.txt"
SubjectTest <- read.csv(strSubjectTestPath, header = FALSE, sep="")

# Load the test data set
strXTestPath <- "./UCI HAR Dataset/test/X_test.txt"
XTest <- read.csv(strXTestPath, header = FALSE, sep="")

# Add the names from the features.txt file
names(XTest) <- Features[,2]

# Read in the test labels
strYTestPath <- "./UCI HAR Dataset/test/y_test.txt"
YTest <- read.csv(strYTestPath, header = FALSE, sep="")

# Append the test labels and subject 
XTest$ActivityLabel <- YTest[,1]
XTest$Subject <- SubjectTest[,1]

# Read in the training subject data
strSubjectTrainPath <- "./UCI HAR Dataset/train/subject_train.txt"
SubjectTrain <- read.csv(strSubjectTrainPath, header = FALSE, sep="")

# Load the training data set
strXTrainPath = "./UCI HAR Dataset/train/X_train.txt"
XTrain = read.csv(strXTrainPath, header = FALSE, sep="")

# Add the names from the features.txt file
names(XTrain) <- Features[,2]

# Read in the training labels
strYTrainPath <- "./UCI HAR Dataset/train/y_train.txt"
YTrain <- read.csv(strYTrainPath, header = FALSE, sep="")

# Append the test labels and subject 
XTrain$ActivityLabel <- YTrain[,1]
XTrain$Subject <- SubjectTrain[,1]

# Finally, bind the two data sets
TotalData <- rbind(XTest, XTrain)

## ----------------------------------------------------------------
## 2. Extracts only the measurements on the mean and standard 
## deviation for each measurement. 
## ----------------------------------------------------------------
# This is somewhat inefficient, but it makes it easy to see what
# data was selected.
MeanData <- TotalData[,(grep("mean()",names(TotalData)))]
STDData <- TotalData[,(grep("std()",names(TotalData)))]
Data <- cbind(MeanData, STDData, 
              TotalData$ActivityLabel, TotalData$Subject)

## ----------------------------------------------------------------
## 3. Uses descriptive activity names to name the activities in the 
## data set
## ----------------------------------------------------------------
mergedData <- merge(Data,ActLabels, 
                    by.x = "TotalData$ActivityLabel", by.y="ActivityLabel", 
                    all=TRUE)

## ----------------------------------------------------------------
## 4. Appropriately labels the data set with descriptive variable 
## names. 
## ----------------------------------------------------------------
library(dplyr)
mergedData <- dplyr::rename(mergedData, ActivityID = `TotalData$ActivityLabel`)


## ----------------------------------------------------------------
## 5. From the data set in step 4, creates a second, independent 
## tidy data set with the average of each variable for each 
## activity and each subject.
## ----------------------------------------------------------------
