function [classProb,itemProb]=lcaCalc(data,numClasses)

%--------------------------------------------------------------------------
 % lcaCalc

 % Last updated: December 2024, J. LaRocco

 % Details: Calculate Latent Class Analysis (LCA). 
 
 % Usage:
 % [classProb,itemProb]=lcaCalc(data,numClasses)
 
 % Input: 
 %  data: Assume 'data' is a matrix where rows are observations and columns are categorical variables
 %  numClasses: Integer number of classes. 

 % Output: 
 %  classProb: Output matrix of size numClasses by 1
 %  itemProb: Output matrix of size numClasses by numVars by max of 'data'.
    
% Codes: 1-Praire (flat), 2-valley (midtime dip), 3-mountain (midtime rise),
% 4-ascent (increase), 5-landslide (decline)


%--------------------------------------------------------------------------

data=ceil(data);

% Initialize parameters
[numObs, numVars] = size(data);
classProb = ones(1, numClasses) / numClasses; % Initial class probabilities
itemProb = rand(numClasses, numVars, max(data(:))); % Random initial item-response probabilities

% Expectation-Maximization (EM) algorithm
maxIter = 1000;
tolerance = 1e-6;
logLikelihood = -inf;

for iter = 1:maxIter
    % E-step: Calculate posterior probabilities for each observation
    postProb = zeros(numObs, numClasses);
    for ii = 1:numObs
        for c = 1:numClasses
            prob = classProb(c);
            for jj = 1:numVars
                if data(ii, jj)<=0
                    data(ii, jj)=1;
                end

                prob = prob * itemProb(c, jj, data(ii, jj));
            end
            postProb(ii, c) = prob;
        end
    end

    % Normalize posterior probabilities
    postProb = postProb ./ sum(postProb, 2);

    % M-step: Update class and item-response probabilities
    classProb = mean(postProb, 1);
    for c = 1:numClasses
        for j2 = 1:numVars
            for k = 1:max(data(:))
                itemProb(c, j2, k) = sum(postProb(data(:, j2) == k, c)) / sum(postProb(:, c));

            end
        end
    end

    % Calculate log-likelihood and check convergence
    newLogLikelihood = sum(log(sum(postProb, 2)));
    if abs(newLogLikelihood - logLikelihood) < tolerance
        break;
    end
    logLikelihood = newLogLikelihood;
end
