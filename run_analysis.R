setwd("C:/Users/Rupa/Desktop/Data Science Specialization")
library(plyr)
library(data.table)
aa<-unzip("a.zip",list=TRUE)
subjectTrain = read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE)
xTrain = read.table('./UCI HAR Dataset/train/X_train.txt',header=FALSE)
yTrain = read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE)
subjectTest = read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE)
xTest = read.table('./UCI HAR Dataset/test/X_test.txt',header=FALSE)
yTest = read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE)
xDataSet <- rbind(xTrain, xTest)
yDataSet <- rbind(yTrain, yTest)
subjectDataSet <- rbind(subjectTrain, subjectTest)
dim(xDataSet)
dim(yDataSet)
dim(subjectDataSet)
xDataSet_mean_std <- xDataSet[, grep("-(mean|std)\\(\\)", read.table("./UCI HAR Dataset/features.txt")[, 2])]
names(xDataSet_mean_std) <- read.table("./UCI HAR Dataset/features.txt")[grep("-(mean|std)\\(\\)", read.table("./UCI HAR Dataset/features.txt")[, 2]), 2]
View(xDataSet_mean_std)
dim(xDataSet_mean_std)

yDataSet[, 1] <- read.table("./UCI HAR Dataset/activity_labels.txt")[yDataSet[, 1], 2]
names(yDataSet) <- "Activity"
View(yDataSet)
names(subjectDataSet) <- "Subject"
summary(subjectDataSet)
singleDataSet <- cbind(xDataSet_mean_std, yDataSet, subjectDataSet)
names(singleDataSet) <- make.names(names(singleDataSet))
names(singleDataSet) <- gsub('Acc',"Acceleration",names(singleDataSet))
names(singleDataSet) <- gsub('GyroJerk',"AngularAcceleration",names(singleDataSet))
names(singleDataSet) <- gsub('Gyro',"AngularSpeed",names(singleDataSet))
names(singleDataSet) <- gsub('Mag',"Magnitude",names(singleDataSet))
names(singleDataSet) <- gsub('^t',"TimeDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('^f',"FrequencyDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('\\.mean',".Mean",names(singleDataSet))
names(singleDataSet) <- gsub('\\.std',".StandardDeviation",names(singleDataSet))
names(singleDataSet) <- gsub('Freq\\.',"Frequency.",names(singleDataSet))
names(singleDataSet) <- gsub('Freq$',"Frequency",names(singleDataSet))
View(singleDataSet)
names(singleDataSet)
Data2<-aggregate(. ~Subject + Activity, singleDataSet, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)













































