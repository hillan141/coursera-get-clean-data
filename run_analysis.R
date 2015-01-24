# Coursera Getting and Cleaning Data
# Course Project
# AH 24 January 2015

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or
#    work that you performed to clean up the data called CodeBook.md. 
#    You should also include a README.md in the repo with your scripts. 

# Wrapper function to create final tidy dataset
makeTidyData <- function() {
  ds <- mergeTrainTest()
  tf <- tidyFinal(ds)
  writeTidyFinal(tf)
  message("completed writing tidy dataset to working directory")
}

# Read feature names
readFeats <- function(infile="UCI HAR Dataset/features.txt") {
    ff <- scan(infile, what=list(integer(), character()))
    featnames <- ff[[2]]
    stopifnot(length(featnames)==561)
    featnames
}

# Read training or test dastasets
# and cache them for future use
readSets <- function(set="train") {
  stopifnot(any(set %in% c("test", "train")))
  infile <- sprintf("UCI HAR Dataset/%s/X_%s.txt", set, set)
  outfile <- sprintf("%s.raw.RData", set)
  actfile <- sprintf("UCI HAR Dataset/%s/y_%s.txt", set, set)
  subsfile <- sprintf("UCI HAR Dataset/%s/subject_%s.txt", set, set)
  if (!file.exists(outfile)) {
    feats <- readFeats()
    stopifnot(length(feats)==561)
    tr <- read.table(infile, 
                     col.names=feats, check.names=FALSE)
    activs <- scan(actfile, 
                   what=integer())
    stopifnot(length(activs)==nrow(tr))
    act.labs <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, 
                           col.names=c("ACTIVITY_ID", "ACTIVITY"))
    stopifnot(nrow(act.labs)==6)
    act.lookup <- act.labs[,"ACTIVITY"]
    subs <- scan(subsfile, what=integer())
    stopifnot(nrow(tr) == length(subs))
    stopifnot(length(activs)==length(subs))
    tr <- data.frame(SUBJECT=subs, ACTIVITY=act.lookup[activs], tr,
                     check.names=FALSE)
    save(tr, file=outfile)
    return(tr)
  } else {
    obs <- load(outfile)
    message(sprintf("loaded cached %s set", set))
    return(tr)
  }
}

# Merge the training and test datasets
mergeTrainTest <- function() {
    tr <- readSets("train")
    tt <- readSets("test")
    ds <- rbind(tr, tt)
    ds <- extractVariables(ds)
    stopifnot(nrow(ds)==(nrow(tr)+nrow(tt)))
    ds
}

# Extract the mean() and std() aggregation features only
extractVariables <- function(ds) {
  j.std <- grep("std\\(\\)", colnames(ds))
  j.mean <- grep("mean\\(\\)", colnames(ds))
  jt <- sort(union(j.std, j.mean))
  ds[,c(1,2,jt)]
}

# Aggregate features by (subject, activity) average and return the aggregated values
tidyFinal <- function(ds) {
    sa.means <- t(sapply(split(ds, list(ds$SUBJECT, ds$ACTIVITY)), function(z) apply(z[,-c(1,2)],2,mean)))
    sub.act <- do.call("rbind", strsplit(rownames(sa.means), split="\\."))
    tfinal <- data.frame( SUBJECT=as.numeric(sub.act[,1]), 
                          ACTIVITY=sub.act[,2],
                          sa.means,
                          check.names=FALSE,
                          row.names=NULL)
}

# Write the final dataset to a delimited text file
writeTidyFinal <- function(tf, outfile="tidy_final_ahv01.txt") {
    write.table(tf, file=outfile, quote=FALSE, row.names=FALSE)
}


