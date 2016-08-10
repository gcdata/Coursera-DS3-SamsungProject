C O D E   B O O K

Variables and Summaries Calculated

*** Data File: Combined.csv ***

Merged Data Set: combined data sets './train/X_train.txt' and './test/X_test.txt' 
	  	 Column Names were added to the combined data set from project file: './features.txt'

	Variables Added:
		
		Activity: (Variable length character vector)
			  Contains a character vector of meaningful activity names from project file: 
			  './activity_labels.txt'
			  Data derived from activity indices in the training and test data sets, project files:
			  './train/y_train.txt' and './test/y_test.txt'
		
		Subject ID: (integer) 
			  Applied to the merged data set from project files:  'train/subject_train.txt' and 
			  'test/subject_test.txt'

		Original data variables are described in the files 'Original_Data_README.txt' and 
		'Original_Data_features_info.txt'

Summary Data Set: Summary of Merged Data Set, includes variables SubjectID, Activity, and all variables
		  relating to either mean or standard deviation (std) values.  Data set is grouped by Subject ID
		  and Activity.

	Calculated Variables: All mean and std values were averaged by SubjectID and Activity.
	
	Units: Acceleration variables (starting 'BodyAcc' and 'GravityAcc') are measured in g's (gravity of
 		earth -> 9.80665 m/sec2)
               Gyroscope variables (starting 'BodyGyro') are measured in radians/sec
	       Angle variables (starting 'angle') are measured in radians	

	Further information see codebook: https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

