
#labels and features
activity_labels      <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2]  <- as.character(activityLabels[,2])
features             <- read.table("UCI HAR Dataset/features.txt")
features[,2]         <- as.character(features[,2])   

#Get Mean STd features
wanted <- grep(".*mean.*|.*Mean.*|.*MEAN.*|.*std.*|.*Std.*|.*STD.*", features[,2])
wanted.labels <- features[wanted,2]

# clean labeling standardize references to mean and std to uniform label
wanted.labels = gsub("-mean", "Mean", wanted.labels)
wanted.labels = gsub("-std", "Std", wanted.labels)
wanted.labels = gsub("-Mean", "Mean", wanted.labels)
wanted.labels = gsub("-Std", "Std", wanted.labels)
wanted.labels = gsub("-MEAN", "Mean", wanted.labels)
wanted.labels = gsub("-STD", "Std", wanted.labels)
wanted.labels = gsub('[-()]', '', wanted.labels)

#add training
trainx       <- read.table("UCI HAR Dataset/train/X_train.txt")[wanted]
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainy       <- read.table("UCI HAR Dataset/train/Y_train.txt")
train        <- cbind(trainSubject, trainy, trainx)

#add test
testx        <- read.table("UCI HAR Dataset/test/X_test.txt")[wanted]
testy        <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject  <- read.table("UCI HAR Dataset/test/subject_test.txt")
test         <- cbind(testSubject, testy, testx)

#merge
combined          <- rbind(test,train) 
colnames(combined)<- c("subject", "activity", wanted.labels)

#Create a second independent data set showing averages (melt and mold)
combinedMelt <- melt(combined, id = c("subject", "activity"))
combinedMean <- dcast(combinedMelt, subject+ activity ~ variable, mean);

#export data frames table
write.table(combinedMean, "tidy.txt")

