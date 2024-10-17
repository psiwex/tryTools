%T = readtable('myfile.csv');
%T = readtable('myfile.csv','NumHeaderLines',3);

raw_bdf_loadpath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
% path to save raw datasets as .set/.fdt eeglab format
raw_dataset_savepath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
% path to save .set/.fdt datasets at intermediate processing steps: optional but strongly recommended
%   example 1: datasets saved after bad channel rejection can be used to determine which channels were removed and interpolated
%   example 2: datasets saved after artifact rejection can be used to determine which and how many epochs/trials/conditions were rejected 
%       Note: This is required to use SummaryScript.m to save details on bad channels/artifact rejection results
ongoing_dataset_savepath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
% path to save fully processed .set/.fdt files before ERP averaging
processed_dataset_savepath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
% path to save erpsets in erplab .erp format
erpset_savepath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
% save raw and processed eventlist path: 
raw_eventlist_savepath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
processed_eventlist_savepath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl';
% binlister path: see https://github.com/lucklab/erplab/blob/master/pop_functions/pop_binlister.m
binlister_loadpath = 'C:\Users\John\Documents\MATLAB\tryEeg\tryEtl\CueBinlister.txt';




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
lppCue={};



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
%timeOutputs1 = getTryTimestampsMeasures(fName1);
%timeOutputs2 = getTryTimestampsMeasures(fName2);



%% preproc
%rest
EEG = pop_biosig(efName1);
[EEG,params] = tryPreproc(EEG);
[ekgPeaks, params] = eeg_beats(EEG, params);
[EEG,ERP,erns] = cuePreproc(efName1,raw_dataset_savepath,ongoing_dataset_savepath,erpset_savepath,binlister_loadpath,channelLocationFile);
[bpm1, hr1, meanRR1, stdRR1, alphaPower1, alphaStd1,hrv1,hrvStd1] = calcBpm(EEG,ekgPeaks,eegChan);

hr=[meanRR1];
hrValues(ki,:)=hr;

bpm=[stdRR1];
bpmValues(ki,:)=bpm;

ap=[alphaPower1];
apValues(ki,:)=ap;

apstd=[alphaStd1];
apstdValues(ki,:)=apstd;

hrvValues(ki,:)=hrv1;

hrvstdValues(ki,:)=hrvStd1;
lppCue{mki}=EEG;
mki=mki+1;

catch
lppAmp=[0];
lppAmpValues1(ki,:)=lppAmp;

lppStdAmp=[0];
lppAmpStdValues1(ki,:)=lppStdAmp;

hr=[0];
hrValues(ki,:)=hr;

bpm=[0];
bpmValues(ki,:)=bpm;

ap=[0];
apValues(ki,:)=ap;

apstd=[0];
apstdValues(ki,:)=apstd;


hr=[0];
hrvValues(ki,:)=hr;

hrvstd=[0];
hrvstdValues(ki,:)=hrvstd;



end
end
tryBatch={};

restMeanTime=hrValues;
restStdTime=bpmValues;

restHrvMeanTime=hrvValues;
restHrvStdTime=hrvstdValues;


tryBatch{1}=restMeanTime;
tryBatch{2}=restStdTime;
tryBatch{3}=restHrvMeanTime;
tryBatch{4}=restHrvStdTime;
tryBatch{5}=apValues;
tryBatch{6}=apstdValues;
tryBatch{7}=subNames;

save('tryRestEEG.mat',"tryBatch");
save('tryLppCue.mat',"lppCue");

%[h1,p1]=ttest2(bpmValues(:,1),bpmValues(:,2));
%[h2,p2]=ttest2(hrValues(:,1),hrValues(:,2));
