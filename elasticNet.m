function [outMatrix]=elasticNet(workingMatrix,thresPer)

%--------------------------------------------------------------------------
 % elasticNet

 % Last updated: December 2024, J. LaRocco

 % Details: Consolidate trajectory types for each dataset. 
 
 % Usage:
 % [outMatrix]=elasticNet(workingMatrix,thresPer)
 
 % Input: 
 %  workingMatrix: Input data array of size N. 
 %  thresPer: A percentage on the lower threshold to consolidate classes.
 %            For example, a value of .15 would turn any class of less than
 %            15% of the population into the next highest class.
 
 % Output: 
 %  outMatrix: Output data array of size N, after clearing the labels out. 
    
% Codes: 1-Praire (flat), 2-valley (midtime dip), 3-mountain (midtime rise),
% 4-ascent (increase), 5-landslide (decline)



%--------------------------------------------------------------------------

%thresPer=.15;
unVals=unique(workingMatrix);
totalLength=length(workingMatrix);
vecMode=zeros(1,length(unVals));
vecPop=zeros(1,length(unVals));
vecThres=zeros(1,length(unVals));
outMatrix=workingMatrix;
for jj=1:length(unVals)
mostVal=mode(workingMatrix);
idxMode=find(workingMatrix==mostVal);
lengPop=length(idxMode);

vecMode(jj)=mostVal;
vecPop(jj)=lengPop;

if lengPop<round(thresPer*totalLength)
vecThres(jj)=1;
end
workingMatrix(idxMode)=[];
end

thresFinder=find(vecThres==1);
thresFinder=thresFinder(1)-1;

if thresFinder > 0
    valueChange=vecMode(thresFinder);
    valsToChange=vecMode((thresFinder+1):end);

    for jjj=1:length(valsToChange)
        workingVec=valsToChange(jjj);
        changIdx=find(outMatrix==workingVec);
        outMatrix(changIdx)=valueChange;
    end

end


end