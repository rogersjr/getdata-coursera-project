# getdata-coursera-project
Coursera's Getting and Cleaning Data Course Peer Review Project

- First I install the dplyr package and load it
- I set up the base sirectory based onthe unzipped file
- I then load the features and activities which will be used to populate the data sets
- I use read.table to read the data from file 
- Then rename to have tidy column names

- We then move to the test directory
- Here I load the test data set, and give the variable names from the features loaded earlier
- This is possible since the features is ordered accoring to the columns in the data sets
- Eg: V1 is 1 tBodyAcc-mean()-X and V2 is 2 tBodyAcc-mean()-Y, etc...
- Then i load the subject ids and feature/activity ids
- I use the rename to havbe tidy column names
- I bind the columns of the data set with that of the activity and subject
- Then I use the merge on the activity ids to add the activity labels as was requested

- We then move to the train directory
- here, the same steps as those for the test directory are carried out

- Once complete, we can now safely vertically merge the data together by adding thr rows up using rbind

- I then get rid of all columns but those of the ids and those with mean or std in their names

- Finally, I use the aggregate and by command to aggregate the data according to the activity and subject ids for all columns

- I ran one last step to get rid of temporary data frames to save memory on your machine :)
