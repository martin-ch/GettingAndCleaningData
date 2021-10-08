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



## function to download source data
run.downlaod <- function() {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip", method = "curl")
}



## main function to run all sub-functions 

run.main <- function() {
  #run.downlaod()
  
}

## calling main function 

run.main()

