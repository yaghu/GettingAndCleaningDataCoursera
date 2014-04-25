#Code book

The data contains the result of the experiment carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone. Dataset was randomly partitioned into to sets: training and test.

Following steps were performed in order to clean the data:

1. Read `features.txt` into `features`
1. Read `activity_labels.txt` into `activity_labels`
1. Merge the training and test sets to create the complete data set `data`
1. Rename `data` columns using `featues`
1. Extract only the measurements on the mean and standard deviation for each measurement, i.e. column names containing either `mean()` or `std` string.
1. Read activities associated with each measurement and replace activity ids with names using `activity_labels`.
1. Read subjects associated with each measurement.
1. Add subjects and activities into the data set.
1. Using `melt` and `dcast` from the `reshape2` package compute the average of each variable for each activity and each subject and write the resulting table into the `tidydata.txt` file.
