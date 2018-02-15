# This script reads files into tables and 
# creates a clean, tidy dataset from the
# values. More information can be found in
# the readme and codebook files.

library(dplyr)

#######
# read in the files:
#######

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#######
# make the features dataframe into a character vector, and
# make that character vector the names of both X_test and 
# X_train.
#######

features <- features[,2]
names(X_test) <- features
names(X_train) <- features

#######
# find only the columns in X_test and 
# X_train for mean and std values. See Readme for 
# a discussion on which values were selected.
#######

pattern_mean_and_std <- "mean[/(]|std[/(]"
means_std_variables <- grep(pattern_mean_and_std, names(X_test), value = TRUE)
X_test <- X_test[,means_std_variables]
X_train <- X_train[,means_std_variables]

#######
# using left_join to preserve order, merge y_test and y_train 
# each with activity_labels. Give each variable a name.
#######

y_test <- left_join(y_test, activity_labels)
names(y_test) <- c("activitycode", "activity")
y_test <- y_test[,2]
y_train <- left_join(y_train, activity_labels)
names(y_train) <- c("activitycode", "activity")
y_train <- y_train[,2]

#######
# make subject_test, y_test, and X_test into one
# dataframe using cbind; same for train. merge these
# two using rbind to make one big dataframe. rename var1
#######

test_combined <- cbind(subject_test, y_test, X_test)
test_combined <- rename(test_combined, activity = y_test)
train_combined <- cbind(subject_train, y_train, X_train)
train_combined <- rename(train_combined, activity = y_train)
combined <- rbind(test_combined, train_combined)
combined <- rename(combined, subject = V1)

end <- length(names(combined))

#######
# group by subject and activity. Using the list of numeric variables generated above,
# use summarize_at to produce a final dataframe with one row for each combination of 
#######

subjectactivity <- group_by(combined, subject, activity)
final <- summarize_at(subjectactivity, names(combined)[c(-1,-2)], mean)
write.table(final, "tidy_data.txt")