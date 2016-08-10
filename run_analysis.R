### run_analysis.R

## MERGE TRAINING AND TEST DATA SETS

# LOAD DATA FILES
        
        # Load Libraries
        library(readr)
        library(data.table)
        library(plyr)
        library(dplyr) 
        
        TrainDataFile <- "./train/X_train.txt"
        TestDataFile <- "./test/X_test.txt"
        
        #Set Column Widths
        Width_txt <- 16
        for (i in 1:560){
                Width_txt <- c(Width_txt,16)
        }
        
        #Load Data Sets
        SamsungDF1 <- read_fwf(TrainDataFile, fwf_widths(Width_txt), progress = interactive())
        SamsungDF2 <- read_fwf(TestDataFile, fwf_widths(Width_txt), progress = interactive())
        
# COMBINE DATA SETS
        SamsungDFAll <- rbind(SamsungDF1, SamsungDF2) 
        
        #Apply column Names
        FeatureNames <- fread("./features.txt", col.names=c("ID", "Feature"))
        colnames(SamsungDFAll) <- FeatureNames$Feature
        
# Add Activity Labels
        #Load Activity Data
        TrainActivities <- fread("./train/y_train.txt", col.names = "ActivityID") 
        TestActivities <- fread("./test/y_test.txt", col.names = "ActivityID") 
        
        #Combine Activity Data Sets
        ActivitiesAll <- rbind(TrainActivities, TestActivities)
        
        #Load descriptive Activity Labels
        ActivityNames <- fread("./activity_labels.txt", col.names=c("ActivityID", "Activity"))
        
        #Join Activity labels to Activity Data Set - Join preserves original record order
        ActivitiesAll = join(ActivitiesAll,ActivityNames,by='ActivityID')
        
        #Add Activities to Main Data set
        SamsungDFAll <- cbind(Activity=ActivitiesAll$Activity, SamsungDFAll)
        
# Add Subject IDs
        #Load the Subject IDs
        TrainSubjects <- fread("./train/subject_train.txt", col.names = "SubjectID")
        TestSubjects <- fread("./test/subject_test.txt", col.names = "SubjectID")
        
        #Combine Subject Sets
        SubjectsAll <- rbind(TrainSubjects, TestSubjects)
        
        #Add Subjects to Data Set
        SamsungDFAll <- cbind(SubjectsAll, SamsungDFAll)
        
## OUTPUT DATA
        write.csv(SamsungDFAll, "./Merged.csv")  
                
# SUMMARIZE DATA
        
        # Extract Data for Means and SD 
        FilteredDF <- data.frame(subset(SamsungDFAll, select = c("SubjectID", "Activity", grep("Mean|mean|std", colnames(SamsungDFAll), value = TRUE))))
       
        # Summarize Filtered Data
        SummaryDF <- aggregate(FilteredDF[, 3:88], by = list(FilteredDF$Activity,FilteredDF$SubjectID), FUN = mean)
        
        # Apply Meaningful Names
        names(SummaryDF)[1:2]<-c("Activity", "SubjectID")

        # Move the SubjectID to the start of the data set
        SummaryDF <- SummaryDF[ ,names(SummaryDF)[c(2, 1, 3:88)]] 
        
## OUTPUT DATA
        write.csv(SummaryDF, "./Summary.csv")  

## END
## 
## Example Output from SamsungDFAll
#     SubjectID	Activity	tBodyAcc	tBodyAcc	tBodyAcc
#                               -mean()-X       -mean()-Y       -mean()-Z
# 1	1	STANDING	0.28858451	-0.020294171	-0.13290514
# 2	1	STANDING	0.27841883	-0.016410568	-0.12352019
# 3	1	STANDING	0.27965306	-0.019467156	-0.11346169
#
## Example output from Summary DF
#       Activity SubjectID      tBodyAcc	tBodyAcc	tBodyAcc
#                               .mean...X       .mean...Y       .mean...Z   
# 1	LAYING	   1	        0.2215982	-0.040513953	-0.11320355
# 2	SITTING	   1	        0.2612376	-0.001308288	-0.10454418
# 3	STANDING   1	        0.2789176	-0.01613759	-0.11060182
# 
        