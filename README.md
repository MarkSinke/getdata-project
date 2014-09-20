getdata-project
===============

The course project for the coursera getdata-007 course

The data set used here is ultimately from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, published in conjuction with [1].

The run_analysis.R script download the data in a "data" subfolder, if not already there.

It then transforms that data set into a tidy data set called "totals", for which in turn, means are computed, in a tidy data set (surprisingly) called "summary".
This set is written out to "tidy_means.txt" in the data folder and was uploaded as part of the course project.

Note that computing the mean of a series of standard deviations, or even the mean of a series of means is not a very useful thing to do, as the result has no obvious statistical meaning. But it does show the power of the dplyr and tidyr packages :-).

The [CodeBook.md] file describes how the data set was derived and the contents of the 2 resulting data sets.

Citations
=========

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
