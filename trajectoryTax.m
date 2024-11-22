function [waveRanks]=trajectoryTax(endWave)

%--------------------------------------------------------------------------
 % trajectoryTax

 % Last updated: December 2024, J. LaRocco

 % Details: Categorize trajectories of datapoints. 
 
 % Usage:
 % [waveRanks]=trajectoryTax(endWave)
 
 % Input: 
 %  endWave: Input data matrix of size 3 by N. 
 %           The first data point is first timepoint, and last is final.   

 % Output: 
 %  waveRanks: Output vector of length N, detailing the 5 trajectory taxonomies.    
    
% Codes: 1-Praire (flat), 2-valley (midtime dip), 3-mountain (midtime rise),
% 4-ascent (increase), 5-landslide (decline)


%--------------------------------------------------------------------------

slope1=endWave(2,:)-endWave(1,:);
slope2=endWave(3,:)-endWave(2,:);
slope3=endWave(3,:)-endWave(1,:);
baseLine=mean(endWave);



waveRanks=zeros(1,size(endWave,2));

for iii=1:length(waveRanks)

if endWave(1,iii)==endWave(3,iii)
    waveRanks(iii)=1;
end

if slope3(iii)>0
    waveRanks(iii)=4;
end
if slope3(iii)<0
    waveRanks(iii)=5;
end

if slope2(iii)<slope1(iii)
    waveRanks(iii)=3;

end

if slope2(iii)>slope1(iii)
    waveRanks(iii)=2;

end

end

