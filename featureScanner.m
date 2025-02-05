function [mainOuts,outRow]=featureScanner(cat1,cat2)

%--------------------------------------------------------------------------
 % lcaCalc

 % Last updated: Feb 2025, J. LaRocco

 % Details: Calculate separable classes.
 
 % Usage:
 % [classProb,itemProb]=featureScanner(cat1,cat2)
 
 % Input: 
 %  cat1: Class 1 (2d matrix vector)
 %  cat2: Class 2 (row vector)

 % Output: 
 %  mainOuts: Main separable feature.
 %  outRow: Row of phi correlations.

%--------------------------------------------------------------------------


outRow=[];
[z0,z1]=size(cat1);

for iii=1:z1

[r0,~]=corrcoef(cat1(:,iii),cat2);
spec11=r0(1,2);
outRow(iii)=spec11;
end

outMax=max(outRow);


mainOuts=find(outRow==outMax);
end
