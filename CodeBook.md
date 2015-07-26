---
title: "CodeBook.md"
author: "Larry Williams"
date: "July 26, 2015"
output: html_document
---

# Transforming Smartphone raw data into tidy data  
The description of this project falls into three categories. 

***
* Describe raw data
     + orign of data
     + overall structure of source files
     + details of each of the 32 raw data files
     + description of raw data variables
* Work needed to produce tidy data
     + for details see **README.md**
* Describe in detail each of the 68 variables in the final tidy dataset
     + original variable names
     + tidy data variable names
     + expanded explanation with units of tidy data variables  

***
## Raw data
A full description of the raw data can be found here:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

The url to the raw data set (data.zip) can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

***

Here are the detailes of the original raw data  

file|                                                      Name   | Length   |   Date  
----|-------------------------------------------------------------|----------|-------
1   |                        UCI HAR Dataset/activity_labels.txt  |        80|2012-10-10
2   |                               UCI HAR Dataset/features.txt  |     15785|2012-10-11
3   |                          UCI HAR Dataset/features_info.txt  |      2809|2012-10-15  
4   |                                 UCI HAR Dataset/README.txt  |      4453|2012-12-10  
5   |                                      UCI HAR Dataset/test/  |         0|2012-11-29  
6   |                     UCI HAR Dataset/test/Inertial Signals/  |         0|2012-11-29  
7   | UCI HAR Dataset/test//Inertial Signals/body_acc_x_test.txt  |   6041350|2012-11-29  
8   | UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt   |   6041350|2012-11-29  
9   | UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt   |   6041350|2012-11-29  
10  | UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  |   6041350|2012-11-29  
11  | UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  |   6041350|2012-11-29  
12  | UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  |   6041350|2012-11-29  
13  | UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  |   6041350|2012-11-29  
14  | UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  |   6041350|2012-11-29  
15  | UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  |   6041350|2012-11-29  
16  |                      UCI HAR Dataset/test/subject_test.txt  |      7934|2012-11-29  
17  |                            UCI HAR Dataset/test/X_test.txt  |  26458166|2012-11-29  
18  |                            UCI HAR Dataset/test/y_test.txt  |      5894|2012-11-29  
19  |                                     UCI HAR Dataset/train/  |         0|2012-11-29  
20  |                    UCI HAR Dataset/train/Inertial Signals/  |         0|2012-11-29  
21  | UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt |  15071600|2012-11-29  
22  | UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt |  15071600|2012-11-29  
23  | UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt |  15071600|2012-11-29  
24  | UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt|  15071600|2012-11-29  
25  | UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt|  15071600|2012-11-29  
26  | UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt|  15071600|2012-11-29  
27  | UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt|  15071600|2012-11-29  
28  | UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt|  15071600|2012-11-29  
29  | UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt|  15071600|2012-11-29  
30  |                    UCI HAR Dataset/train/subject_train.txt  |     20152|2012-11-29  
31  |                          UCI HAR Dataset/train/X_train.txt  |  66006256|2012-11-29  
32  |                          UCI HAR Dataset/train/y_train.txt  |     14704|2012-11-29  

***
Reading each file into a data frame (df1:df32) produced this additional information.  

file  |df   | rows  | columns
------|-----|-------|--------
1     |df1  |    6  |       2
2     |df2  |  561  |       2
3     |df3  |    0  |       0
4     |df4  |    0  |       0
5     |df5  |    0  |       0
6     |df6  |    0  |       0
8     |df8  | 2947  |     128
9     |df9  | 2947  |     128
10    |df10 | 2947  |     128
12    |df12 | 2947  |     128
13    |df13 | 2947  |     128
14    |df14 | 2947  |     128
15    |df15 | 2947  |     128
16    |df16 | 2947  |       1
17    |df17 | 2947  |     561
18    |df18 | 2947  |       1
19    |df19 |    0  |       0
20    |df20 |    0  |       0
21    |df21 | 7352  |     128
22    |df22 | 7352  |     128
23    |df23 | 7352  |     128
24    |df24 | 7352  |     128
25    |df25 | 7352  |     128
26    |df26 | 7352  |     128
27    |df27 | 7352  |     128
28    |df28 | 7352  |     128
29    |df29 | 7352  |     128
30    |df30 | 7352  |       1
31    |df31 | 7352  |     561
32    |df32 | 7352  |       1

The source url has the following description of the raw data.  
**Data Set Information:**

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

***

**Attribute Information:**


For each record in the dataset it is provided: 

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

***
# Processing to go from raw data to tidy data 

