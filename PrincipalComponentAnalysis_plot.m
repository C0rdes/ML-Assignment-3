filename = 'Dataset/ML2016TrafficSignsTrain.csv';
M = csvread(filename); % Read the csv data set

% Get data values
Data = M(:, 1:end-1); 
% Get number of dimensions
N = size(Data, 1);
D = size(Data, 2); 

% Calculate the empirical mean
XMean = sum(Data, 1) / N; 



% Calculate covariance matrix
TempMatrix = Data - XMean; 
CovarianceMatrix = transpose(TempMatrix)*TempMatrix / N; 

% Calculate eigenvectors and eigenvalues of the covariance matrix
[Eigenvectors, Eigenvalues] = eig(CovarianceMatrix);

TotalVariance = 0;
% Calculate total variance
for d = 1 : D
   TotalVariance = TotalVariance + Eigenvalues(d, d); 
end

% Calculate the summed variance quotient.
Eigenspectrum = diag(Eigenvalues) / TotalVariance;
Eigenspectrum = flip(Eigenspectrum);
for d = 2 : D
   Eigenspectrum(d, 1) = Eigenspectrum(d, 1) + Eigenspectrum(d - 1, 1); 
end

% We plot the eigenspectrum.
plot(Eigenspectrum);
title('Eigenspectrum');
xlabel('Index of eigenvalue');
ylabel('Explained variance in percentage');
grid on;


