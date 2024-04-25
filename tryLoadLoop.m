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

%for ki=1:length(subNames)
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
[bpm1,hr1] = calcBpm(EEG,ekgPeaks);

EEG = pop_biosig(efName2);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm2,hr2] = calcBpm(EEG,ekgPeaks);

hr=[hr1 hr2];
hrValues(ki,:)=hr;

bpm=[bpm1 bpm2];
bpmValues(ki,:)=bpm;

%CUE
EEG = pop_biosig(ffName1);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[bpm0,hr0] = calcBpm(EEG,ekgPeaks);


catch

hr=[0 0];
hrValues(ki,:)=hr;

bpm=[0 0];
bpmValues(ki,:)=bpm;
end
%end
tryBatch={};

tryBatch{1}=hrValues;
tryBatch{2}=bpmValues;
%save('tryHrRest.mat',"tryBatch");

%[h1,p1]=ttest2(bpmValues(:,1),bpmValues(:,2));
%[h2,p2]=ttest2(hrValues(:,1),hrValues(:,2));

