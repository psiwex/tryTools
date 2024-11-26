function [classAves]=probCombiner(workHorse)

%--------------------------------------------------------------------------
 % probCombiner

 % Last updated: December 2024, J. LaRocco

 % Details: Average probabilities for each trajectory. 
 
 % Usage:
 % [outMat,classAves]=trajAverager(workHorse,dataWork)
 
 % Input: 
 %  workHorse: Input data array of size N, detailing class labels. 

 % Output: 
 %  classAves: Array for probability of each class of length N.
% Codes: 1-Praire (flat), 2-valley (midtime dip), 3-mountain (midtime rise),
% 4-ascent (increase), 5-landslide (decline)


%--------------------------------------------------------------------------




xx=unique(workHorse);
classAves=zeros(1,length(xx));
for jk=1:length(xx)
    classVal=xx(jk);
    comboLng=find(workHorse==classVal);
    classPr=length(comboLng)/length(workHorse);
    classAves(jk)=classPr;

end
end
