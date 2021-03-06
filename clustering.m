% Clustering

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

% We calculate U2 composed of the first 2 eigenvectors:
U_2 = Eigenvectors(:, [end end-1]);

% We calculate z_i for i = 1,2
U_2T = transpose(U_2);
TM = transpose(TempMatrix);

z = transpose(U_2T*TM);

%%% k-means clustering algorithm
K = 4;
% Initialize class centroids
centroids = z(1:4, :);
oldcentroids = zeros(4, 2);
dataset = [z zeros(N, 1)];
iterations = 0;
maxiterations = 1000;
while(not(isequal(centroids, oldcentroids)) && (iterations < maxiterations))
    oldcentroids = centroids;
    iterations = iterations + 1;
    
    % calculate new labels
    for n = 1 : N
       point = dataset(n, [1 2]); 
       mindist = inf;
       for k = 1 : K
           x1 = centroids(k, 1);
           y1 = centroids(k, 2);
           x2 = point(1, 1);
           y2 = point(1, 2);
           dist = sqrt((x2 - x1)^2 + (y2 - y1)^2);
           if dist < mindist
               mindist = dist;
               dataset(n, 3) = k;
           end
       end
    end
    
    % calculate new centroids
    for k = 1 : K
       centroids(k, :) = [0 0];
       numpoints = 0;
       for n = 1 : N
          label = dataset(n, 3);
          if label == k
             numpoints = numpoints + 1; 
             centroids(k, :) = centroids(k, :) + dataset(n, [1 2]);
          end
       end
       if numpoints == 0 % no points
           centroids(k, :) = dataset(randi([1 N]), [1 2]);
       else
           centroids(k, :) = centroids(k, :) / numpoints;
       end
    end
    
end

centroids = [centroids(:, :) zeros(4, 1)];
centroids(1, 3) = 6;
centroids(2, 3) = 7;
centroids(3, 3) = 8;
centroids(4, 3) = 9;
dataset = [dataset; centroids];
    


scatter(dataset(:, 1), dataset(:, 2), 10, dataset(:, 3));
title('k-means clustering results');




