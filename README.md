README

This directory contains a script for reading and processing the data in the "UCI HAR Dataset" directory. Running the script will return a 180 x 67 table containing the means of all mean and standard deviation data for each subject and activity in the original data. Each variable is explained in the codebook. The script performs the following steps, explained in more detail in the codebook:

1) reads in all necessary files

2) matches variable names to the appropraite tables

3) finds only those columns that are either means or standard deviations of accelerometer data.  

4) changes the activity code to the activity name
 
5) combines the tables into one dataset.

6)  groups this combined set by subject and activity, and summarizes the data using the mean function for each numeric variable.

7) returns a file in the directory called tidy_data.csv.

