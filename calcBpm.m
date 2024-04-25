function [bpm,hr,meanRR,stdRR] = calcBpm(EEG,ekgPeaks)
%% Preprocess EEG data for TRY. Requires EEGLAB and EEGBEATS
% By John LaRocco, 19 April 2024
% Parameters:
%    EEG          EEGLAB struct with data to preprocess. Output after
%                 processing. 
%    ekgPeaks     Input struct from EEGBEATS
%    hr           Heart beats for total length of time
%    bpm          HR in beats per minute (BPM)
%    meanRR       Mean beat length in seconds
%    stdRR        Standard deviation of beats in seconds

%%
peaks=length(ekgPeaks.peakFrames);
rrInfo=diff(ekgPeaks.peakFrames);
meanRR=mean(rrInfo)/(EEG.srate);
stdRR=std(rrInfo)/(EEG.srate);
hr=peaks/(length(EEG.data)/(EEG.srate));
bpm=hr*60;
end