%T = readtable('myfile.csv');
%T = readtable('myfile.csv','NumHeaderLines',3);
mainWindow=30;
esuf1='a_rest.bdf';
esuf2='b_rest.bdf';
eegChan=13;
plotChan='Pz';
fsuf1='a_CUE.bdf';
fsuf2='b_CUE.bdf';

suf1='a-Cue Reactivity EEG.log';
suf2='b-Cue Reactivity EEG.log';
lppNeuCells={};
lppAlcCells={};
lppFodCells={};

hrValues=[];
bpmValues=[];
apValues=[];
apstdValues=[];

lppAmpValues=[];
lppAmpStdValues=[];

hrValues1=[];
bpmValues1=[];
apValues1=[];
apstdValues1=[];

lppAmpValues1=[];
lppAmpStdValues1=[];

hrvValues=[];
hrvValues1=[];

hrvstdValues=[];
hrvstdValues1=[];

%https://www.mathworks.com/matlabcentral/fileexchange/73049-calculate-heart-rate-from-electrocardiogram-data
%https://github.com/VisLab/EEG-Beats
homeDir='C:\Users\John\Documents\MATLAB\tryEeg\CUE_REST\';
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

oldSR=1024;


list= dir([homeDir '\TRY*']);

T = struct2table(list);
subNames=table2cell(T(:,1));

ki=1;
subNum='TRY001';
mki=1;
for ki=1:length(subNames)
subNum=subNames{ki};

%% derive values

f11=strcat(homeDir,subNum);
f11=strcat(f11,'\');
f11=strcat(f11,subNum);
fName1=strcat(f11,suf1);
fName2=strcat(f11,suf2);

efName1=strcat(f11,esuf1);
efName2=strcat(f11,esuf2);

ffName1=strcat(f11,fsuf1);
ffName2=strcat(f11,fsuf2);

%% main loop

try
%% loading tables
timeOutputs1 = getTryTimestampsMeasures(fName1);
timeOutputs2 = getTryTimestampsMeasures(fName2);

%% preproc
%rest
EEG = pop_biosig(efName1);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm1, hr1, meanRR1, stdRR1, alphaPower1, alphaStd1,hrv1,hrvStd1] = calcBpm(EEG,ekgPeaks,eegChan);

EEG = pop_biosig(efName2);
%timeOutputs1 = tryEpochIndex(EEG,timeOutputs1);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm2, hr2, meanRR2, stdRR2, alphaPower2, alphaStd2,hrv2,hrvStd2] = calcBpm(EEG,ekgPeaks,eegChan);

hr=[meanRR1 meanRR2];
hrValues(ki,:)=hr;

bpm=[stdRR1 stdRR2];
bpmValues(ki,:)=bpm;

ap=[alphaPower1 alphaPower2];
apValues(ki,:)=ap;

apstd=[alphaStd1 alphaStd2];
apstdValues(ki,:)=apstd;


%CUE
EEG = pop_biosig(ffName1);
timeOutputs1 = tryEpochIndex(EEG,timeOutputs1);
[EEG,params] = tryPreproc(EEG);
EEG = tryEpocher(EEG,timeOutputs1);
[ekgPeaks, params] = eeg_beats(EEG, params);
eegChan = chanFinder(EEG,plotChan);
EEG = lppParameters(EEG,timeOutputs1,eegChan);
[bpm11, hr11, meanRR11, stdRR11, alphaPower11, alphaStd11,hrv11,hrvStd11] = calcBpm(EEG,ekgPeaks,eegChan);
ampBad1=EEG.ampBad;
ampStd1=EEG.ampBadStd;

EEG = pop_biosig(ffName2);
timeOutputs2 = tryEpochIndex(EEG,timeOutputs2);
[EEG,params] = tryPreproc(EEG);
EEG = tryEpocher(EEG,timeOutputs2);
[ekgPeaks, params] = eeg_beats(EEG, params);
eegChan = chanFinder(EEG,plotChan);
EEG = lppParameters(EEG,timeOutputs1,eegChan);
[bpm12, hr12, meanRR12, stdRR12, alphaPower12, alphaStd12,hrv12,hrvStd12] = calcBpm(EEG,ekgPeaks,eegChan);
ampBad2=EEG.ampBad;
ampStd2=EEG.ampBadStd;

