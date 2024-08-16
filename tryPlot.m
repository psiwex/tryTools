clear;
clc;
close all;
load('lppNeuCells0.mat','lppNeuCells0');
load('lppAlcCells0.mat','lppAlcCells0');
load('lppFodCells0.mat','lppFodCells0');

% [lppNeuStruct0] = tryFilterLpp(lppNeuCells0);
% [lppAlcStruct0] = tryFilterLpp(lppAlcCells0);
% [lppFodStruct0] = tryFilterLpp(lppFodCells0);

load('lppNeuStruct0.mat','lppNeuStruct0');
load('lppAlcStruct0.mat','lppAlcStruct0');
load('lppFodStruct0.mat','lppFodStruct0');


load('lppNeuCells1.mat','lppNeuCells');
load('lppAlcCells1.mat','lppAlcCells');
load('lppFodCells1.mat','lppFodCells');
% 
% [lppNeuStruct] = tryFilterLpp(lppNeuCells);
% [lppAlcStruct] = tryFilterLpp(lppAlcCells);
% [lppFodStruct] = tryFilterLpp(lppFodCells);

load('lppNeuStruct1.mat','lppNeuStruct');
load('lppAlcStruct1.mat','lppAlcStruct');
load('lppFodStruct1.mat','lppFodStruct');


EEG.srate=256;
chanLim=44;
timeBnds=[-.2 2];
mki=99;
trueLeng=mki-1;
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

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

figure;
plot(xplot,(neuAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);

figure;
plot(xplot,(alcAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);

figure;
plot(xplot,(fodAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);


figure;
plot(xplot,(neuAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);
hold on;
plot(xplot,(alcAvg(chanSel,:)),'r');
plot(xplot,(fodAvg(chanSel,:)),'k');
legend('Neutral','Alcohol','Food')
hold off;

EEG.data=neuAvg;
%EEG = pop_chanedit(EEG, 'lookup',channelLocationFile);

xx = readlocs(channelLocationFile);
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
headplot((alcAvg-neuAvg)', splName)

headplot('setup', chanLocs, splName)
%close;
figure; 
headplot((fodAvg-neuAvg)', splName)



%% second session
na=lppNeuStruct{1};
aa=lppAlcStruct{1};
da=lppFodStruct{1};
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
na=lppNeuStruct{ii};
aa=lppAlcStruct{ii};
da=lppFodStruct{ii};
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

xplot=linspace(timeBnds(1),timeBnds(2),y);

figure;
plot(xplot,(neuAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);

figure;
plot(xplot,(alcAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);

figure;
plot(xplot,(fodAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);


figure;
plot(xplot,(neuAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-2 15]);
hold on;
plot(xplot,(alcAvg(chanSel,:)),'r');
plot(xplot,(fodAvg(chanSel,:)),'k');
legend('Neutral','Alcohol','Food')
hold off;

EEG.data=neuAvg;
%EEG = pop_chanedit(EEG, 'lookup',channelLocationFile);

xx = readlocs(channelLocationFile);
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
headplot((alcAvg-neuAvg)', splName)

headplot('setup', chanLocs, splName)
%close;
figure; 
headplot((fodAvg-neuAvg)', splName)

%Focus on Session 1 ONLY:
%    Create LPP waveform from a pooling (average) of these sites: Fz,FC1,FC2,FCz,Cz
%    Create LPP waveform from a pooling (average) of these sites: Cz,CP1,CP2,Pz
%    Topographical scalp map depicting the 400–2000 ms average amplitude of the alcohol cue - neutral difference 
%    Topographical scalp map depicting the 400-2000 ms average amplitude of the food cue - neutral difference 

% %% comparisons
% headplot('setup', chanLocs, splName)
% %close;
% figure; 
% headplot((neuAvg-neuAvg0)', splName)
% 
% headplot('setup', chanLocs, splName)
% %close;
% figure; 
% headplot((alcAvg-alcAvg0)', splName)
% 
% headplot('setup', chanLocs, splName)
% %close;
% figure; 
% headplot((fodAvg-fodAvg0)', splName)


