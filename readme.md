##Coursera.org - Johns-Hopkins University
##Getting and Cleaning Data - Week 4
##Course Project ReadMe.md file - Submitted by Marc Denis

###Introduction
This file will describe the different procedures accomplished by the run_analysis.R script file in order to meet the requirements of the five questions of the Week 4 Course Project assignment.

*Assumptions*

It is assumed that the user will meet the following requirements:

* Have the dplyr package installed
* Have downloaded all the files from the dataset and copied them all in the working directory, with the exception of the files that were in the Intertial Signals subfolders as the data they contain is not used anywhere during the assignment.

*Contents*

The necessary files of this assignments are:

* readme.md: this very file, describing what has been done
* run_analysis.R: the R script file to be run against the provided dataset
* codebook.md: a code book that describes the variables of the dataset


###Part one

**Goal: Merge the training and the test sets to create one data set.**

To proceed with this objective, all the files from both test and train datasets have been loaded into R, i.e.:

* The subject_test/train.txt file containing the ID of the persons on which data has been collected
* The Y_test/train.txt file containing the ID of the activity performed by the persons who took part to this experiment
* The X_test/train.txt file containing the collected data per se

For both test and train datasets, all three files have been loaded into R and then merged into a single full dataset, as they actually contained the same number of observations and were related to the same experiment (either "test" or "train"). The cbind command has been used to bind into a single dataset the subject ID data, the activity ID data, and the numerical data collected from the subjects' phones.

Once both test and train datasets have been completed, both of them have been merged into a single, full dataset, with the rbind command. Merging both datasets that way made sense, since they had the same number of columns, that depicted the exact same piece of information, and contained observations on different test subjects (hence, no duplicate).

The complete dataset has then been converted into a format readable by the dplyr package, in order to be processed with some dplyr commands later.



###Part two

**Goal: Extract only the measurements on the mean and standard deviation for each measurement.**

In order to drop the columns that are not required for the analysis, it is necessary to identify them. The .zip file contained a features.txt file that contained all the column names of the X_test.txt and X_train.txt files.
This file has thus been loaded into R, and been processed through the grep command in order to isolate the column numbers whose labels corresponded to either a mean or a standard deviation measure (mean, MeanFreq and std functions). Search has been performed with a regular expression.
Column numbers obtained with grep have been loaded into a numeric vector called col_numbers.

Since the columns of the files X_test.txt and X_train.txt actually begin from the third position in the merged dataset, it is necessary to add +2 to each value of the col_numbers vector so that it can match the column numbers of the merged dataset. This alteration has been performed with the sapply command.

The select command from the dplyr package has then been used with the col_numbers vector to extract only the columns whose positions in the dataset were matching the ones in the col_numbers vector. However, as we wanted to keep the first two columns (containing the subject and activity IDs) as well, we first added the positions 1 and 2 to the col_numbers vector, before proceding with the extraction.



###Part three

**Goal: Use descriptive activity names to name the activities in the data set**

Right now, the activities are denoted by numbers from 1 to 6, and not by their full names. Those are available in a separate file called activity_labels.txt. This file has been loaded into R.

Both objects (the full dataset and the activity labels table) have then been joined, on the basis of their common column (i.e.: column #2, named "activity" for the full dataset, and column #1 for the activity labels table, named "activity" as well).

Columns in the resulting dataset have then been reordered to match the initial pattern:
* The first column should be the subject ID column
* The second column should be the activity column, now containing the activity names instead of the IDs
* All the remaining columns should contain the observed numerical data, as before



###Part four

**Goal: Appropriately label the data set with descriptive variable names**

Right now, only the first two columns of the dataset have a descriptive name. The others follow a Vn pattern, where n is a 1-to-3-digit number.

Appropriate labels are already available, and have been loaded earlier into R during the second part of the assignment. The only thing to do is to retrieve them again, with the grep command (and the value argument equal to TRUE, so that the labels themselves are returned), and update the columns' names by assigning the new values to the names(full_set) vector.
There is no need to rename the first two columns of the dataset, as seen earlier, so only the 3rd to 81st columns' names should be updated (hence the [3:81] subsetting).



###Part five

**Goal: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.**

In order to create a second dataset that contains the average of each variable, for each activity and each subject, it is necessary to group the data by activity and subject. To do so, the group_by function of the dplyr package has been used.

The summarise command has not been used here, as it would have required to manually input the mean formula for each of the 79 statistical values. Instead, the dataset has been processed through the summarise_all command, which allows to perform the mean calculation over all of the columns that have not been grouped earlier.

The resulting dataset, containing 180 rows (6 activities * 30 users), has then been saved into a new file, named "new_set_avg.txt". This file has been created in the working directory.
To read back the file properly into R, the following command should be used:
*new_set_avg<-read.table("new_set_avg.txt",sep=";",header=TRUE)*



###Sources

Original data provided by:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012