clear;
clc;
close all;

%Focus on Session 1 ONLY:
%    Create LPP waveform from a pooling (average) of these sites: Fz,FC1,FC2,FCz,Cz
%    Create LPP waveform from a pooling (average) of these sites: Cz,CP1,CP2,Pz
%    Topographical scalp map depicting the 400–2000 ms average amplitude of the alcohol cue - neutral difference 
%    Topographical scalp map depicting the 400-2000 ms average amplitude of the food cue - neutral difference 

%Trauma (1) versus No Trauma (0)
%Lifetime depression/MDD (1) versus No depression/MDD (0)
%Lifetime PTSD (1) versus no lifetime PTSD (0)
%Current PTSD (1) versus no PTSD (0)

channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';
xx = readlocs(channelLocationFile);
%Fz,FC1,FC2,FCz,Cz
chans1=[23,33,35,34,45];
%chans1=[23,33,35,34,43];
%Cz,CP1,CP2,Pz
chans2=[45,55,57,67];
chans2=[43,44,45];



load('lppNeuCells0.mat','lppNeuCells0');
load('lppAlcCells0.mat','lppAlcCells0');
load('lppFodCells0.mat','lppFodCells0');

% [lppNeuStruct0] = tryFilterLpp(lppNeuCells0);
% [lppAlcStruct0] = tryFilterLpp(lppAlcCells0);
% [lppFodStruct0] = tryFilterLpp(lppFodCells0);

load('lppNeuStruct0.mat','lppNeuStruct0');
load('lppAlcStruct0.mat','lppAlcStruct0');
load('lppFodStruct0.mat','lppFodStruct0');

% 
% load('lppNeuCells1.mat','lppNeuCells');
% load('lppAlcCells1.mat','lppAlcCells');
% load('lppFodCells1.mat','lppFodCells');
% 
% [lppNeuStruct] = tryFilterLpp(lppNeuCells);
% [lppAlcStruct] = tryFilterLpp(lppAlcCells);
% [lppFodStruct] = tryFilterLpp(lppFodCells);

% load('lppNeuStruct1.mat','lppNeuStruct');
% load('lppAlcStruct1.mat','lppAlcStruct');
% load('lppFodStruct1.mat','lppFodStruct');
% 

EEG.srate=256;
chanLim=45;
timeBnds=[-.2 2];
mki=99;
trueLeng=mki-1;

%% first session
na=lppNeuStruct0{1};
aa=lppAlcStruct0{1};
da=lppFodStruct0{1};
lppNeu=na.data;
lppAlc=aa.data;
lppFod=da.data;  

neuAvg=squeeze(lppNeu);
alcAvg=squeeze(lppAlc);
fodAvg=squeeze(lppFod);

neuAvg=neuAvg(1:chanLim,:,:);
neuAvg=mean(neuAvg,3);

alcAvg=alcAvg(1:chanLim,:,:);
alcAvg=mean(alcAvg,3);

fodAvg=fodAvg(1:chanLim,:,:);
fodAvg=mean(fodAvg,3);

for ii=2:trueLeng
na=lppNeuStruct0{ii};
aa=lppAlcStruct0{ii};
da=lppFodStruct0{ii};
lppNeu=na.data;
lppAlc=aa.data;
lppFod=da.data;  
    
n=squeeze(lppNeu);
a=squeeze(lppAlc);
d=squeeze(lppFod);

n=n(1:chanLim,:,:);
n=mean(n,3);

a=a(1:chanLim,:,:);
a=mean(a,3);

d=d(1:chanLim,:,:);
d=mean(d,3);

neuAvg=neuAvg+n;
alcAvg=alcAvg+a;
fodAvg=fodAvg+d;

end

neuAvg=neuAvg/trueLeng;
alcAvg=alcAvg/trueLeng;
fodAvg=fodAvg/trueLeng;
[x,y]=size(neuAvg);
chanSel=13;
neuAvg0=neuAvg;
alcAvg0=alcAvg;
fodAvg0=fodAvg;
xplot=linspace(timeBnds(1),timeBnds(2),y);
chanSel=chans1;
chanSel=[12,13,14];
neuPlot=mean(neuAvg(chanSel,:));
alcPlot=mean(alcAvg(chanSel,:));
fodPlot=mean(fodAvg(chanSel,:));

figure;
plot(xplot,(neuPlot));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-15 15]);
hold on;
plot(xplot,(alcPlot),'r');
plot(xplot,(fodPlot),'k');
legend('Neutral','Alcohol','Food')
hold off;

EEG.data=neuAvg;
%EEG = pop_chanedit(EEG, 'lookup',channelLocationFile);


%timeArt=[8,2,7,6,5,1,4];
%x=xx(timeArt);
chanLocs=xx(1:chanLim);
splName='STUDY_headplot.spl';
% headplot('setup', chanLocs, splName)
% %close;
% figure; 
% headplot(neuAvg', splName)

headplot('setup', chanLocs, splName)
%close;
figure; 
headplot((alcPlot-neuPlot)', splName)

headplot('setup', chanLocs, splName)
%close;
figure; 
headplot((fodPlot-neuPlot)', splName)

