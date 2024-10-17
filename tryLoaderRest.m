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
lppFixCells={};

hrValues=[];
bpmValues=[];
apValues=[];
apstdValues=[];

lppAmpValues=[];
lppAmpStdValues=[];

lppAmpNeuValues=[];
lppAmpNeuStdValues=[];

lppAmpAlcValues=[];
lppAmpAlcStdValues=[];

lppAmpFodValues=[];
lppAmpFodStdValues=[];

lppAmpFixValues=[];
lppAmpFixStdValues=[];

hrValues1=[];
bpmValues1=[];
apValues1=[];
apstdValues1=[];

lppAmpValues1=[];
lppAmpStdValues1=[];

lppAmpNeuValues1=[];
lppAmpNeuStdValues1=[];

lppAmpAlcValues1=[];
lppAmpAlcStdValues1=[];

lppAmpFodValues1=[];
lppAmpFodStdValues1=[];

lppAmpFixValues1=[];
lppAmpFixStdValues1=[];

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

mkh=1;
lppNeuCells0={};
lppAlcCells0={};
lppFodCells0={};
lppFixCells0={};




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

ampNeu1=EEG.ampNeu;
ampNeuStd1=EEG.ampNeuStd;

ampAlc1=EEG.ampAlc;
ampAlcStd1=EEG.ampAlcStd;

ampFod1=EEG.ampFod;
ampFodStd1=EEG.ampFodStd;

ampFix1=EEG.ampFix;
ampFixStd1=EEG.ampFixStd;

% first cue?
neuCase=EEG.neuEpochs;
alcCase=EEG.alcEpochs;
fodCase=EEG.fodEpochs;
fixCase=EEG.fixEpochs;

lppNeuCells0{mkh}=neuCase;
lppAlcCells0{mkh}=alcCase;
lppFodCells0{mkh}=fodCase;
lppFixCells0{mkh}=fixCase;

mkh=mkh+1;

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

ampNeu2=EEG.ampNeu;
ampNeuStd2=EEG.ampNeuStd;

ampAlc2=EEG.ampAlc;
ampAlcStd2=EEG.ampAlcStd;

ampFod2=EEG.ampFod;
ampFodStd2=EEG.ampFodStd;

ampFix2=EEG.ampFix;
ampFixStd2=EEG.ampFixStd;

lppAmpNewNeuValues=[ampNeu1 ampNeu2];
lppAmpNeuValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampNeuStd1 ampNeuStd2];
lppAmpNeuStdValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampAlc1 ampAlc2];
lppAmpAlcValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampAlcStd1 ampAlcStd2];
lppAmpAlcStdValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampFod1 ampFod2];
lppAmpFodValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampFodStd1 ampFodStd2];
lppAmpFodStdValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampFix1 ampFix2];
lppAmpFixValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[ampFixStd1 ampFixStd2];
lppAmpFixStdValues(ki,:)=lppAmpNewNeuValues;

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

% second cue! 
neuCase=EEG.neuEpochs;
alcCase=EEG.alcEpochs;
fodCase=EEG.fodEpochs;
fixCase=EEG.fixEpochs;

lppNeuCells{mki}=neuCase;
lppAlcCells{mki}=alcCase;
lppFodCells{mki}=fodCase;
lppFixCells{mki}=fixCase;

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

lppAmpNewNeuValues=[0 0];
lppAmpNeuValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpNeuStdValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpAlcValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpAlcStdValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpFodValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpFodStdValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpFixValues(ki,:)=lppAmpNewNeuValues;

lppAmpNewNeuValues=[0 0];
lppAmpFixStdValues(ki,:)=lppAmpNewNeuValues;


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

tryBatch{40}=lppAmpNeuValues;
tryBatch{41}=lppAmpNeuStdValues;

tryBatch{42}=lppAmpAlcValues;
tryBatch{43}=lppAmpAlcStdValues;

tryBatch{44}=lppAmpFodValues;
tryBatch{45}=lppAmpFodStdValues;

tryBatch{46}=lppAmpFixValues;
tryBatch{47}=lppAmpFixStdValues;

tryBatch{51}=lppAmpValues1;
tryBatch{52}=lppAmpStdValues1;


save('try2CompareRestCue1.mat',"tryBatch");

%[h1,p1]=ttest2(bpmValues(:,1),bpmValues(:,2));
%[h2,p2]=ttest2(hrValues(:,1),hrValues(:,2));

save('lpp2NeuCells0.mat','lppNeuCells0');
save('lpp2AlcCells0.mat','lppAlcCells0');
save('lpp2FodCells0.mat','lppFodCells0');
save('lpp2FixCells0.mat','lppFixCells0');

save('lpp2NeuCells1.mat','lppNeuCells');
save('lpp2AlcCells1.mat','lppAlcCells');
save('lpp2FodCells1.mat','lppFodCells');
save('lpp2FixCells1.mat','lppFixCells');