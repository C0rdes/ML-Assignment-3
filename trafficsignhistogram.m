filename = 'Dataset/ML2016TrafficSignsTrain.csv';
M = csvread(filename); % Read the csv data set

ClassDistSet = M(:, end); % Get the last row of the dataset

h = histogram(ClassDistSet, 43); % Plot the histogram.
title('ML2016 Traffic Sign Occurrence Distribution');
xlabel('Traffic Sign Identifiers');
ylabel('Number of occurrences');
% ???
% Profit