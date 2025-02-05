function [outFeatures]=featureRanks(inData,inLabels)

%--------------------------------------------------------------------------
 % booleanCat

 % Last updated: Feb 2025, J. LaRocco

 % Details: Isolate only two categories.
 
 % Usage:
 % [classProb,itemProb]=featureScanner(cat1,cat2)
 
 % Input: 
 %  inData: Class 1 (2d matrix vector, observation by metrics)
 %  inLabels: Class 2 (row vector)

 % Output: 
 %  outFeatures: row vector of top feature index



%--------------------------------------------------------------------------

[alms1a,~,~,~]=feature_selection_adenz(inData,inLabels,inData,1);
[alms1b,~,~,~]=feature_selection_aden(inData,inLabels,inData,1);
cat1=[alms1a, alms1b];
outFeatures=sort(cat1,'ascend');


end
