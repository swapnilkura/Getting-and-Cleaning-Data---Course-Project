library(reshape2)

## set working directory
dir <- "c:/Swapnil/Docs/Data Science/Data-Cleaning course/Code/"
setwd(dir)

## set url and download dataset
zipfileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "./UCI_HAR_Dataset.zip"
download.file(zipfileURL, zipfile)
if (!file.exists("UCI HAR Dataset")) { 
     unzip(zipfile) 
}

## load metadata (activities and features) of dataset
activitytypes <- read.csv(file = "./UCI HAR Dataset/activity_labels.txt", header = F, sep = " ")
features <- read.csv(file = "./UCI HAR Dataset/features.txt", header = F, sep = " ")
activitytypes[,2] <- as.character(activitytypes[,2])
features[,2] <- as.character(features[,2])

## extract fields related to mean and standard deviation
reqfeatures <- grep(".*mean.*|.*std.*",features[,2])
reqfeaturesnames <- features[reqfeatures,2]
reqfeaturesnames <- tolower(gsub("[-()]", "", reqfeaturesnames))

##Load datasets with only required fields
trainfdata <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
trainfdata <- trainfdata[,reqfeatures]
trainactivities <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
trainsubjects <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
traindata <- cbind(trainsubjects, trainactivities, trainfdata)

testfdata <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
testfdata <- testfdata[,reqfeatures]
testactivities <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
testsubjects <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")
testdata <- cbind(testsubjects, testactivities, testfdata)

## combine datasets 
data <- rbind(traindata, testdata)
reqfeaturesnames <- c("subjectid", "activity", reqfeaturesnames)
colnames(data) <- reqfeaturesnames

## calculate the mean for each variable
melteddata <- melt(data, id.vars = c("subjectid", "activity"))
meanstats <- dcast(melteddata, subjectid + activity ~ variable, mean)

## dump data into file
write.table(meanstats, file = "./tidy.txt", quote = F, sep = "|", row.names = F)