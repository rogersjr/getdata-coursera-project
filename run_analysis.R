
transfromTD <- function(features) {
    
    features <- gsub("BodyBody", "Body", features, fixed=TRUE)
    features <- gsub("-mean()-", "Mean", features, fixed=TRUE)
    features <- gsub("-mean()", "Mean", features, fixed=TRUE)
    features <- gsub("-std()-", "StdDev", features, fixed=TRUE)
    features <- gsub("-std()", "StdDev", features, fixed=TRUE)
    features <- gsub("tBody", "timebody", features, fixed=TRUE)
    features <- gsub("fBody", "frequencybody", features, fixed=TRUE)
    features <- gsub("tGravity", "timegravity", features, fixed=TRUE)
    features <- gsub("Gyro", "Gyroscope", features, fixed=TRUE)
    features <- gsub("Acc", "Acceleration", features, fixed=TRUE)
    features <- gsub("Mag", "Magnitude", features, fixed=TRUE)
    
    time_indices <- grep("time", features)
    features[time_indices] <- paste(gsub("time", "", features[time_indices], fixed=TRUE), "Time", sep="")
    frequency_indices <- grep("frequency", features)
    features[frequency_indices] <- paste(gsub("frequency", "", features[frequency_indices], fixed=TRUE), "Frequency", sep="")
    
    features <- gsub("MeanTime", "TimeMean", features, fixed=TRUE)
    features <- gsub("MeanXTime", "XTimeMean", features, fixed=TRUE)
    features <- gsub("MeanYTime", "YTimeMean", features, fixed=TRUE)
    features <- gsub("MeanZTime", "ZTimeMean", features, fixed=TRUE)
    
    features <- gsub("StdDevTime", "TimeStdDev", features, fixed=TRUE)
    features <- gsub("StdDevXTime", "XTimeStdDev", features, fixed=TRUE)
    features <- gsub("StdDevYTime", "YTimeStdDev", features, fixed=TRUE)
    features <- gsub("StdDevZTime", "ZTimeStdDev", features, fixed=TRUE)
    
    features <- gsub("MeanFrequency", "FrequencyMean", features, fixed=TRUE)
    features <- gsub("MeanXFrequency", "XFrequencyMean", features, fixed=TRUE)
    features <- gsub("MeanYFrequency", "YFrequencyMean", features, fixed=TRUE)
    features <- gsub("MeanZFrequency", "ZFrequencyMean", features, fixed=TRUE)
    
    features <- gsub("StdDevFrequency", "FrequencyStdDev", features, fixed=TRUE)
    features <- gsub("StdDevXFrequency", "XFrequencyStdDev", features, fixed=TRUE)
    features <- gsub("StdDevYFrequency", "YFrequencyStdDev", features, fixed=TRUE)
    features <- gsub("StdDevZFrequency", "ZFrequencyStdDev", features, fixed=TRUE)
    
    features
}

run_analysis <- function() {
    # Initialize constants used for file access.
    base_dir <- "./UCI HAR Dataset/"
    test_dir <- "test/"
    train_dir <- "train/"
    test_path <- paste(base_dir, test_dir, sep="")
    train_path <- paste(base_dir, train_dir, sep="")
    
    # Read the raw data files.
    activity_labels <- read.table(paste(base_dir, "activity_labels.txt", sep=""), stringsAsFactors=FALSE)
    features <- read.table(paste(base_dir, "features.txt", sep=""), stringsAsFactors=FALSE)
    
    X_train <- read.table(paste(train_path, "X_train.txt", sep=""), stringsAsFactors=FALSE)
    Y_train <- read.table(paste(train_path, "Y_train.txt", sep=""), stringsAsFactors=FALSE)
    subject_train <- read.table(paste(train_path, "subject_train.txt", sep=""), stringsAsFactors=FALSE)
    
    X_test <- read.table(paste(test_path, "X_test.txt", sep=""), stringsAsFactors=FALSE)
    Y_test <- read.table(paste(test_path, "Y_test.txt", sep=""), stringsAsFactors=FALSE)
    subject_test <- read.table(paste(test_path, "subject_test.txt", sep=""), stringsAsFactors=FALSE)
    
    # Merge the train and test set data by rows.
    X <- rbind(X_train, X_test)
    Y <- rbind(Y_train, Y_test)
    subjects <- rbind(subject_train, subject_test)
        
    #Set the column names.
    names(X) <- features$V2
    names(Y) <- 'activity'
    names(subjects) <- 'subject'
    
    # Merge the subjects, activity, and data columns.
    merged <- cbind(subjects, Y, X)
    
    # Extract the measurements on the mean and standard deviation for each measurement.
    filtered <- merged[, !grepl('meanFreq', colnames(merged))]
    filtered <- filtered[, grepl('subject|activity|mean|std', colnames(filtered))]
    
    # Assign more descriptive column names.
    colnames(filtered) <- transformTD(colnames(filtered))
    
    # Create the tidy data set containing the mean of each measurement grouped by subject and activity.
    tidyset <- aggregate(.~subject+activity, data=filtered, FUN=mean)
    
    # Add descriptive activity names.
    tidyset$activity <- activity_labels$V2[tidyset$activity]
    
    # Output the tidy data set to a text file.
    tidyset <- tidyset[order(tidyset$subject, tidyset$activity), ]
    write.table(tidyset, file="./tidyset.txt", sep="\t", row.name=FALSE)
}
