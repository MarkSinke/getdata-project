Code Book for the "Getting and Cleaning Data" Coursera course project
=====================================================================

As indicated in the [README.md] file, the data for the data set resulting from
the processing in the [run_analysis.R] file stems from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, published in conjuction  with [1].

The result of the analysis script consists of a summary data set.

Transformation into tidy format of the intermediate (totals) result set
=======================================================================

The data in that data set is split in a test and training set, which for the purposes of this analysis, are combined, after processing the common steps.

The function readSet() captures the common processing required.

In addition, the original data set had the activity labels, subject identification, and variable names in separate files. These are joined into the data set. The set is still tidy since those files are merely value - name mappings (i.e., a 1-to-1 mapping), and that means that no correlated columns are introduced (which would violate the principle to separate out these columns into a separate table file).

From the original data set, I chose to keep all data sets with "mean" or "std" in the variable name, as the assignment left room for interpretation of which of the variables should be considered "measurements".

For the summary data set, for each of the variables in the result set, the mean is calculated. To avoid a large number of explicit "mean.XYZ = mean(xyz)"-type mutate arguments, instead I used the tidyr package to transform the data set into a molten data set, where the value for each variable and the variable name are two columns.

I then group by subject, activity, and variable, in order to subsequently compute the mean.

After computation the data set is spread again to put the variable names back into the column names.

For the summary data set, I left the column names as they were. I gauged that adding "avg" or "mean" to every column name would not help readability.

This data set is written to "data/tidy-means.txt".

The variables in the tidy-means data set are

subject:    the identifier of the subject who was measured
activity:   the activity the sbuject performed

(The following text is mostly from the initial data set, with some terminology adapted:)

The variables in the data set come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

This data set contains the mean of variables that are estimated from these signals (yes,
the data contains averaged means and standard deviations):

mean(): Mean value (yes, the column contains the mean of the mean values)
std(): Standard deviation (yes, the column contains the mean of the standard deviations)

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean



Citations
=========

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
