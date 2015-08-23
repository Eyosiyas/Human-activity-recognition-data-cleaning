## load column names for the feature vectors in testing and training datasets
descconn <- file("features.txt","r")
descColNames <- read.table(descconn)
close(descconn)

## load test dataset
testconn <- file("./test/X_test.txt","r")
datatemp <- read.table(testconn) 
testdata <-data.frame(matrix(unlist(datatemp),ncol=ncol(datatemp), byrow=TRUE)) 
##colnames(testdata)<-descColNames[,2]
close(testconn)
testconn <- file("./test/y_test.txt","r")
activity_idx <- read.table(testconn) 
close(testconn)
subjconn <- file("./test/subject_test.txt", "r")
subject_ids <- read.table(subjconn)
close(subjconn)

## load training datasets
trainconn <- file("./train/X_train.txt","r")
datatemp <- read.table(trainconn) 
traindata <-data.frame(matrix(unlist(datatemp),ncol=ncol(datatemp), byrow=TRUE)) 
##colnames(traindata)<-descColNames[,2]
close(trainconn)
trainconn <- file("./train/y_train.txt","r")
activity_idx <- rbind(activity_idx,read.table(trainconn))
close(trainconn)
subjconn <- file("./train/subject_train.txt", "r")
subject_ids <- rbind(subject_ids,read.table(subjconn))
close(subjconn)

## merge training and testing datasets
dataset <- rbind(traindata, testdata)
colnames(dataset)<-descColNames[,2]

## extract mean and std of every measurement
indcs <- sort(c(grep("-mean()",descColNames[,2]),grep("-std()",descColNames[,2])))
dataset_sub <- dataset[indcs]

## add subject ids 
dataset_sub$subject_ids<-subject_ids[,1]
## add activity description
descconn <- file("activity_labels.txt","r")
activity_lbls <- read.table(descconn)
close(descconn)
activity_desc <- merge(activity_idx, activity_lbls)
dataset_sub$activity_desc <- activity_desc$V2

## calculate average of every measurement for every subject and every activity label
datamelt <- melt(dataset_sub,id=c("activity_desc","subject_ids"),measure.vars=colnames(dataset_sub)[1:(ncol(dataset_sub)-2)])
dataset_avg <- dcast(datamelt, activity_desc + subject_ids ~ variable, mean)
write.table(dataset_avg, "dataset_avg.txt", sep="\t")