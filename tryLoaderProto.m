%T = readtable('myfile.csv');
%T = readtable('myfile.csv','NumHeaderLines',3);
mainWindow=30;
esuf1='a_rest.bdf';
esuf2='b_rest.bdf';


fsuf1='a_CUE.bdf';
fsuf2='b_CUE.bdf';

suf1='a-Cue Reactivity EEG.log';
suf2='b-Cue Reactivity EEG.log';

hrValues=[];
bpmValues=[];

hrValues1=[];
bpmValues1=[];

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
[bpm1, hr1, meanRR1, stdRR1] = calcBpm(EEG,ekgPeaks);

EEG = pop_biosig(efName2);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm2, hr2, meanRR2, stdRR2] = calcBpm(EEG,ekgPeaks);

hr=[meanRR1 meanRR2];
hrValues(ki,:)=hr;

bpm=[stdRR1 stdRR2];
bpmValues(ki,:)=bpm;

%CUE
EEG = pop_biosig(ffName1);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm11, hr11, meanRR11, stdRR11] = calcBpm(EEG,ekgPeaks);

EEG = pop_biosig(ffName2);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm12, hr12, meanRR12, stdRR12] = calcBpm(EEG,ekgPeaks);

hr=[meanRR11 meanRR12];
hrValues1(ki,:)=hr;

bpm=[stdRR11 stdRR12];
bpmValues1(ki,:)=bpm;

catch

hr=[0 0];
hrValues(ki,:)=hr;

bpm=[0 0];
bpmValues(ki,:)=bpm;

hr=[0 0];
hrValues1(ki,:)=hr;

bpm=[0 0];
bpmValues1(ki,:)=bpm;
end
end
tryBatch={};

restMeanTime=hrValues;
restStdTime=bpmValues;

cueMeanTime=hrValues1;
cueStdTime=bpmValues1;

tryBatch{1}=restMeanTime;
tryBatch{2}=restStdTime;
tryBatch{3}=cueMeanTime;
tryBatch{4}=cueStdTime;
save('tryCompareRestCue.mat',"tryBatch");

%[h1,p1]=ttest2(bpmValues(:,1),bpmValues(:,2));
%[h2,p2]=ttest2(hrValues(:,1),hrValues(:,2));

