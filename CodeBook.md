# CodeBook for the accelerometer dataset

# Study design

A complete description of the study is found in the README.txt file.  Briefly, 30 volunteers were monitored by accelerometer and gyroscope during the course of 6 physical activities.  Activites were recorded by video.  Readouts from the accelerometer and gyroscope were integrated, filtered, aggregated, and normalized, leading to 561 final features measured for 10,299 cases, which were divided into 7352 training cases and 2947 test cases. The units of all raw features were accelerations or angular velocities on arbitrary sensor output scales.

# Code book

Starting from the raw dataset, the following steps were done to create the final tidy dataset, using the R code in `run_analysis.R`:

1. The training and test sets were merged.
2. From the 561 raw features, the subset that were means and standard deviations were extracted.  This was done by selecting all features that matched the strings `std()` or `mean()`.  This resulted in 66 final features.
3. For those 66 features, averages were computed by (subject, activity), leading to 180 final records each containing 66 features.  (180 = 30 subjects x 6 activities)
4.  The final data frame was written to `tidy_final_ahv01.txt`

The variables in the final dataset are:

Variable Name | Description
------------- | -----------
SUBJECT | The subject ID (1..30)
ACTIVITY | The subjects physical activity state
tBodyAcc | Mean body acceleration
tGravityAcc | Mean gravity acceleration
tBodyAccJerk | Mean body acceleration jerk (time derivative)
tBodyGyro | Mean body angular velocity
tBodyGyroJerk | Mean body angular velocity jerk
tBodyAccMag | Mean body acceleration magnitude
tGravityAccMag | Mean gravity acceleration magnitude
tBodyAccJerkMag | Mean body acceleration jerk magnitude 
tBodyGyroMag | Mean body angular velocity magnitude
tBodyGyroJerkMag |  Mean body angular velocity jerk magnitude 
fBodyAcc | Mean Frequency domain body acceleration
fBodyAccJerk | Mean Frequency domain body acceleration jerk
fBodyGyro | Mean Frequency domain body angular velocity
fBodyAccMag | Mean Frequency domain body acceleration magnitude
fBodyBodyAccJerkMag | Mean Frequency domain body acceleration jerk magnitude
fBodyBodyGyroMag | Mean Frequency domain body angular velocity magnitude
fBodyBodyGyroJerkMag | Mean Frequency domain body angular velocity jerk magnitude

Note: for each of the variables listed above, in the dataframe you will see suffixes indicating the aggregation (mean or standard deviation) and axis (X, Y, or Z) corresponding to each feature.

For example, 

* tBodyAcc-mean()-Y indicates the mean tBodyAcc, in the Y-axis
* fBodyAccMag-std() indicates the standard deviation of the Mean Body acceleration magnitude

