## ---------------------------
##
## Script name: run_analysis.R
##
## Purpose of script:
## - Assignment of Week 4 of "Getting and Cleaning Data" of "Data Science Specialization (JOHNS HOPKINS UNIVERSITY)" 
## - Merge, clean and label and extract datasets 
## 
## Author: Buehler M.
##
## Date Created: 2021-10-11
##
##

## Load relevant libraries
library(dplyr)

## function to download source data, extract and name the relevant columns
run.extract <- function() {

  ## Download and unzip the data
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip", method = "curl")
  unzip("Dataset.zip")
  
  ## Extract the data into individual dataframes  
  
  df.test.data        <- read.table("UCI HAR Dataset/test/X_test.txt")
  df.test.subjects    <- read.csv  ("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  df.test.activities  <- read.csv  ("UCI HAR Dataset/test/y_test.txt",       header = FALSE)
  df.test             <- cbind(df.test.subjects, df.test.activities, df.test.data)
  
  df.train.data       <- read.table("UCI HAR Dataset/train/X_train.txt")
  df.train.subjects   <- read.csv  ("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  df.train.activities <- read.csv  ("UCI HAR Dataset/train/y_train.txt",       header = FALSE)
  df.train <- cbind(df.train.subjects, df.train.activities, df.train.data)
  
  ## Merge the Test and Training datasets
  df <- rbind(df.test, df.train)

  ## Name the columns
  df.columns<- read.table("UCI HAR Dataset/features.txt")[,2]
  names(df)  <- c("Subject","Activity ID", df.columns)

  # Create a logical vector to show the columns that contain Mean, mean or std
  df.columns.match <- grepl("(mean|Mean|std)", df.columns)
  df <- df[, c(TRUE, TRUE, df.columns.match)]

  ## Return the dataframe
  df
}

## function to prepare the first dataset

run.df1 <- function() {
  
  ## Prepare the dataframe
  df <- run.extract()
  
  ## Extract activities mapping table
  df.activities <- read.fwf("UCI HAR Dataset/activity_labels.txt", c(2,20))  
  names(df.activities) <- c("Activity ID", "Activity")
                 
  ## Join df with df.activities  
  df <- merge(df, df.activities, by="Activity ID")
  
  ## Extract and reorder relevant columns
  df <- df[,c(2,9,3,4,5,6,7,8)]
}

## function to prepare the second tidy dataset

run.df2 <- function(df) {
  ## group by Subject and Activity
  df <- df %>% 
    group_by(Subject, Activity) %>%
    summarize(mean(`Mean (x-axis acceleration)`),
              mean(`Mean (y-axis acceleration)`),
              mean(`Mean (z-axis acceleration)`),
              mean(`Standard Deviation (x-axis acceleration)`),
              mean(`Standard Deviation (y-axis acceleration)`),
              mean(`Standard Deviation (z-axis acceleration)`))

  names(df) <- c("Subject","Activity",
                 "Mean (x-axis acceleration)","Mean (y-axis acceleration)","Mean (z-axis acceleration)",
                 "Mean of Standard Deviation (x-axis acceleration)","Mean of Standard Deviation (y-axis acceleration)","Mean of Standard Deviation (z-axis acceleration)")
  
  df <- as.data.frame(df)
  
  df
}



## Generate the two datasets
#df1 <- run.df1()
#df2 <- run.df2(df1)

## Generate the text file for submission
#write.table(df2, "DataSet.txt", row.names = FALSE)


