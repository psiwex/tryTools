function [bpm,hr,meanRR,stdRR,alphaPower,alphaStd,hrv,hrvStd] = calcBpm(EEG,ekgPeaks,eegChan)
%% Preprocess EEG data for TRY. Requires EEGLAB and EEGBEATS
% By John LaRocco, 19 April 2024
% Parameters:
%    EEG          EEGLAB struct with data to preprocess. Output after
%                 processing. 
%    ekgPeaks     Input struct from EEGBEATS
%    eegChan      EEG channel to examine
%    hr           Heart beats for total length of time
%    bpm          HR in beats per minute (BPM)
%    hrv          HR variability calculated by Root Mean Square of Successive Differences (RMSSD)
%    hrvStd       standard deviation of HRV 
%    meanRR       Mean beat length in seconds
%    stdRR        Standard deviation of beats in seconds
%    alphaPower   Power of alpha band
%    alphaStd     Standard deviation of alpha band
%%
peaks=length(ekgPeaks.peakFrames);
rrInfo=diff(ekgPeaks.peakFrames);
meanRR=mean(rrInfo)/(EEG.srate);
stdRR=std(rrInfo)/(EEG.srate);
hrv=mean(sqrt(rrInfo.*rrInfo))/(EEG.srate);
hrvStd=std(sqrt(rrInfo.*rrInfo))/(EEG.srate);

hr=peaks/(length(EEG.data)/(EEG.srate));
bpm=hr*60;
eegData=EEG.data;
chanData=eegData(eegChan,:)';
[Pxx,~]=featuresWelch(chanData,EEG.srate);
alphaPower=Pxx(5);
alphaStd=std(Pxx(3:5));

end