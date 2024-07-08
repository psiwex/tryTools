function timeOutputs = tryEpochIndex(EEG,timeOutputs)
%% Calculate epoch indices for neutral, food, and alcohol in EEG file. 
% By John LaRocco
%T = readtable('myfile.csv');
%T = readtable('myfile.csv','NumHeaderLines',3);


%https://www.mathworks.com/matlabcentral/fileexchange/73049-calculate-heart-rate-from-electrocardiogram-data
%https://github.com/VisLab/EEG-Beats


%newSrate=256;
newSrate=timeOutputs.newSrate;
%% preproc

nSrate=EEG.srate;

dur=[];
tur=[];

urdur=[];
urtur=[];

duration=timeOutputs.duration;
timestamp=timeOutputs.timestamp;
labels=timeOutputs.types;
% convert to seconds
for jj=1:length(timestamp)
tur0=timestamp(jj);
    tur(jj)=round(EEG.srate*tur0/10000);
urtur(jj)=(tur0/10000);
dur0=duration(jj);
    dur(jj)=round(EEG.srate*dur0/10000);
urdur(jj)=(dur0/10000);

end

%tur=tur+duration(1);
tur(~any(tur>length(EEG.data)))=[];
dur(~any(tur>length(EEG.data)))=[];
pat1='Neu';
pat2='Alc';
pat3='Food';
pat4='Fix';

neuLocs=[];
alcLocs=[];
fodLocs=[];
fixLocs=[];

neuUrLocs=[];
alcUrLocs=[];
fodUrLocs=[];
fixUrLocs=[];


for jj=1:(length(timestamp)-1)
str0=labels{jj};
TF1 = startsWith(str0,pat1,'IgnoreCase',true);
TF2 = startsWith(str0,pat2,'IgnoreCase',true);
TF3 = startsWith(str0,pat3,'IgnoreCase',true);
TF4 = startsWith(str0,pat4,'IgnoreCase',true);

if TF1==1
neuLocs=[neuLocs; jj];
neuUrLocs=[neuUrLocs; jj];
end

if TF2==1
alcLocs=[alcLocs; jj];
alcUrLocs=[alcUrLocs; jj];
end

if TF3==1
fodLocs=[fodLocs; jj];
fodUrLocs=[fodUrLocs; jj];
end

if TF4==1
fixLocs=[fixLocs; jj];
fixUrLocs=[fixUrLocs; jj];
end


end
neuLocs=sort(neuLocs,'ascend');
alcLocs=sort(alcLocs,'ascend');
fodLocs=sort(fodLocs,'ascend');
fixLocs=sort(fixLocs,'ascend');

neuUrLocs=sort(neuUrLocs,'ascend');
alcUrLocs=sort(alcUrLocs,'ascend');
fodUrLocs=sort(fodUrLocs,'ascend');
fixUrLocs=sort(fixUrLocs,'ascend');

neuUrInd=(urtur(neuUrLocs));
alcUrInd=(urtur(alcUrLocs));
fodUrInd=(urtur(fodUrLocs));
fixUrInd=(urtur(fixUrLocs));



[~,eegLength]=size(EEG.data);
trueLeng=(eegLength./EEG.srate);
newLeng=newSrate.*trueLeng;
newLeng=floor(newLeng);


neuInd=round(newSrate.*neuUrInd);
alcInd=round(newSrate.*alcUrInd);
fodInd=round(newSrate.*fodUrInd);
fixInd=round(newSrate.*fixUrInd);

neuInd(~any(neuInd>newLeng))=[];
alcInd(~any(alcInd>newLeng))=[];
fodInd(~any(fodInd>newLeng))=[];
fixInd(~any(fixInd>newLeng))=[];

timeOutputs.neuInd=neuInd;
timeOutputs.alcInd=alcInd;
timeOutputs.fodInd=fodInd;
timeOutputs.fixInd=fixInd;



end
