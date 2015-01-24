# coursera-get-clean-data
This is a repo to hold submission for the Coursera course "Getting and Cleaning Data"

# Running the scripts

To go from the raw data to the tidy summary, do the following:

* In your working directory, download the raw data zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* Unpack the zip file, which will create a folder called "UC HAR Dataset"
* Source the script `run_analysis.R`
* Run the function `makeTidyData()`.  This will generate the tidy data to the output file __tidy_final_ahv01.txt__

See CodeBook.md for a description of the variables and units in the final tidy dataset.
