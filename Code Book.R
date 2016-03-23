library(dplyr)
library(tidyr)

# Working with train data

setwd("C:\\Users\\Prasad\\Documents\\UCI HAR Dataset")
features <- read.table("features.txt", sep = " ",header = FALSE)
setwd("C:\\Users\\Prasad\\Documents\\UCI HAR Dataset\\train")
x_train <- read.table("X_train.txt",header= FALSE)
train_label <- read.table("Y_train.txt",header=FALSE)
train_label1 <- factor(train_label$V1, labels = c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying"))
train_sub <- read.table("subject_train.txt",header=FALSE)
x_train1 <- tbl_df(x_train)
x_train1 <- select(x_train1,V1:V6)
x_train_set <- data.frame(Subject=train_sub$V1,Activity=train_label1,x_train1)
colnames(x_train_set) <- c("Subject","Activity",as.character(features$V2[1:6]))


# Working with test data

setwd("C:\\Users\\Prasad\\Documents\\UCI HAR Dataset\\test")
test_label <- read.table("Y_test.txt",header = FALSE)
test_label1 <- factor(test_label$V1, labels = c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying"))
test_sub <- read.table("subject_test.txt",header=FALSE)
x_test <-  read.table("X_test.txt",header = FALSE)
x_test1 <- tbl_df(x_test)
x_test1 <- select(x_test1,V1:V6)
x_test_set <- data.frame(Subject=test_sub$V1,Activity=test_label1,x_test1)
colnames(x_test_set) <- c("Subject","Activity",as.character(features$V2[1:6]))

# Combining both data and storing the final data to a CSV file

combined_set <- rbind(x_test_set,x_train_set)
combined_set <- tbl_df(combined_set)
result_set <- combined_set %>% group_by(Subject,Activity)%>%summarise_each(funs(mean))
write.table(result_set,file="tidy_data",sep=",",col.names = TRUE)