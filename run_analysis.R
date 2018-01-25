# Preamble: load libraries and data files
# It is assumed that the UCI HAR Dataset directory is in the working directory

library(dplyr)
library(tidyr)
library(data.table)

# Data tables are much faster to load and have good inptu options
# It would be possible to select the columns when reading the file, but this was not not for clarity
train.sensor.data <- fread("UCI HAR Dataset/train/X_train.txt" , header = FALSE, sep = " ")
test.sensor.data <- fread("UCI HAR Dataset/test/X_test.txt" , header = FALSE, sep = " ")
train.activity.codes <- fread("UCI HAR Dataset/train/y_train.txt" , header = FALSE, sep = " ", col.names = "Code.Activity")
test.activity.codes <- fread("UCI HAR Dataset/test/y_test.txt" , header = FALSE, sep = " ", col.names = "Code.Activity")
train.subjects <- fread("UCI HAR Dataset/train/subject_train.txt" , header = FALSE, sep = " ", col.names = "Code.Subject")
test.subjects <- fread("UCI HAR Dataset/test/subject_test.txt" , header = FALSE, sep = " ", col.names = "Code.Subject")

# 1. Merge the training and the test sets to create one data set.
complete.sensor.data <- rbind(train.sensor.data, test.sensor.data)
complete.activity.codes <- rbind(train.activity.codes, test.activity.codes)
complete.subjects <- rbind(train.subjects, test.subjects)

# Get rid of the incomplete tables
rm(train.sensor.data)
rm(test.sensor.data)
rm(train.activity.codes)
rm(test.activity.codes)
rm(train.subjects)
rm(test.subjects)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- fread("UCI HAR Dataset/features.txt", header = FALSE, sep = " ", select = c(2), stringsAsFactors = FALSE, col.names = c("Label"))

# The strict pattern will only select mean and std if they are preceded by a dash and followed by a set of parentheses.
# The loose pattern will select any feature containing either "mean" or std".
# i.e., in this case, loose will select the meanFreq measurements and strict will not.
pattern.strict <- "(\\-mean\\(\\))|(\\-std\\(\\))"
pattern.loose <- "(mean)|(std)"

features.to.keep <- grep(pattern = pattern.strict, features$Label)

labels.feature <- features[features.to.keep,]

complete.sensor.data <- complete.sensor.data[,features.to.keep, with = FALSE]
colnames(complete.sensor.data) <- labels.feature$Label

# Don't need these anymore...
rm(features)
rm(features.to.keep)
rm(labels.feature)
rm(pattern.strict)
rm(pattern.loose)


# 3. Uses descriptive activity names to name the activities in the data set
labels.activity <- fread("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", stringsAsFactors = TRUE, col.names = c("Code.Activity", "Label.Activity"))
complete.activity.labels <- left_join(complete.activity.codes, labels.activity, by = c("Code.Activity" = "Code.Activity"))
colnames(complete.activity.labels) <- c("Activity")

rm(complete.activity.codes)
rm(labels.activity)

# 4. Appropriately labels the data set with descriptive variable names.
complete.sensor.data <- cbind(complete.activity.labels[,2], complete.sensor.data)
colnames(complete.sensor.data)[1] <- "Activity"

rm(complete.activity.labels)
     
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
complete.sensor.data <- cbind(complete.subjects, complete.sensor.data)

tidy_d <- complete.sensor.data %>%
          group_by(Code.Subject, Activity) %>%
          summarise_all(funs(mean)) %>%
          gather(Sensor, Mean, 3:ncol(complete.sensor.data))

# write tidy file to working directory...
write.table(tidy_d, file = "out.txt",row.names = FALSE)

# Clean up remaining objects, after all that, let's leave the tidy table in memory
rm(complete.subjects)
rm(complete.sensor.data)

