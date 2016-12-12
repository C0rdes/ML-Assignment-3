filename = 'ML Assignment 3/Dataset/ML2016TrafficSignsTrain.csv';
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

% We calculate U2 composed of the first 2 eigenvectors:
U_2 = Eigenvectors(:, [end end-1]);

% We calculate z_i for i = 1,2
U_2T = transpose(U_2);
TM = transpose(TempMatrix);

z = transpose(U_2T*TM);
labels = M(:, end);

for n = 1 : N
   val = labels(n);
   if ((val > 17) && (val < 32)) || (val == 11)
       labels(n) = 1; % Upwards pointing triangle
   elseif val == 12
       labels(n) = 2; % Diamond
   elseif val == 13
       labels(n) = 3; % Downwards pointing triangle
   elseif val == 14
       labels(n) = 4; % Octagon
   else
       labels(n) = 5; % Round
   end
   
end

scatter(z(:, 1), z(:, 2), 10, labels);
title('Scatter plot of two principal components');


