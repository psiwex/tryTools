%T = readtable('myfile.csv');
%T = readtable('myfile.csv','NumHeaderLines',3);
mainWindow=30;
esuf1='a_rest.bdf';
esuf2='b_rest.bdf';


fsuf1='a_CUE.bdf';
fsuf2='b_CUE.bdf';

suf1='a-Cue Reactivity EEG.log';
suf2='b-Cue Reactivity EEG.log';


%% preproc
timeOutputs = getTryTimestampsMeasures(fName1);


duration=timeOutputs.duration;
timestamp=timeOutputs.timestamp;
labels=timeOutputs.types;
% convert to seconds
for jj=1:length(timestamp)
tur0=timestamp(jj);
    tur(jj)=round(EEG.srate*tur0/10000);

dur0=duration(jj);
    dur(jj)=round(EEG.srate*dur0/10000);


end

%tur=tur+duration(1);
tur(~any(tur>length(EEG.data)))=[];
dur(~any(tur>length(EEG.data)))=[];
pat1='Neu';
pat2='Alc';
pat3='Food';

neuLocs=[];
alcLocs=[];
fodLocs=[];

for jj=1:(length(timestamp)-1)
str0=labels{jj};
TF1 = startsWith(str0,pat1,'IgnoreCase',true);
TF2 = startsWith(str0,pat2,'IgnoreCase',true);
TF3 = startsWith(str0,pat3,'IgnoreCase',true);
if TF1==1
neuLocs=[neuLocs; jj];
end

if TF2==1
alcLocs=[alcLocs; jj];
end

if TF3==1
fodLocs=[fodLocs; jj];
end

end
neuLocs=sort(neuLocs,'ascend');
alcLocs=sort(alcLocs,'ascend');
fodLocs=sort(fodLocs,'ascend');

neuLocs(~any(neuLocs>length(EEG.data)))=[];

neuInd=ceil(tur(neuLocs));
neuInd(~any(neuInd>length(EEG.data)))=[];

neuDur=ceil(dur(neuLocs));
neuDur2=ceil(dur((neuLocs+1)));
tDur=neuDur+neuDur2;
tDur=tDur(1:length(neuInd));

beats=[];
peaks=ekgPeaks.peakFrames;

peakScaled=(peaks/EEG.srate);


for ij=1:length(tDur)

p1=peaks(peaks>neuInd(ij) & peaks<tDur(ij));

p1=find((peaks >= neuInd(ij)) & (peaks <= tDur(ij)));
beats=[beats; p1];

end
