library(reshape2)

## read features
features <- read.table("UCI HAR Dataset/features.txt", 
                            header=FALSE, 
                            colClasses=c("integer", "character"))

## read activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                              header=FALSE, 
                              colClasses=c("integer", "character"))
activity_labels[,2] <- factor(activity_labels[,2], levels=activity_labels[,2])

## read data table (training)
data_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                   header=FALSE, 
                   colClasses=c("numeric"))
## read data table (test)
data_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                        header=FALSE, 
                        colClasses=c("numeric"))
## merge data
data <- rbind(data_train, data_test)
rm(data_train)
rm(data_test)
## rename columns
colnames(data) <- features[,2]

## Extract only the measurements on the mean and standard deviation for 
## each measurement
data <- data[,grepl("mean\\(\\)|std\\(\\)", features[,2])]

activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                            header=FALSE, 
                            colClasses=c("integer"),
                            col.names=c("activity"))
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                      header=FALSE, 
                      colClasses=c("integer"),
                      col.names=c("activity"))
activity <- rbind(activity_train, activity_test)

## Label the data set with descriptive activity names
activity[,1] <- activity_labels[,2][activity[,1]]

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                       header=FALSE, 
                      colClasses=c("integer"), 
                      col.names=c("subject"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                      header=FALSE, 
                      colClasses=c("integer"), 
                      col.names=c("subject"))
subject <- rbind(subject_train, subject_test)

# add subject and activity to the data set
data <- cbind(subject, activity, data)

## Create a second, independent tidy data set with the average of each 
## variable for each activity and each subject
molten <- melt(data, id.vars=c("subject", "activity"))
tidydata <- dcast(molten, subject + activity ~ variable, fun.aggregate=mean)

## write tidydata to a file
write.table(tidydata, "tidydata.txt")