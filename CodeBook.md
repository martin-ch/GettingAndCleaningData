## Code Book
  
### Variables
Within the functions we store all the results in a dataframe variable called "df".  
The result of the script are two dataframe variables:  
df1: The cleaned data before it's being grouped  
df2: The tidy dataset that is submitted as "DataSet.txt"  
  
### Downloading the data
the function "run.downlaod()" is downloading all the raw data for further processing.  
  
### Downloading and extracting the data
The function "run.extract()" first downloads and unzips all data.  
  
According to "README.txt" in the source data, the columns in "X_train.txt" and "X_test.txt"  
are structured according to "features.txt".  
We need to extract all columns that contain either "mean()" or "std()"

That information has to be combined with the relevant subject ("subject_train.txt" and "subject_test.txt") and related activities   ("y_train.txt" and "x_train.txt"). To convert the numeric activities to descriptive activity names,  
the mapping table "activity_labels.txt" is being used.  
  
The function "run.extract()" extracts therefore then the relevant columns containing mean and standard deviation data    
and adds the subject and activities to it.  
Finally also descriptive column names are added.  
  
### Function to provide first dataset  
The function "run.df1()" runs first the function "run.extract()", which returns the a dataframe with the relevant data.  
Afterwards the non-descriptive activity numbers are replaced with the descriptive activity.  
The output of "run.df1()" is the first required dataset.  

### Function to provide the second dataset  
The function "run.df2()" takes as an input the first dataset  
and returns a tidy dataset with the average of each variable by subject and activity.

