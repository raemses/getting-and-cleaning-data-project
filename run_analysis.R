setwd("/Users/ramiz/")
rm(list=ls())
# Download the file
if(!file.exists("./data/UCI HAR Dataset")){
  dir.create("./data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")
}

# unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# set working dir
setwd("./data/UCI HAR Dataset")

# read data from files
features <- read.table("./features.txt")
activity <- read.table("./activity_labels.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# 1. Merges the training and the test sets to create one data set.

x_merge <- rbind(x_train, x_test)
y_merge <- rbind(y_train, y_test)
subject_merge <- rbind(subject_train, subject_test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

mean_std <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x_merge <- x_merge[, mean_std]

# 3. Uses descriptive activity names to name the activities in the data set

y_merge[, 1] <- activity[y_merge[, 1], 2]

# 4.Appropriately labels the data set with descriptive variable names.

names(x_merge) = features[mean_std, 2]
names(y_merge)        = "activity";
names(subject_merge)  = "subject";

# merge the columns of data

All_data <- cbind(subject_merge,y_merge, x_merge)

# count the number of subjects and activities

subject = unique(subject_merge)[,1]
subject_No = length(unique(subject_merge)[,1])
activity_No = length(activity[,1])
column_No = dim(All_data)[2]
final_data = All_data[1:(subject_No*activity_No), ]

# find the average values for the variables for each activity and each subject

i = 1
for (s in 1:subject_No) {
  for (a in 1:activity_No) {
    final_data[i, 1] = subject[s]
    final_data[i, 2] = activity[a, 2]
    result <- All_data[All_data$subject==s & All_data$activity==activity[a, 2], ]
    final_data[i, 3:column_No] <- colMeans(result[, 3:column_No])
    i = i+1
  }
}

# 5. From the data set in step 4, creates a second, independent tidy data set with the 

write.table(final_data, "tidydata.txt", row.name=FALSE)
