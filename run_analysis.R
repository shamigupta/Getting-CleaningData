# Create sub directory in current working directory if it doesn't exist
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download File if not dowloaded already
if(!file.exists("./data/UCI_Dataset.zip")){ download.file(fileUrl,destfile="./data/UCI_Dataset.zip") }

# Unzip and store the data files
unzip(zipfile="./data/UCI_Dataset.zip",exdir="./data")
path_rf <- file.path("./data" , "UCI HAR Dataset")

# Read Activity Files into Data Frame
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

# Read Subject Files into Data Frame
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

# Read Features Files into Data Frame
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

# Now test the Files for
# No of observations are same for all Activity, Subject and Features files
# No of variables are same for all Train and Test Files


# Merge the Train and Test Files for Activity, Subject and Features files (append rows)
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

# Add variable names in respective files
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")

# Read features.txt for variable names in features file
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# Merge Activity, Subject and Features files into Data (append columns)
Data <- cbind(dataFeatures, dataSubject, dataActivity)

# Find variables named as *mean() or *std()
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Subset Data for subject activity mean and std variables only 
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

# Read descriptive activity names from activity_labels.txt
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

# Factorize activity variable with descriptive activity names
Data$activity = factor(Data$activity)
levels(Data$activity) <- activityLabels$V2

# Label the data set with descriptive variable names
names(Data)<-gsub("^t", "Time-", names(Data))
names(Data)<-gsub("^f", "Frequency-", names(Data))
names(Data)<-gsub("Acc", "Accelerometer-", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope-", names(Data))
names(Data)<-gsub("Mag", "Magnitude-", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Body", "Body-", names(Data))
names(Data)<-gsub("Jerk", "Jerk-", names(Data))
names(Data)<-gsub("Gravity", "Gravity-", names(Data))
names(Data)<-gsub("mean", "Mean", names(Data))
names(Data)<-gsub("std", "Std", names(Data))
names(Data)<-gsub("--", "-", names(Data))
names(Data)<-gsub("\\(\\)", "", names(Data))

# Create tidy dataset with the average of each variable for each activity and each subject
library(dplyr)
TidyData <- Data  %>% group_by(activity, subject) %>% summarise_each(funs(mean))

# Output tidy dataset into tidydata.txt in the working folder
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)




