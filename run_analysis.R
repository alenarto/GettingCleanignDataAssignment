#Getting and Cleaning Data, Wk4 Final Assignment Script
#run_analysis.R script
#17.08.14 a.l.

rm(list=ls(all = TRUE))

#read the files
x_test <- read.table("./test/x_test.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)
subjects_test <- read.table("./test/subject_test.txt",header=FALSE)

x_train <- read.table("./train/x_train.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)
subjects_train <- read.table("./train/subject_train.txt",header=FALSE)

feature_names <- read.table("features.txt",header=FALSE)
activity_class_labels <- read.table("activity_labels.txt",header=FALSE)


#add informative names to data.frame variables
#part 4 of assignment
colnames(x_train) <- feature_names[,2]
colnames(y_train) <- "activityClass"

colnames(x_test) <- feature_names[,2]
colnames(y_test) <- "activityClass"

colnames(subjects_train) <- "subjectID"
colnames(subjects_test) <- "subjectID"

remove(feature_names)

#add subject ID to each table and merge train/test datasets
#part 1 of assignment
testdata <- cbind(subjects_test, y_test, x_test)
traindata <- cbind(subjects_train, y_train, x_train)
alldata <- rbind(traindata,testdata)

remove(testdata,traindata, x_train, y_train, x_test, y_test, subjects_test, subjects_train)


#create subset with only mean and std variables
#part 2 of assignment
ind_meanVars <- grepl("Mean",names(alldata),ignore.case=TRUE)
ind_stdVars <- grepl("std",names(alldata),ignore.case=TRUE)
alldata_meanstd<-cbind(alldata[,c(1,2)], +
                       alldata[,ind_meanVars],alldata[,ind_stdVars])

remove(ind_meanVars,ind_stdVars)


#replace activity column entries with informative names from
#activity_class_labels reference column - part 3 of assigment
alldata_meanstd$activityClass[alldata_meanstd$activityClass==1] <- "walking"
alldata_meanstd$activityClass[alldata_meanstd$activityClass==2] <- "walking_upstairs"
alldata_meanstd$activityClass[alldata_meanstd$activityClass==3] <- "walking_downstairs"
alldata_meanstd$activityClass[alldata_meanstd$activityClass==4] <- "sitting"
alldata_meanstd$activityClass[alldata_meanstd$activityClass==5] <- "standing"
alldata_meanstd$activityClass[alldata_meanstd$activityClass==6] <- "laying"
alldata_meanstd$activityClass <- as.factor(alldata_meanstd$activityClass)
remove(activity_class_labels)

#update names to expand contractions - informative variable names
#part 4 of assginment
names(alldata_meanstd) <- gsub("^t","time_",names(alldata_meanstd))
names(alldata_meanstd) <- gsub("^f","frequency_",names(alldata_meanstd))
names(alldata_meanstd) <- gsub("Acc","Acceleration",names(alldata_meanstd))
names(alldata_meanstd) <- gsub("Gyro","Gyroscope",names(alldata_meanstd))
names(alldata_meanstd) <- gsub("Mag","Magnitude",names(alldata_meanstd))
names(alldata_meanstd) <- gsub("tBody","time_Body",names(alldata_meanstd)) #for angle variables

#create independent datasatet with mean of each activity within each subject, 
#for each variable - part 5 of assignment
alldata_meanstd_subjectMeans <- aggregate(. ~subjectID + activityClass, alldata_meanstd, mean)
alldata_meanstd_subjectMeans <- alldata_meanstd_subjectMeans[order(alldata_meanstd_subjectMeans$subjectID),]

#write out data
write.table(alldata_meanstd_subjectMeans, "assignmentTidyData.txt", row.name=FALSE)
