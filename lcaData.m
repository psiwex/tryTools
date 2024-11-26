% MATLAB Script for Latent Class Analysis

% Load your data
% Assume 'data' is a matrix where rows are observations and columns are categorical variables
% Example: data = [1 2 1; 2 1 3; 3 2 2; ...];
%data = load('your_data_file.mat');
table1 = readtable('drinksWave.xlsx');
table2 = readtable('drinksBinge.xlsx');

drinkWave=table2cell(table1);
drinkBingge=table2cell(table2);

cellWave=cell2mat(drinkWave(:,2:end));
cellBinge=cell2mat(drinkBingge(:,2:end));

cellWave=prototype_cleanup(cellWave);
cellBinge=prototype_cleanup(cellBinge);

endWave=downsample(cellWave',2);
endBinge=downsample(cellBinge',4);

data=endWave;

%data = [1 2 1; 2 1 3; 3 2 2; 1 2 4];
data=ceil(data);

% Specify the number of latent classes
numClasses = 5; % Adjust this based on your analysis needs

[probWave,~]=lcaCalc(endWave,numClasses);
[probBinge,~]=lcaCalc(endBinge,numClasses);

% Output results
disp('Estimated Class Probabilities for Wave:');
disp(probWave);
disp('Estimated Class Probabilities for Binge:');
disp(probBinge);
% disp('Estimated Item-Response Probabilities:');
% disp(itemProb);