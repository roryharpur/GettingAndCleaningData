# GettingAndCleaningData

This script requires that the data from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

is unzipped in the working directory og the R script.



The project contains the following files:
- readme.md
- codebook.md
- run_analysis.r



The run_analysis.r file contains the code to read data into R. It will then
merge the data frames and clean the data in order to output a file cleanData.txt
that has labeled variables for all of the mean and standard devations in the 
original data set.