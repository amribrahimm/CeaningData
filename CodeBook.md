main steps in run_analysis.R

  1. download and extract smartphone data from the following link
      -  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  2. read extracted data in the following variables 
     - features  
     - X_test  
     - Y_test  
     - subject_test  
     - X_train
     - Y_train  
     - subject_train  
     - activity_labels
     
  3. Merges the training and the test sets to create one data set called (all).
  
  4. Extracts only the measurements on the mean and standard deviation for each measurement in (mean_std).
  
  5. Uses descriptive activity names to name the activities in the data set (mean_std)
  
  6. Appropriately labels the data set (mean_std) with descriptive variable names.
  
  7. creates a second, independent tidy data set (called mean_std_final) with the average of each variable for each activity and each subject and save it in file called "mean_std_final.txt".
  
  