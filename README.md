# Getting and Cleaning Data Project

The R code contains the following steps:

	1. Downloading the data if it does not exsit already and set the the working directory to the unziped data folder
	2. reading the files required
	3. merging the measurements, activity and subject data into separate columns
	4. Extracting the mean and standard deviation rows in the merged measurement column
	5. assigning the activity names from the list 
	6. labeling the variables based on given measurement variables
	7. merging the columns into a single dataset
	8. performing the averaging for each activity and each subject in the formed full dataset
	9. form a new dataset using the average values for each activity and each subject
