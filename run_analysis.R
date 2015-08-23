# Set the working directory
setwd("C:/Users/Brian/OneDrive/DataScience/GettingAndCleaningData/Project")

## You should create one R script called run_analysis.R that does the following. 

## 1. Merges the training and the test sets to create one data set.
strSubjectTestPath = "./UCI HAR Dataset/test/subject_test.txt"
SubjectTest = read.csv(strSubjectTestPath)

strXTestPath = "./UCI HAR Dataset/test/X_test.txt"
XTest = read.csv(strXTestPath, header = FALSE, sep="")

strYTestPath = "./UCI HAR Dataset/test/y_test.txt"
YTest = read.csv(strYTestPath, header = FALSE, sep=" ")

strSubjectTrainPath = "./UCI HAR Dataset/train/subject_train.txt"
SubjectTrain = read.csv(strSubjectTrainPath)


## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement. 


## 3. Uses descriptive activity names to name the activities in the data set

## 4. Appropriately labels the data set with descriptive variable names. 

## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.