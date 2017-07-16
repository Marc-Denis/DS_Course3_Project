##Coursera.org - Johns-Hopkins University
##Getting and Cleaning Data - Week 4
##Course Project CodeBook.md file - Submitted by Marc Denis

###Introduction
This file will describe the different variables used in the datasets that have been processed during the assignment.
Most contents originate from the features_info.txt file, that acted as the codebook of the original dataset.
Source: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

###Variables description - Original datasets (used during step 1, 2, and 3)
Please refer to the readme.txt and features_info.txt files, both of which were provided in the .zip file containing the dataset.


###Variables description - Dataset obtained at the end of step 4
The dataset obtained at the end of step 4, full_set, contains 81 variables and 10,299 observations.
The 10,299 observations are comprised of the 2,947 observations of the test dataset, plus the 7,352 observations of the train dataset.

* **subject**: *numeric* ranges from 1 to 30. Depicts the identifier of one of the thirty subjects (aged 19-48) on which activity data has been collected.

* **activityname**: *factor* may take 6 distinct values, to represent the activity performed by the observed subject: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

* **subsequent variables**: *numeric* all of the 79 subsequent variables are numeric variables and represent either the mean, the standard deviation, or the mean frequency of observed gravitational variables. Each variable is name following this pattern: *ObservedStatistic*-*AppliedFunction*-*Axis*.

        + The ObservedStatistic may take one of the following values:
        tBodyAcc
        tGravityAcc
        tBodyAccJerk
        tBodyGyro
        tBodyGyroJerk
        tBodyAccMag
        tGravityAccMag
        tBodyAccJerkMag
        tBodyGyroMag
        tBodyGyroJerkMag
        fBodyAcc
        fBodyAccJerk
        fBodyGyro
        fBodyAccMag
        fBodyBodyAccJerkMag
        fBodyBodyGyroMag
        fBodyBodyGyroJerkMag

        Explanations for these variables are directly quoted from the original features_info.txt mentioned at the top of this code book. Please find them quoted below:

        **==Quotation begin==**
        
        The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

        Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
        
        Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
        
        These signals were used to estimate variables of the feature vector for each pattern:  
        '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
        
        **==Quotation end==**



        + The AppliedFunction may take one of the following values:
        mean(): Mean value
        std(): Standard deviation
        meanFreq(): Weighted average of the frequency components to obtain a mean frequency *only if the ObservedStatistic variable name begins with a f*

        + The Axis may take either the value X, Y or Z, or may be ommitted if not applicable (*when the ObservedStatistic variable name ends with Mag*)



###Variables description - Dataset obtained at the end of step 5

The dataset obtained at the end of step 5, new_set_avg, contains 81 variables and 180 observations.
These 180 observations come from the grouping of the former dataset by activity (6 activities) and subject (30 subjects). As all of the thirty subjects have taken part to all six activities, there are 6*30=180 observations.

Variables have kept the same name and type as in the former dataset. However, the following changes have occurred:

* **activityname** is now the first variable of the dataset
* **subject** is now the second variable of the dataset
* All of the subsequent variables correspond to the calculation of the average value, by activity and by subject, of the statistics present in the former dataset