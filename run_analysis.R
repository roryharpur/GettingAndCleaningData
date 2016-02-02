library(plyr)

## Read activity labels and feature labels
activitylabels <- read.table(file.path(getwd(), "UCI HAR Dataset/activity_labels.txt"), col.names = c("Labels", "LabelNames"))
featurelabels <- read.table(file.path(getwd(), "UCI HAR Dataset/features.txt"), colClasses = c("character"))

## Clean the feature labels so that they can be used as descriptive names for variables in the data
featurelabels <- gsub("\\(\\)","",featurelabels$V2)

## Read test data
testfolder <- file.path(getwd(),"UCI HAR Dataset/test")
data_test <- read.table(file.path(testfolder,"X_test.txt"))
labels_test <- read.table(file.path(testfolder,"Y_test.txt"))
subject_test <- read.table(file.path(testfolder,"subject_test.txt"))

## Appropriately label the data with descriptive names
colnames(data_test) <- featurelabels
colnames(labels_test) <- "Labels"
colnames(subject_test) <- "Subject"

## Bind X, Y and Subject Test data
data_test <- cbind(data_test,labels_test,subject_test)

## Read train data
trainfolder <- file.path(getwd(),"UCI HAR Dataset/train")
data_train <- read.table(file.path(trainfolder,"X_train.txt"))
labels_train <- read.table(file.path(trainfolder,"Y_train.txt"))
subject_train <- read.table(file.path(trainfolder,"subject_train.txt"))

## Appropriately label the data with descriptive names
colnames(data_train) <- featurelabels
colnames(labels_train) <- "Labels"
colnames(subject_train) <- "Subject"
data_train <- cbind(data_train,labels_train,subject_train)

## Merge train and test data
data <- rbind(data_train,data_test)

## Extracts only the measurements on the mean and standard deviation for each measurement
data <- data[,grepl("mean|std|Labels|Subject",names(data_test))]

## Appropriately labels the data set with descriptive variable names
data <- join(data, activitylabels, by="Labels")

## Create clean data frame with averages for each Subject/LabelName combination
cleanData <- ddply(data, c("Subject","LabelNames"), numcolwise(mean))

## Write clean data to file
write.table(cleanData, file="cleanData.txt", row.name=FALSE)