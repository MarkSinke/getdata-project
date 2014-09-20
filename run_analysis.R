# Run the analysis on the data set provided by the getdata-007 course on Coursera

folder <- "data/UCI HAR Dataset"

# Download the data set, extract it to the data directory - but only the first time
if (!file.exists(folder)) {
    dir.create("data")
    download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        destfile = "data/data.zip", mode = "wb")
    unzip(zipfile = "data/data.zip", exdir = "data")
}

library(dplyr)

activity_labels <- tbl_df(read.table(file = "data/UCI HAR Dataset/activity_labels.txt", 
                                     col.names = c("value", "activity")))
features <- tbl_df(read.table(file = "data/UCI HAR Dataset/features.txt", 
                              col.names = c("value", "feature")))

features <- mutate(features, feature = gsub("[()]", "", feature))

readSet <- function(name) {
    train <- tbl_df(read.table(file = sprintf("%s/%s/X_%s.txt", folder, name, name),
                                              col.names = features$feature))
    train_subjects = tbl_df(read.table(file = sprintf("%s/%s/subject_%s.txt", folder, name, name),
                                       col.names = c("subject")))
    train$subject <- train_subjects$subject
    
    y <- tbl_df(read.table(file = sprintf("%s/%s/y_%s.txt", folder, name, name), 
                           col.names = c("activity_id")))
    
    readable_y = tbl_df(merge(y, activity_labels, by.x = "activity_id", by.y = "value"))
    train$activity <- readable_y$activity
    
    select(train, contains(".mean."), contains(".std."))
}

train <- readSet("train")
test <- readSet("test")

# total is the data set obtained for step 4
total <- tbl_df(rbind(train, test))





