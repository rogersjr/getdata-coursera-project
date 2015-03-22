
setwd("C:/Users/rogersjr/Desktop/coursera/R Programming/quiz31/Project3/UCI HAR Dataset")

# Read Activity Labels and Features

activity_labels <- read.table("./activity_labels.txt", stringsAsFactors=FALSE)
features <- read.table("./features.txt", stringsAsFactors=FALSE)


# Read test data
	X_test <- read.table("./test/X_test.txt",stringsAsFactors=FALSE)
	Y_test <- read.table("./test/X_test.txt",stringsAsFactors=FALSE)
	subject_test <- read.table("./test/subject_test.txt",stringsAsFactors=FALSE)
	

# Read training data
	X_train <- read.table("./train/X_train.txt",stringsAsFactors=FALSE)
	Y_train <- read.table("./train/X_train.txt",stringsAsFactors=FALSE)
	subject_train <- read.table("./train/subject_train.txt",stringsAsFactors=FALSE)
	

 # Merge the training, test data set by rows.
	X <- rbind(X_test, X_train)
	Y <- rbind(Y_test, Y_train)
	subjects <- rbind(subject_train,subject_test)	    
	
#Update column names.
    names(X) <- features$V2
    names(Y) <- 'activity'
    names(subjects) <- 'subject'

# Merge the subjects, activity, and data columns.
    merged <- cbind(subjects, Y, X)

# Filter the measurements on the mean and standard deviation for each measurement.
    filtered <- merged[, !grepl('meanFreq', colnames(merged))]
    filtered <- filtered[, grepl('subject|activity|mean|std', colnames(filtered))]

# Create tidy data set containing the means of each measurement by subject and activity
	tidyDataSet <- aggregate(.~subject+activity, data=filtered, FUN=mean)

# Add activity names.
    tidyDataSet$activity <- activity_labels$V2[tidyDataSet$activity]

# Output the tidy data set to a text file.
    tidyDataSet <- tidyDataSet[order(tidyDataSet$subject, tidyDataSet$activity), ]
    write.table(tidyDataSet, file="./tidyDataSet.txt", sep="\t", row.name=FALSE)



