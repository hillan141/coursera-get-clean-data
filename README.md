# coursera-get-clean-data
This is a repo to hold the course project work for the Coursera course "Getting and Cleaning Data"

This repo contains 3 files:

1. This file (__README.md__)
2. An R script that transforms the raw Samsung dataset to an aggregated tidy dataset (__run_analysis.R__)
3. A code book that describes the data cleaning process and final variables (__CodeBook.md__)

# Running the scripts

To process the raw data into the tidy summary dataset, do the following:

* In your working directory, download the Samsung raw data zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* Unpack the zip file, which will create a sub-folder in the working directory called "UC HAR Dataset"
* Place the script `run_analysis.R` in the working directory
* Start R, and source the script `run_analysis.R`
* Run the function `makeTidyData()`.  
* This will generate the tidy data to the output file __tidy_final_ahv01.txt__

See CodeBook.md for a description of the variables and units in the final tidy dataset.
