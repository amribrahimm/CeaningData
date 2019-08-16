library(dplyr)
projectfiles <- "getdata_projectfiles_UCI HAR Dataset.zip"

# download "getdata_projectfiles_UCI HAR Dataset.zip" file if not exists
if (!file.exists(projectfiles)){
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, projectfiles, method="curl")
}  

# Check if "getdata_projectfiles_UCI HAR Dataset.zip" already extracted beafore
if (!file.exists("UCI HAR Dataset")) { 
  unzip(projectfiles) 
}

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index","signalmethods"))

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$signalmethods)
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "serial")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")


X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$signalmethods)
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "serial")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("serial", "activity"))


Y <- rbind(Y_train, Y_test)
X <- rbind(X_train, X_test)
Subject <- rbind(subject_train, subject_test)
all <- cbind(Subject, Y, X)


mean_std <- all %>% select(subject, serial, contains("mean"), contains("std"))
mean_std$serial <- activity_labels[mean_std$serial, 2]

names(mean_std)[2] = "activity_desc"
names(mean_std)<-gsub("Acc", "Accelerometer", names(mean_std))
names(mean_std)<-gsub("-freq()", "Frequency", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("angle", "Angle", names(mean_std))
names(mean_std)<-gsub("Gyro", "Gyroscope", names(mean_std))
names(mean_std)<-gsub("BodyBody", "Body", names(mean_std))
names(mean_std)<-gsub("Mag", "Magnitude", names(mean_std))
names(mean_std)<-gsub("^t", "Time", names(mean_std))
names(mean_std)<-gsub("-mean()", "Mean", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("^f", "Frequency", names(mean_std))
names(mean_std)<-gsub("tBody", "TimeBody", names(mean_std))
names(mean_std)<-gsub("-std()", "STD", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("gravity", "Gravity", names(mean_std))



mean_std_final <- mean_std %>%
  group_by(subject, activity_desc) %>%
  summarise_all(mean)

write.table(mean_std_final, "mean_std_final.txt", row.name=FALSE)


