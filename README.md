# Coursera_data_cleaning_merging
Repository to share the codes developed for the coursera data science course 3 cleaning and merging data. 
The code written is self explanatory and has a lot of comments for almost each and every line.
The code works as follows:
1. Setting the working director
2. Loading all the required datasets such as test data, train data, subject data, activity label etc.
3. Becasue these datasets themselve do not have a column name hence R provides column names like "V1", "V2" etc. So the next step is to impute the column names loaded from the file "features.txt"
4. merging the datasets with activity class and subjects
5. combining the train and test datasets
6. selecting only the mean and standard deviation columns
7. adding the descriptive activity names to the dataset
8. loading the column description dataset which has description of the column names 
9. changing the abbrevated column names to descriptive ones
10. summarizing data: calculating the mean of the variable by grouping through each subject and each activity
