## Getting and Cleaning Data Course Project
-------------------------------------------

This project loads the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.php) and outputs a tidy data set.

The following steps were taken to process the original data into a a tidy data set:

1. Merge test and training data
2. Select sensor measurements that are either mean or standard devation
3. Substitute descriptive activity labels for activity codes
4. Aggregate and summarise by taking the mean sensor reading for each subject and activity
5. Convert sensor names into variables: making the wide data long
5. Save the final table to "out.csv"

It is assumed that the [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is unzipped and saved to the working directory as is.

The following libraries are required: [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html), [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html), [data.table](https://cran.r-project.org/web/packages/data.table/index.html)