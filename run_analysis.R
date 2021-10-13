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

  ##Download and unzip the data
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip", method = "curl")
  #unzip("Dataset.zip")
  
  ##Extract the data into individual dataframes  
  df.test.subjects    <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  df.test.activities  <- read.csv("UCI HAR Dataset/test/y_test.txt",       header = FALSE)
  df.test.data        <- read.fwf("UCI HAR Dataset/test/X_test.txt", c(16,16,16,16,16,16))
  df.test             <- cbind(df.test.subjects, df.test.activities, df.test.data)
  df.train.subjects   <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  df.train.activities <- read.csv("UCI HAR Dataset/train/y_train.txt",       header = FALSE)
  df.train.data       <- read.fwf("UCI HAR Dataset/train/X_train.txt", c(16,16,16,16,16,16))
  df.train <- cbind(df.train.subjects, df.train.activities, df.train.data)
  
  ## Merge the Test and Training datasets
  df <- rbind(df.test, df.train)

  ## Name the columns
  names(df) <- c("Subject","Activity ID",
                 "Mean (x-axis acceleration)","Mean (y-axis acceleration)","Mean (z-axis acceleration)",
                 "Standard Deviation (x-axis acceleration)","Standard Deviation (y-axis acceleration)","Standard Deviation (z-axis acceleration)")
  
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
                 "Standard Deviation (x-axis acceleration)","Standard Deviation (y-axis acceleration)","Standard Deviation (z-axis acceleration)")
  
    
  df

}



## Generate the two datasets
df1 <- run.df1()
df2 <- run.df2(df1)



