clear;
clc;
close all;
load('lppNeuCells.mat','lppNeuCells');
load('lppAlcCells.mat','lppAlcCells');
load('lppFodCells.mat','lppFodCells');
% 
% [lppNeuStruct] = tryFilterLpp(lppNeuCells);
% [lppAlcStruct] = tryFilterLpp(lppAlcCells);
% [lppFodStruct] = tryFilterLpp(lppFodCells);

load('lppNeuStruct.mat','lppNeuStruct');
load('lppAlcStruct.mat','lppAlcStruct');
load('lppFodStruct.mat','lppFodStruct');


EEG.srate=256;
chanLim=44;
timeBnds=[-.2 2];
mki=99;
trueLeng=mki-1;
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';


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
ylim([-25 25]);

figure;
plot(xplot,(alcAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-25 25]);

figure;
plot(xplot,(fodAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-25 25]);


figure;
plot(xplot,(neuAvg(chanSel,:)));
xlabel('Time (s)')
ylabel('Amplitude (uV)')
xlim([timeBnds]);
ylim([-25 25]);
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
