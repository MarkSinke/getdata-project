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
library(tidyr)

activity_labels <- tbl_df(read.table(file = "data/UCI HAR Dataset/activity_labels.txt", 
                                     col.names = c("value", "activity")))
features <- tbl_df(read.table(file = "data/UCI HAR Dataset/features.txt", 
                              col.names = c("value", "feature")))

features <- mutate(features, feature = gsub("[()]", "", feature))

readSet <- function(name) {
    data <- tbl_df(read.table(file = sprintf("%s/%s/X_%s.txt", folder, name, name),
                                              col.names = features$feature))
    data_subjects = tbl_df(read.table(file = sprintf("%s/%s/subject_%s.txt", folder, name, name),
                                       col.names = c("subject")))
    data$subject <- data_subjects$subject
    
    y <- tbl_df(read.table(file = sprintf("%s/%s/y_%s.txt", folder, name, name), 
                           col.names = c("activity_id")))
    
    readable_y = tbl_df(merge(y, activity_labels, by.x = "activity_id", by.y = "value"))
    data$activity <- readable_y$activity
    
    select(data, subject, activity, contains(".mean."), contains(".std."))
}

train <- readSet("train")
test <- readSet("test")

# total is the data set obtained for step 4
total <- tbl_df(rbind(train, test))

# now, compute the mean of each of the variables by first gathering them in 
# a grouped column, computing the mean for each group, and then spreading them
# back into column names
summary <- gather(total, varName, value, -subject, -activity) %>%
    group_by(subject, activity, varName) %>% 
    summarize(mean = mean(value)) %>% 
    spread(varName, mean)

write.table(summary, file = "data/tidy-means.txt", row.name = FALSE)
