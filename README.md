# Getting and Cleaning Data Course Project

This is course project assignment for the "Getting and Cleaning Data" course. Attached R script `run_analysis.R` works as mentioned below:

* Sets the working directory.(You need to set `dir` variable with required path)
* It downloads and unzips the zipfile from mentioned url in the working directory.
* Loads activity and subject related information and sets required fields names in appropriate format.
* Loads train and test datasets by removing columns not related to mean and standard deviation.
* Both datasets are merged and columns names are set based on step 3.
* Generates new dataset by taking the average of each variable for each activity and each subject using melt and dcast function.
* dataset is save as `tidy.txt` in the working directory.
