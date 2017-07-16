#Coursera.org - Johns-Hopkins University
#Getting and Cleaning Data - Week 4
#Course Project - Submitted by Marc Denis

#The data is assumed to have been downloaded and copied into the working directory.

#Libraries loading
library(dplyr)

#PART ONE
#Import and merging of the test dataset
subject_test<-read.table("subject_test.txt",header=FALSE,col.names="subject")
activity_test<-read.table("Y_test.txt",header=FALSE,col.names="activity")
feature_test<-read.table("X_test.txt",header=FALSE)
full_test<-cbind(subject_test,activity_test,feature_test)

#Import and merging of the train dataset
subject_train<-read.table("subject_train.txt",header=FALSE,col.names="subject")
activity_train<-read.table("Y_train.txt",header=FALSE,col.names="activity")
feature_train<-read.table("X_train.txt",header=FALSE)
full_train<-cbind(subject_train,activity_train,feature_train)

#Merging the two datasets into one
full_set<-rbind(full_test,full_train)

#Changing the full dataset's class into one compatible with dplyr
full_set<-tbl_df(full_set)


#PART TWO
#Import the feature vector variables descriptions
feature_labels<-read.table("features.txt",header=FALSE)

#Retrieve the column number of variables that are measurements of the mean or of the standard deviation
col_numbers<-grep("(mean)|(std)",feature_labels$V2)

#Add two to each value of this vector, as the 1st feature variable is actually in 3rd position in the full dataset
#(first two positions are already in use by the subject number and the activity number)
plustwo<-function(x){x+2}
col_numbers<-sapply(col_numbers,plustwo)

#Add back the columns 1 and 2 (subject and activity IDs), as we want to keep them as well.
col_numbers<-c(1,2,col_numbers)

#Drop the columns of the full dataset whose numbers do not belong to the col_numbers vector
full_set<-select(full_set,col_numbers)


#PART THREE
#Import the activity names
activity_labels<-read.table("activity_labels.txt",header=FALSE,col.names=c("activity","activityname"))

#Join the activity labels with the full dataset
full_set<-merge(full_set,activity_labels,by.x="activity",by.y="activity")

#Replace the activity column with the activityname column we just joined. Move it back to second place as before. 
full_set<-select(full_set,"subject","activityname",3:(ncol(full_set)-1))


#PART FOUR
#Use descriptive variable names to label the columns of the data set
names(full_set)[3:81]<-grep("(mean)|(std)",feature_labels$V2,value=TRUE)


#PART FIVE
#Group the dataset by activity and subject
new_set<-group_by(full_set,activityname,subject)

#Calculate the average value of each field, using the grouping generated just before
new_set_avg<-summarise_all(new_set,funs(mean))

#Save this new dataset into a separate file
write.table(new_set_avg,"new_set_avg.txt",quote=FALSE,sep=";",row.names=FALSE)