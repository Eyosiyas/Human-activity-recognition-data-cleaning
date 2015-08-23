run_analysis.R:
======================================

This R script is used to generate tidy data from the Human Activity Recognition using Smartphones Dataset. 
	1. It first imports the training and testing datasets and merges them to one dataset. 
	2. It also loads the corresponding activity index to each observation of the training and testing dataset.
	3. From every measurement that has been recorded in the dataset, it extracts the mean and standard deviation of all the measurements that were taken and creates a subsetted dataset. 
	4. It loads the subject ids for both testing and training dataset, merges them to one list and appends them to the subsetted dataset as additional column. 
	5. It loads the activity labels to a list and joins them to the activity index table to have the activity names to each activity index in the list. 
	6. It appends the activity names column from the joined activity description table to the subsetted dataset as additional column.
	7. In order to calculate the average of every measurement for every subject and every activity label, it first melts the subsetted dataset having the activity names and subject ids as id and the rest of the columns as variables which resulted in a thinner and longer dataset.
	8. Using the dcast function, it calculated the mean of all the measurement variables for every activity to subject combination. 
	9. Finally, it writes the finalized tidy dataset to a text file ("dataset_avg.txt").

