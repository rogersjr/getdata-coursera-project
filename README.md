# getdata-coursera-project
Coursera's Getting and Cleaning Data Course Peer Review Project

#### Please make sure to set the working directory correctly before running the script
#### The script expects the zip file unzipped to "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"

CodeBook.md Describes the variables in the output file.

run_analysis.R R source code to perform the data cleaning and generate the output file.
Assumptions:

The raw data is assumed to be available in the "UCI HAR Dataset" subdirectory of the working directory.
Algorithm:

The following steps occur when processing the code:
1. The raw data files are read into local variables.
2. The raw data is merged into a single variable.
3. The merged data is filtered to include only mean and standard deviation measurements.
4. Descriptive columns names are assigned to the filtered data via the transmogrify() local function.
5. The tidy data set is created by taking the mean of each of the measurements in the filtered data.
6. The activity factor variable within the tidy data set is converted to its character value.
7. The tidy data set is written to the output file tidyset.txt.
