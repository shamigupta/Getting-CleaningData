
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#The R script run_analysis.R does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##0 Pre-processing 

- Create sub directory in current working directory if it doesn't exist
- Download File if not dowloaded already
- Unzip and store the data files

##1 Merges the training and the test sets to create one data set.

- Read Activity Files into Data Frame
- Read Subject Files into Data Frame
- Read Features Files into Data Frame
- Now test the Files for
    - No of observations are same for all Activity, Subject and Features files
    - No of variables are same for all Train and Test Files
- Merge the Train and Test Files for Activity, Subject and Features files (append rows)
- Add variable names in respective files
    - Read features.txt for variable names in features file
- Merge Activity, Subject and Features files into Data (append columns)

##2 Extracts only the measurements on the mean and standard deviation for each measurement. 

- Find variables named as *mean() or *std()
- Subset Data for subject activity mean and std variables only 

##3 Uses descriptive activity names to name the activities in the data set

- Read descriptive activity names from activity_labels.txt
- Factorize activity variable with descriptive activity names

##4 Appropriately labels the data set with descriptive variable names.

- Label the data set with descriptive variable namesn using different string substitutes
    - Expand abbreviated strings
    - Capitalization of wrords
    - Words separated by hyphens "-"
    - Remove function paranthesis "()"

##5 Creates a independent tidy data set with the average of each variable for each activity and each subject

- Create tidy dataset with the average of each variable for each activity and each subject
- Output tidy dataset into tidydata.txt in the working folder
- Verify tidy data criteria in Output file
