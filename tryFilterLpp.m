function [outStruct] = tryFilterLpp(inputCells)
%% Preprocess EEG data for TRY. Requires EEGLAB and EEGBEATS
% By John LaRocco, 14 June 2024
% Parameters:



%load('lppNeuCells.mat','lppNeuCells');
%load('lppAlcCells.mat','lppAlcCells');
%load('lppFodCells.mat','lppFodCells');

EEG.srate=256;

timeBnds=[-.2 2];

outStruct={};
subSel=1;

mki=99;
trueLeng=mki-1;

for subSel=1:trueLeng
data=inputCells{subSel};
EEG.data=data;
[nbchan,pnts,trials]=size(data);
EEG.nbchan=nbchan;
EEG.trials=trials;
EEG.pnts=pnts;
EEG.epoch=timeBnds;  
EEG.xmin=min(min(data));
EEG.xmax=max(max(data));
EEG.reject=[];
EEG = pop_gratton(EEG, 35, 'chans', 1:EEG.nbchan);		% Correct blinks using channel 35 = VEOG
EEG = pop_gratton(EEG, 36, 'chans', 1:EEG.nbchan);

datMean=mean(EEG.data,3);
datStd=std(datMean');
artThres=2.5*datStd';

goodEpochs=[];

for ii=1:trials
test=squeeze(data(:,:,ii));

if max(abs(test))>artThres
goodEpochs(ii)=0;
else
    goodEpochs(ii)=1;
end

end

goodSpots=find(goodEpochs==1);

data2=data(:,:,[goodSpots]);
EEG.data=data2;
EEG.acceptedPercent=length(goodSpots)/trials;
EEG.rejected=trials*(1-EEG.acceptedPercent);
EEG.accepted=trials*(EEG.acceptedPercent);

outStruct{subSel}=EEG;

end