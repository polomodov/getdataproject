Explanation
=================
Pre
-------
* You should set wd to current file
* Require reshape2

Steps  of algorythm
------------------
* Download data for analysis
* Unzip it to wd
* Read X training and test data
* Read Y training and test data
* Read subject train and test data
* Read activities data and label Y_data  file
* Read features.txt file. 
* Get only mean and standard deviation for each measurement. 
* Label the mean and std data set (xDataMS) dataset
* Put labels for sData 
* Merge datasets
* Creates independent tidy data set