run_analysis  <- function(){
        # for run_analysis to work, we need to have working directory set to:
        #   "...Getting and Cleaning Data/Project"
        
        # ensure needed packages are available
        require("data.table")
        require("dplyr")
        require("tidyr")
        
        # get the data needed for this project
        fileurl <- paste("https://d396qusza40orc.cloudfront.net",
                         "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                         sep="")
        fileloc <- ".\\data.zip"
        zfile <- "data.zip"
        
        # download it if it doesn't exist, otherwise skip this step
        if(!file.exists(fileloc)){
                download.file(fileurl, destfile = fileloc, method = "curl")
                # document when the data was downloaded
                dateDownloaded <- date() 
                save(dateDownloaded,file="dateDownloaded.Rdata")
        }
        
        # get list of files in data.zip (with relative paths)
        #   df_zip is a data frame & this step does NOT unzip
        df_zip <- unzip(zfile, list=TRUE)

        # check 1 file to see if this script has already unzipped data.zip
        file1 <- df_zip$Name[1]
        # unzip the whole thing, if necessary
        if(!file.exists(file1))
                unzip(zfile)
        
        #  Use following naming scheme for data frames read in from 32 files:
        #   df1 <-read.table(df_zip$Name[1], header=FALSE, sep="", dec=".")
        #   df2, df3,..., & df32 read in as data frames the same way
        # offline analysis of df1:df32 indicates:
        #   dt31 is the training set with 561 features with 7352 obs
        #   dt17 is the test set with 561 features and 2947 obs.
        #
        # Step 1:  (NOTE: these Steps do not correspond to Project items 1:5)
        # read in df31 and df17:
        #   then bind the rows to obtain a df with 561 features & 10,299 obs.
        df17 <-read.table(df_zip$Name[17], header=FALSE, sep="", dec=".")
        df31 <-read.table(df_zip$Name[31], header=FALSE, sep="", dec=".")
        df <- dplyr::bind_rows(df31,df17)
        
        # Step 2: read the 561 feature names and use grep to get list of names
        #   of features (columns) with mean & std so we can extract only
        #   those measurements for our data frame.
        df2 <-read.table(df_zip$Name[2], header=FALSE, sep="", dec=".")
        lColMeans <- grep("-mean()", df2$V2,fixed = TRUE)
        lColStd <- grep("-std()", df2$V2,fixed = TRUE)
        # make one list with both sets of column numbers.
        lColMS <- c(lColMeans,lColStd)
        # use the column locations to extract a set of names from df
        dfnamesSub <- names(df[lColMS])
        # use the names and dplyr::select to make a new df with desired columns
        df <- dplyr::select(df,one_of(dfnamesSub))
        
        # Step 3: develop new column names for df
        #   get the original column names from df2 for desired columns
        df2namesSub <- as.character((df2$V2)[lColMS])
        #   transform the original names into suitable dataframe colnames
        df2namesSub <- gsub("-","",fixed = TRUE, df2namesSub)
        df2namesSub <- gsub("()","",fixed = TRUE, df2namesSub)
        df2namesSub <- gsub("mean","Mean",fixed = TRUE, df2namesSub)
        df2namesSub <- gsub("std","Std",fixed = TRUE, df2namesSub)
        #   rename df columns with revised names
        for(i in 1:length(df2namesSub)){
                colnames(df)[i] <- df2namesSub[i]
        }
        
        # Step 4: add two new columns to df: 
        #         1. ID_Subject: (1:30) 
        #         2. activity: ("Walking","Walking Up","Walking Down"
        #                       "Sitting","Standing","Lying Down")
        #    first read in the subjects data and bind train and test sets
        df16 <-read.table(df_zip$Name[16], header=FALSE, sep="", dec=".")
        df30 <-read.table(df_zip$Name[30], header=FALSE, sep="", dec=".")
        dfID <- dplyr::bind_rows(df30,df16)
        dfID$V1 <- as.factor(dfID$V1)  # make it easier to group by
        colnames(dfID)[1] <- "ID_Subject"
        # next read in the activities and bind train and test sets
        df18 <-read.table(df_zip$Name[18], header=FALSE, sep="", dec=".")
        df32 <-read.table(df_zip$Name[32], header=FALSE, sep="", dec=".")
        dfAct <- dplyr::bind_rows(df32,df18)
        #    now replace integer activities with descriptive activity names
        actnames <- c("Walking","Walking Up","Walking Down",
                      "Sitting","Standing","Lying Down")
        dfAct <- dplyr::transmute(dfAct,Activity = actnames[V1])
        dfAct$Activity <- as.factor((dfAct$Activity)) # easier to group by
        #    now bind these new variables to the front of df
        df <- dplyr::bind_cols(dfAct,df)
        df <- dplyr::bind_cols(dfID,df)
        
        df <- data.frame(df)
        
        # create second data set with average of each variable for each
        # activity and each subject
        df2 <- aggregate(df[,3:68],by=list(df$ID_Subject,df$Activity),
                         FUN = mean)
        # modify Group.1 and Group.2 colnames to indicate where they originated
        colnames(df2)[1] <- "Grp1(ID_Subject)"
        colnames(df2)[2] <- "Grp2(Activity)"
        # finally write this second data set out as instructed
        write.table(df2,file = "tidydata2.txt",row.names = FALSE)
        
        df2
}