lppAmp=[ampBad1 ampBad2];
lppAmpValues1(ki,:)=lppAmp;

lppStdAmp=[ampStd1 ampStd2];
lppAmpStdValues1(ki,:)=lppStdAmp;

hr=[meanRR11 meanRR12];
hrValues1(ki,:)=hr;

bpm=[stdRR11 stdRR12];
bpmValues1(ki,:)=bpm;

ap=[alphaPower11 alphaPower12];
apValues1(ki,:)=ap;

apstd=[alphaStd1 alphaStd2];
apstdValues1(ki,:)=apstd;

hrv=[hrv1 hrv2];
hrvValues(ki,:)=hrv;

hrvstd=[hrvStd1 hrvStd2];
hrvstdValues(ki,:)=hrvstd;

hrv=[hrv11 hrv12];
hrvValues1(ki,:)=hrv;

hrvstd=[hrvStd11 hrvStd12];
hrvstdValues1(ki,:)=hrvstd;

neuCase=EEG.neuEpochs;
alcCase=EEG.alcEpochs;
fodCase=EEG.fodEpochs;

lppNeuCells{mki}=neuCase;
lppAlcCells{mki}=alcCase;
lppFodCells{mki}=fodCase;

mki=mki+1;

catch
lppAmp=[0 0];
lppAmpValues1(ki,:)=lppAmp;

lppStdAmp=[0 0];
lppAmpStdValues1(ki,:)=lppStdAmp;

hr=[0 0];
hrValues(ki,:)=hr;

bpm=[0 0];
bpmValues(ki,:)=bpm;

ap=[0 0];
apValues(ki,:)=ap;

apstd=[0 0];
apstdValues(ki,:)=apstd;


hr=[0 0];
hrvValues(ki,:)=hr;

hrvstd=[0 0];
hrvstdValues(ki,:)=hrvstd;


bpm=[0 0];
bpmValues1(ki,:)=bpm;

ap=[0 0];
apValues1(ki,:)=ap;

apstd=[0 0];
apstdValues1(ki,:)=apstd;


hrv=[0 0];
hrvValues1(ki,:)=hrv;

hrvstd=[0 0];
hrvstdValues1(ki,:)=hrvstd;



hrv=[0 0];
hrvValues1(ki,:)=hrv;

hrvstd=[0 0];
hrvstdValues1(ki,:)=hrvstd;




end
end
tryBatch={};

restMeanTime=hrValues;
restStdTime=bpmValues;

cueMeanTime=hrValues1;
cueStdTime=bpmValues1;

restHrvMeanTime=hrvValues;
restHrvStdTime=hrvstdValues;

cueHrvTime=hrvValues1;
cueHrvStdTime=hrvstdValues1;


tryBatch{1}=restMeanTime;
tryBatch{2}=restStdTime;
tryBatch{3}=cueMeanTime;
tryBatch{4}=cueStdTime;

tryBatch{11}=apValues;
tryBatch{12}=apstdValues;
tryBatch{13}=apValues1;
tryBatch{14}=apstdValues1;

tryBatch{31}=restHrvMeanTime;
tryBatch{32}=restHrvStdTime;
tryBatch{33}=cueHrvTime;
tryBatch{34}=cueHrvStdTime;

tryBatch{51}=lppAmpValues1;
tryBatch{52}=lppAmpStdValues1;


%save('tryCompareRestCue.mat',"tryBatch");

%[h1,p1]=ttest2(bpmValues(:,1),bpmValues(:,2));
%[h2,p2]=ttest2(hrValues(:,1),hrValues(:,2));

save('lppNeuCells.mat','lppNeuCells');
save('lppAlcCells.mat','lppAlcCells');
save('lppFodCells.mat','lppFodCells');
