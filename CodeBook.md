---
title: "CodeBook"
output: html_document
---

##Data
Full dataset description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
**Raw Data** source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Experimental **study design** (from original README.txt documentation)  

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.*  

*The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.*

##Rows
Each row is an observation for data for column variables as follows:

##Variables 
1. SubjectID - numeric, anonymized identifier of participant in study (numeric)
2. activityClass - one of 6 activities performed during data collection (character)
3. columns 3 to 88 - collected data, name tags breakdown as follows:
        
        frequency - spectral-domain data
        time - time-domain data
        X,Y,Z - tri-axial indices of measurements fromm Gyroscope/Acceleratometer (in X,Y,Z direction)
        Acceleration - acceleration measurements
        Gyroscope - gyroscope measurements 
        Body - body acceleration
        Gravity - gravity acceleration 
        Total - total accelereation 
        angle - extracted angular acceleration
        jerk - derived jerk indices
        mean - mean statistics
        std - standard deviation statistics
        
*Full documentation for feature supra-set is described in features_info.txt, original documentation.*  

##Transformations
The TIDY data (**assignmentTidyData.txt**) were derived from **RAW DATA** as follows. These steps can be executed using the **run_analysis.R** script.  

1. For each of test and train directory data, the x_* and y_* data were merged (columnwise), along with subject IDs and activity labels. The train and test data were then stacked (merged rowwise).

2. From this supraset, only mean and standard deviation columns were retained.

3. Names were expanded to provide descriptive information (e.g., t > time, f > frequency etc.).

4. Activity label codes were replaced with descriptives (e.g., 1 > walking etc.).

5. Final tidy set was creating by averaging each subjects' data (rows), within each activity label.




