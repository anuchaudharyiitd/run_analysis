## Tidy Part 1
# Get feature names and subset to only those features of mean or std measures
features<-read.table("features.txt")
features1<- grep("std|mean", features$V2)

## Tidy Part 2
# Get the train and test feature sets and subset only the desired features
testX<- read.table("C:/Users/Transorg/Desktop/test/X_test.txt")
testX1<- testX[,features1]
trainX <-read.table("C:/Users/Transorg/Desktop/train/X_train.txt")
trainX1<- trainX[,features1]

## Tidy Part 3
# Combine the two datasets into 1
totalX<- rbind(testX1,trainX1)

## Tidy Part 4
# Attach column names to features
colnames(totalX)<- features[features1,2]

# Tidy Part 5
# Read and combine the train and test activity codes
testY <- read.table("C:/Users/Transorg/Desktop/test/y_test.txt")
trainY <-read.table("C:/Users/Transorg/Desktop/train/y_train.txt")
total.activities<- rbind(testY,trainY)

# Tidy Part 6
# Get activity labels and attach to activity codes
activity.labels<- read.table("C:/Users/Transorg/Desktop/activity_labels.txt")
total.activities$activity <- factor(total.activities$V1, levels = activity.labels$V1, labels = activity.labels$V2)

# Tidy Part 7
# Get and combine the train and test subject ids
subject_test<-read.table("C:/Users/Transorg/Desktop/test/subject_test.txt")
subject_train <- read.table("C:/Users/Transorg/Desktop/train/subject_train.txt")
subject<- rbind(subject_test, subject_train)
subjects_activities <- cbind(subject, total.activities$activity)
colnames(subjects_activities) <- c("subject.id", "activity")

# Tidy Part 9
# Combine with measures of interest for finished desired data frame
activity.frame <- cbind(subjects_activities, totalX)

# Compute New Result
# From the set produced for analysis, compute and report means of 
# all measures, grouped by subject_id and by activity.
result.frame <- aggregate(activity.frame[,3:81], by = list(activity.frame$subject.id, activity.frame$activity), FUN = mean)
colnames(result.frame)[1:2] <- c("subject.id", "activity")
write.table(result.frame, file="mean_measures.txt", row.names = FALSE)
