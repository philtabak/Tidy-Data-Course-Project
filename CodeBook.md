Code Book
-------------------------------------------

This project outputs a data table to [out.csv](out.csv). This is a tidy data set with the following variables:

* Code.Subject (int): Subject number, 1-30
* Activity (Factor): Activity performed by the subject suring the sensor read, possible values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
* Sensor (chr): Name of the sensor and type of measurement (i.e., mean or std)
* Mean (num): Sensor reading, bounded by [1,-1]

The README.txt, features.txt, features_info.txt, activity_labels.txt in the root level of the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) contain detailed information on the original data.