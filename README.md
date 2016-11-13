This script takes in the raw data provide by UCI HAR Dataset and creates a tidy version of the data.

The script first constructs tables for the labels and features of the activties provided.
It then uses these tables to determine the entries within the test and trial data sets which include either means or standard deviations.  The script then pulls these respective columns from the trial and test sets and combines the two seperate data sets.  Finnally it melts the data to determine averages for each variable.
