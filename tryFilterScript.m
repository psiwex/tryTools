clear;
clc;
close all;
load('lppNeuCells.mat','lppNeuCells');
load('lppAlcCells.mat','lppAlcCells');
load('lppFodCells.mat','lppFodCells');

EEG.srate=256;
chanLim=44;
timeBnds=[-.2 2];
mki=99;
trueLeng=mki-1;
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

neuAvg=squeeze(lppNeuCells{1});
alcAvg=squeeze(lppAlcCells{1});
fodAvg=squeeze(lppAlcCells{1});

neuAvg=neuAvg(1:chanLim,:,:);
neuAvg=mean(neuAvg,3);

alcAvg=alcAvg(1:chanLim,:,:);
alcAvg=mean(alcAvg,3);

fodAvg=fodAvg(1:chanLim,:,:);
fodAvg=mean(fodAvg,3);

for ii=2:trueLeng
n=squeeze(lppNeuCells{ii});
a=squeeze(lppAlcCells{ii});
d=squeeze(lppFodCells{ii});

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