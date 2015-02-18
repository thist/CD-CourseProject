# Structure of Input Data Set
# - total number of rows: 7352 (training data) + 2947 (test data)
# - file x_train/test: all measurements for 561 variables (column names are descriped in features.txt)
# - file y_train/test: type of activity (numbers 1-6, activities described in activity_labels.txt)
# - file subject_train/test: person id

# Output: Tidy Data Set in File "tidy_data.txt"

library(dplyr)

#------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set
#------------------------------------------------------------------

# read training data set
person_id_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
measurements_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)

# read test data set
person_id_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
measurements_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)

# merge data sets
person_id <- rbind(person_id_train, person_id_test)
measurements <- rbind(measurements_train, measurements_test)
activities <- rbind(activities_train, activities_test)

#------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
#------------------------------------------------------------------

# read column names for measurements
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)

# extract the columns with the mean and standard deviation values
features_mean <- features[grepl("mean()",features[,2],fixed=TRUE),]
features_std <- features[grepl("std()",features[,2],fixed=TRUE),]

# convert column names to string
features_mean$V2 <- sapply(features_mean$V2, as.character)
features_std$V2 <- sapply(features_std$V2, as.character)

# extract all measurements for mean and standard deviation in x
measurements_relevant <- measurements[,c(features_mean$V1, features_std$V1)]

#------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------------

# assign descriptive activity names
activities_named <- unlist(sapply(activities$V1,switch, '1'="WALKING", '2'="WALKING_UPSTAIRS", '3'="WALKING_DOWNSTAIRS", '4'="SITTING", '5'="STANDING", '6'="LAYING", 'undefined'=""))

#------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names
#------------------------------------------------------------------

# create data frame with all relevant measurements for each activity and each subject
data_frame_all_measurements <- cbind(person_id, activities_named, measurements_relevant)

# change names to valid R column names
features_mean$V2 <- gsub("\\(|\\)", "", features_mean$V2)
features_mean$V2 <- gsub("-", ".", features_mean$V2)
features_std$V2 <- gsub("\\(|\\)", "", features_std$V2)
features_std$V2 <- gsub("-", ".", features_std$V2)
# label the data set with descriptive variable names
colnames(data_frame_all_measurements) <- c("personId", "activity", features_mean$V2, features_std$V2)

#------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#------------------------------------------------------------------

data_frame_averages <- data_frame_all_measurements %>% group_by(personId, activity) %>% summarise_each(funs(mean))

#------------------------------------------------------------------
# 6. Write data frame to text-file
#------------------------------------------------------------------

# write data to file
write.table(data_frame_averages, file = "./tidy_data.txt", row.name=FALSE)

