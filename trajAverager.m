function [outMat]=trajAverager(workHorse,dataWork)

%--------------------------------------------------------------------------
 % trajAverager

 % Last updated: December 2024, J. LaRocco

 % Details: Average trajectories for each trajectory. 
 
 % Usage:
 % [outMat]=trajAverager(workHorse,dataWork)
 
 % Input: 
 %  dataWork: Input data matrix of size 3 by N. 
 %           The first data point is first timepoint, and last is final.   
 %  workHorse: Input data array of size N, detailing class labels. 

 % Output: 
 %  outMat: Output matrix of size 3 by length N, averaging the class trajectories.    
    
% Codes: 1-Praire (flat), 2-valley (midtime dip), 3-mountain (midtime rise),
% 4-ascent (increase), 5-landslide (decline)


%--------------------------------------------------------------------------



outMat=[];
xx=unique(workHorse);
for kk=1:length(xx)
    targetVal=xx(kk);
    comboIdx=find(workHorse==targetVal);
    trajMat=dataWork(:,comboIdx);
    aveMat=mean(trajMat');
    outMat(:,kk)=aveMat;
end

end
