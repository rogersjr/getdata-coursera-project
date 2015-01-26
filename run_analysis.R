install.packages("dplyr")
library(dplyr)

#############################
# base directory and files
#############################

base_dir = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"

activityLabels = read.table(paste(base_dir, "activity_labels.txt", sep=""), header = FALSE)
activityLabels = rename(activityLabels, activity_id = V1, activity_label = V2)

featuresLabels = read.table(paste(base_dir, "features.txt", sep=""), header = FALSE)
featuresLabels = rename(featuresLabels, feature_id = V1, feature_label = V2)
feature_label = as.character(featuresLabels$feature_label)

#############################
# test directory and files
#############################

test_dir = paste(base_dir, "test/", sep="")
test_subject_id = "subject_test.txt"
test_set = "X_test.txt"
test_labels = "y_test.txt"

testSubjectIds = read.table(paste(test_dir, test_subject_id, sep=""), header = FALSE)
testSubjectIds = rename(testSubjectIds, subject_id = V1)
subject_id = testSubjectIds$subject_id

testLabels = read.table(paste(test_dir, test_labels, sep=""), header = FALSE)
testLabels = rename(testLabels, activity_id = V1)
activity_id = testLabels$activity_id

testSet = read.table(paste(test_dir, test_set, sep=""), header = FALSE)
names(testSet) = c(feature_label)

testSet = cbind(subject_id, activity_id, testSet)
testSet = merge(activityLabels, testSet, by.x = "activity_id", by.y = "activity_id")

#############################
# train directory and files
#############################

train_dir = paste(base_dir,  "train/", sep="")
train_subject_id = "subject_train.txt"
train_set = "X_train.txt"
train_labels = "y_train.txt"

trainSubjectIds = read.table(paste(train_dir, train_subject_id, sep=""), header = FALSE)
trainSubjectIds = rename(trainSubjectIds, subject_id = V1)
subject_id = trainSubjectIds$subject_id

trainLabels = read.table(paste(train_dir, train_labels, sep=""), header = FALSE)
trainLabels = rename(trainLabels, activity_id = V1)
activity_id = trainLabels$activity_id

trainSet = read.table(paste(train_dir, train_set, sep=""), header = FALSE)
names(trainSet) = c(feature_label)

trainSet = cbind(subject_id, activity_id, trainSet)
trainSet = merge(activityLabels, trainSet, by.x = "activity_id", by.y = "activity_id")


#############################
# make a union of the 2 sets
#############################

fullSet = rbind(testSet, trainSet)

#############################
# keep mean & std variables
#############################


activity_id = fullSet$activity_id
activity_label = fullSet$activity_label
subject_id = fullSet$subject_id

meanStdSet = fullSet[, grep(c("mean|std"), colnames(fullSet))]
meanStdSet = cbind(activity_id, activity_label, subject_id, meanStdSet)


##################################
# aggregate by activity &  subject
##################################

aggregateSet = aggregate(meanStdSet[,4:82],by=list(meanStdSet$activity_id, meanStdSet$subject_id), mean)
aggregateSet = rename(aggregateSet, activity_id = Group.1, subject_id=Group.2)
aggregateSet = merge(activityLabels, aggregateSet, by.x = "activity_id", by.y = "activity_id")

#############################
# remove temporary dataframes
#############################

rm(activityLabels, featuresLabels, testSubjectIds, testLabels, testSet, trainSubjectIds, trainLabels, trainSet, fullSet)
