function [outData,outLabels]=booleanCat(vari1,vari2,inData,inLabels)

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
 %  outData: Class 1 (2d matrix vector)
 %  outLabels: Class 2 (row vector)


%--------------------------------------------------------------------------

l1=find(inLabels==vari1);
l2=find(inLabels==vari2);

%outLabels=[inLabels(l1); inLabels(l2)];

outLabels=[zeros(size(l1)); ones(size(l2))];


d1=inData(l1,:);
d2=inData(l2,:);

outData=[d1; d2];


end
