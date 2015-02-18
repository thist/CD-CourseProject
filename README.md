README For Course Project
===========================

The tidy dataset is derived from "Human Activity Recognition Using Smartphones Dataset" [1] which can be obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description of Files
--------------------

* File *run_analysis.R* performs transformations (described below) to the data set and creates a file "tidy_data.csv" containing for each combination of personID (1st column) and activity (2nd column) the average for each variable on measurements of the mean and standard deviation of the original data set.

* File *Codebook.md*  describes the variables of the output file "tidy_data.csv".


Description of Input Data Set
-----------------------------

The following files from the Input Data Set were used:

* File *X_train.txt* and *X_test.txt*: Each row contains a measurement for 561 variables for a specific subject and activity.
* File *feature.txt*: The file describes the column names in X_train.txt and X_test.txt.
* File *y_train.txt and y_test.txt: Each row specifies an activity (numbers 1-6 correspond to activities described in activity_labels.txt) corresponding to the measurements in X_train.txt and X_test.txt
* File *activity_labels.txt*: The file contains the description of the activity indicies.
* File *subject_train.txt* and *subject_test.txt*: Each row identifies the subject who performed the activity for each measurement. Its range is from 1 to 30.

There are in total 10299 observations in the data set (7352 in the training data and 2947 in the test data).

Description of Transformations
------------------------------

1. *Merge the training and the test sets to create one data set.* Read files X_train/test.txt, y_train/test.txt and subject_train/test.txt from directory train and test and append the test data to the training data for all 3 files.

2. *Extract only the measurements on the mean and standard deviation for each measurement.* Here only feature names containing *mean()* and *std()* are included. There are 66 relevant features.

3. *Use descriptive activity names to name the activities in the data set.* The activities labeled with 1-6 are replaced by a desciptive activity name according to activity_labels.txt.

4. *Appropriately labels the data set with descriptive variable names:* The column names of the data frame are renamed according to the labels in feature.txt (with slight changes of the format by replacing "-" with "." and deleting "()")

5. *From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.* The resulting data frame is in wide-tidy form.

6. *Write data frame to text-file "tidy_data.csv".*


Description of Output File
--------------------------

The file "tidy_data.csv" is a table containing for each combination of personID (1st column) and activity (2nd column) the average for each variable on measurements of the mean and standard deviation of the original data set.
