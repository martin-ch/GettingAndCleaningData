## Code Book
  
### Downloading the data
the function "run.downlaod()" is downloading all the raw data for further processing.  
  
### Downloading and extracting the data
The function "run.extract()" first downloads and unzips all data.  
  
According to "README.txt" in the source data, the columns in "X_train.txt" and "X_test.txt"  
are structured according to "features.txt".  
This is, the six first columns of the test and train datasets are the ones relevant for us.  
1 tBodyAcc-mean()-X  
2 tBodyAcc-mean()-Y  
3 tBodyAcc-mean()-Z  
4 tBodyAcc-std()-X  
5 tBodyAcc-std()-Y  
6 tBodyAcc-std()-Z  
  
That information has to be combined with the relevant subject ("subject_train.txt" and "subject_test.txt") and related activities ("y_train.txt" and "x_train.txt"). To convert the numeric activities to descriptive activity names,  
the mapping table "activity_labels.txt" is being used.  
  
The function "run.extract()" extracts therefore then the six columns for mean and standard deviation  
and adds the subject and activities to it.  
Finally also descriptive column names are added.  
  
### Function to provide first dataset  
The function "run.df1()" runs first the function "run.extract()", which returns the a dataframe with the relevant data.  
Afterwards the non-descriptive activity numbers are replaced with the descriptive activity.
The output of "run.df1()" is the first required dataset.  

### Function to provide the second dataset  
The function "run.df2()" takes as an input the first dataset  
and returns a tidy dataset with the average of each variable by subject and activity

