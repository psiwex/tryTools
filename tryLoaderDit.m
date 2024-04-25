%T = readtable('myfile.csv');
%T = readtable('myfile.csv','NumHeaderLines',3);

%https://www.mathworks.com/matlabcentral/fileexchange/73049-calculate-heart-rate-from-electrocardiogram-data

homeDir='C:\Users\John\Documents\MATLAB\tryEeg\CUE_REST\';
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

subNum='TRY011';
%% derive values
suf1='a-Cue Reactivity EEG.log';
suf2='b-Cue Reactivity EEG.log';
f11=strcat(homeDir,subNum);
f11=strcat(f11,'\');
f11=strcat(f11,subNum);
fName1=strcat(f11,suf1);
fName2=strcat(f11,suf2);
srate=1024;
esuf1='a_rest.bdf';
esuf2='b_rest.bdf';

efName1=strcat(f11,esuf1);
efName2=strcat(f11,esuf2);

%% loading tables
T = readtable(fName1);
types1=table2cell(T(:,4));
timestamp1=table2cell(T(:,5));
duration1=table2cell(T(:,8));

T2 = readtable(fName2);
types2=table2cell(T2(:,4));
timestamp2=table2cell(T2(:,5));
duration2=table2cell(T2(:,8));

%% preproc

EEG = pop_biosig(efName1);

EEG = pop_resample(EEG, 256, 0.8, 0.4);

x=EEG.data;
ekg=x(35:36,1:EEG.srate);
ecg=mean(ekg);
ecg=ekg(1,:)-ekg(2,:);
%ecg=smooth(ecg);
%ecg=ecg/max(abs(ecg));

ecg = detrend(ecg,5);
ismax = islocalmax(ecg,'MinProminence',0.99);
maxIndices = find(ismax);
msPerBeat = mean(diff(maxIndices));
heartRate = 60*(EEG.srate/msPerBeat)

hr2=length(maxIndices)/(length(ecg)/EEG.srate)

hr=60*hr2;

fb = dwtfilterbank('Wavelet','sym4','SignalLength',numel(ecg),'Level',3);
psi = wavelets(fb);

wt = modwt(ecg,5);
wtrec = zeros(size(wt));
wtrec(4:5,:) = wt(4:5,:);
y = imodwt(wtrec,'sym4');
y = abs(y).^2;
[qrspeaks,locs] = findpeaks(y,tm,'MinPeakHeight',0.35,...
    'MinPeakDistance',0.150);
