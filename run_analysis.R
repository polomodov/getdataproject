# You should set wd to current file
# setwd(...)
# You should get library reshape2

# Download data for analysis
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = temp, method = "wget",
              quiet = FALSE, mode = "w",cacheOK = TRUE,
              extra = getOption("download.file.extra"))
# unzip file
unzip(temp,exdir = getwd())
# remove temp file
unlink(temp)

# Read X training and test data
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
#
xData <- rbind(xTest, xTrain)


# Read Y training and test data
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
yData <- rbind(yTest, yTrain)

# Read subject train and test data

sTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
sTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
sData <- rbind(sTrain, sTest)

# Read activities data and label Y_data  file

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
yData [,1] = activities[yData[,1], 2]
names(yData) <- "activity"

# Read features.txt file. 
# Get only mean and standard deviation for each measurement. 
# Label the mean and std data set (xDataMS) dataset

features <- read.table("UCI HAR Dataset/features.txt")
mSFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
xDataMS <- xData[,mSFeatures]
names(xDataMS)<-tolower(gsub("\\(|\\)", "",  features[mSFeatures, 2]))

# Put labels for sData 
# merge datasets

names(sData) <- "subject"
tidyDatasetA <- cbind(sData, yData, xDataMS)
write.table(tidyDatasetA, "merged_tidy_data.txt")

# Creates a second, independent tidy data set 
# with the average of each variable 
# for each activity and each subject. 

require(reshape2)
mData <- melt(tidyDatasetA, id=c("subject","activity"))
tidyAvgData <- dcast(mData, formula = subject + activity ~ variable, mean)
write.table(tidyAvgData, "tidyAvgData.txt")