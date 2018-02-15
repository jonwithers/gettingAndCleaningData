########
# EXPLANATION OF VARIABLES
########

subject: a unique integer for each of 30 subjects (1-30)
activity: a short description of each activity (WALKING, SITTING, etc.)

Time-domain variables:

tBodyAcc-XYZ: triaxial body acceleration (means and standard deviations)
tGravityAcc-XYZ: triaxial gravity acceleration (means and standard deviations)
tBodyAccJerk-XYZ: triaxial body jerk (means and standard deviations)
tBodyGyro-XYZ: triaxial body angular velocity (means and standard deviations)
tBodyGyroJerk-XYZ: triaxial body angular jerk (means and standard deviations)
tBodyAccMag: magnitude of body acceleration (means and standard deviations)
tGravityAccMag: magnitude of gravity acceleration (means and standard deviations)
tBodyAccJerkMag: magnitude of body jerk (means and standard deviations)
tBodyGyroMag: magnitude of body angular acceleration (means and standard deviations)
tBodyGyroJerkMag: magnitude of body angular jerk (means and standard deviations)

Frequency-domain variables:

fBodyAcc-XYZ: triaxial body acceleration (means and standard deviations)
fBodyAccJerk-XYZ: triaxial body jerk (means and standard deviations)
fBodyGyro-XYZ: triaxial body angular velocity (means and standard deviations)
fBodyAccMag: magnitude of body acceleration (means and standard deviations)
fBodyAccJerkMag: magnitude of body jerk (means and standard deviations)
fBodyGyroMag: magnitude of angular velocity (means and standard deviations)
fBodyGyroJerkMag: magnitude of angular jerk (means and standard deviations)

Variables that start with t represent the time domain, and those that begin with f represent the frequency domain. Variables that contain mean() represent means, and those that contain std() represent standard deviations. X, Y, and Z represent triaxial data in those directions, and Acc and Gyr represent acceleration and angular velocity.  

All values are normalized between -1 and 1.

########
# STEPS PERFORMED ON DATA
########

The script:

1) reads in all necessary files as tables (assuming that the working directory contains the UCI HAR Dataset)

2) matches the data from features.txt (the variable names) with the corresponding columns in the X_test and X_train data by making the values in features the names of the columns of X_test and X_train.

3) finds only those columns that are either means or standard deviations of accelerometer data. This is done using regular expressions. The following considerations were taken ito account when deciding which variables were approriate:
	a) any variable that was a simple mean or standard deviation was included. The names of these variables included mean() and std().
	b) while several values also involve measuring a mean, those values were processed beyond a simple mean. For example, any value that measures the mean of frequencies of Fourier-transformed data was not included.
	c) finally, the means of angles were not included for similar reasons--they did not represent the mean values of direct measurements from the devices.

4)  joins the y_test and y_train values to the appropraite activity_label. y_test and y_train each contain a single column of data with a code for the activity corresponding to a row of data from the X_test and X_train data; by using left_join, these codes were matched with their corresponding values without changing the order.
 
5) column binds the y and x values for both test and train, and row binds the two into one combined dataset (combined).

6)  groups this combined set by subject and activity, and summarizes the data using the mean function for each numeric variable (using summarize_at).

7) returns this summarized tidy dataset using write.csv to produce a file in the directory called tidy_data.csv.