* Data wrangling needed to produce tidy data
     + for details see **README.md**
     + intermediate data frames of raw data
          + intial df has 561 columns and 10,299 rows
          + next (desired subset) has 68 columns by 10,299 rows
     + create final tidy dataset by averaging each measureable variable:
          + over subject
          + over activity

***

##  Description of 68 variables in tidy data set  
NOTE: all variables below are averages of original raw data.  

***
NOTE: ran out of time. Can't get this table to work and need rest of variable definitions.

  Tidy data variable name    |   Description                                              
-----------------------------|------------------------------------------------------------
[1] "Grp1(ID_Subject)"       | factor from 1:30 that id's the subject
[2] "Grp2(Activity)"         | the 6 activities: walking, walking up, etc.
[3] "tBodyAccMeanX"          | time domain measurement of bodies acceleration in X-axis
[4] "tBodyAccMeanY"          | time domain measurement of bodies acceleration in Y-axis
[5] "tBodyAccMeanZ"          | time domain measurement of bodies acceleration in Z-axis
[6] "tGravityAccMeanX"       | time domain measurement of gravity accceleration in X-axis
[7] "tGravityAccMeanY"       | time domain measurement of gravity accceleration in Y-axis
[8] "tGravityAccMeanZ"       | time domain measurement of gravity accceleration in Z-axis
[9] "tBodyAccJerkMeanX"      |  definition
[10] "tBodyAccJerkMeanY"     |  definition
[10] "tBodyAccJerkMeanY"     |  definitino
[11] "tBodyAccJerkMeanZ"     |  definition
[12] "tBodyGyroMeanX"        |  definition
[13] "tBodyGyroMeanY"        |  definition
[14] "tBodyGyroMeanZ"        |  definition
[15] "tBodyGyroJerkMeanX"    |  definition
[16] "tBodyGyroJerkMeanY"    |  definition
[17] "tBodyGyroJerkMeanZ"    |  definition
[18] "tBodyAccMagMean"       |  definition
[19] "tGravityAccMagMean"    |  definition
[20] "tBodyAccJerkMagMean"   |  definition
[21] "tBodyGyroMagMean"      |  definition
[22] "tBodyGyroJerkMagMean"  |  definition
[23] "fBodyAccMeanX"         |  definition
[24] "fBodyAccMeanY"         |  definition
[25] "fBodyAccMeanZ"         |  definition
[26] "fBodyAccJerkMeanX"     |  definition
[27] "fBodyAccJerkMeanY"     |  definition
[28] "fBodyAccJerkMeanZ"     |  definition
[29] "fBodyGyroMeanX"        |  definition
[30] "fBodyGyroMeanY"        |  definition
[31] "fBodyGyroMeanZ"        |  definition
[32] "fBodyAccMagMean"       |  definition
[33] "fBodyBodyAccJerkMagMean|  definition
[34] "fBodyBodyGyroMagMean"  |  definition
[35] "fBodyBodyGyroJerkMagMea|  definition
[36] "tBodyAccStdX"          |  definition
[37] "tBodyAccStdY"          |  definition
[38] "tBodyAccStdZ"          |  definition
[39] "tGravityAccStdX"       |  definition
[40] "tGravityAccStdY"       |  definition
[41] "tGravityAccStdZ"       |  definition
[42] "tBodyAccJerkStdX"      |  definition
[43] "tBodyAccJerkStdY"      |  definition
[44] "tBodyAccJerkStdZ"      |  definition
[45] "tBodyGyroStdX"         |  definition
[46] "tBodyGyroStdY"         |  definition
[47] "tBodyGyroStdZ"         |  definition
[48] "tBodyGyroJerkStdX"     |  definition
[49] "tBodyGyroJerkStdY"     |  definition
[50] "tBodyGyroJerkStdZ"     |  definition
[51] "tBodyAccMagStd"        |  definition
[52] "tGravityAccMagStd"     |  definition
[53] "tBodyAccJerkMagStd"    |  definition
[54] "tBodyGyroMagStd"       |  definition
[55] "tBodyGyroJerkMagStd"   |  definition
[56] "fBodyAccStdX"          |  definition
[57] "fBodyAccStdY"          |  definition
[58] "fBodyAccStdZ"          |  definition
[59] "fBodyAccJerkStdX"      |  definition
[60] "fBodyAccJerkStdY"      |  definition
[61] "fBodyAccJerkStdZ"      |  definition
[62] "fBodyGyroStdX"         |  definition
[63] "fBodyGyroStdY"         |  definition
[64] "fBodyGyroStdZ"         |  definition
[65] "fBodyAccMagStd"        |  definition
[66] "fBodyBodyAccJerkMagStd"|  definition
[67] "fBodyBodyGyroMagStd"   |  definition
[68] "fBodyBodyGyroJerkMagStd|  definition


