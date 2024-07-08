function EEG = lppParameters(EEG,timeOutputs,eegChan)
%% Calculate LPP parameters, like amplitude and magnitude. 
% By John LaRocco

neuCase=EEG.neuEpochs;
alcCase=EEG.alcEpochs;
fodCase=EEG.fodEpochs;
fixCase=EEG.fixEpochs;

baselineWindow=timeOutputs.baselineWindow;
sRate=EEG.srate;
lBnd=.5;
uBnd=.75;
lBnd=baselineWindow+lBnd;
uBnd=baselineWindow+uBnd;
lBnd=round(lBnd*sRate);
uBnd=round(uBnd*sRate);

neuCase=squeeze(neuCase(eegChan,:,:));
alcCase=squeeze(alcCase(eegChan,:,:));
fodCase=squeeze(fodCase(eegChan,:,:));
fixCase=squeeze(fixCase(eegChan,:,:));

neuCase=mean(neuCase');
alcCase=mean(alcCase');
fodCase=mean(fodCase');
fixCase=mean(fixCase');
badCase=.5*(alcCase+fodCase);

badLpp=badCase(lBnd:uBnd);
neuLpp=neuCase(lBnd:uBnd);
alcLpp=alcCase(lBnd:uBnd);
fodLpp=fodCase(lBnd:uBnd);
fixLpp=fixCase(lBnd:uBnd);

ampBad=max(abs(badLpp));
magBad=sqrt(ampBad.*ampBad);
ampBadStd=std(badLpp);

ampNeu=max(abs(neuLpp));
magNeu=sqrt(ampNeu.*ampNeu);
ampNeuStd=max(abs(neuLpp));

ampAlc=max(abs(alcLpp));
magAlc=sqrt(ampAlc.*ampAlc);
ampAlcStd=std(alcLpp);

ampFod=max(abs(fodLpp));
magFod=sqrt(ampFod.*ampFod);
ampFodStd=std(fodLpp);

ampFix=max(abs(fixLpp));
magFix=sqrt(ampFix.*ampFix);
ampFixStd=std(fixLpp);


EEG.ampBad=ampBad;
EEG.ampNeu=ampNeu;
EEG.ampAlc=ampAlc;
EEG.ampFod=ampFod;
EEG.ampFix=ampFix;

EEG.magBad=magBad;
EEG.magNeu=magNeu;
EEG.magAlc=magAlc;
EEG.magFod=magFod;
EEG.magFix=magFix;

EEG.ampBadStd=ampBadStd;
EEG.ampNeuStd=ampNeuStd;
EEG.ampAlcStd=ampAlcStd;
EEG.ampFodStd=ampFodStd;
EEG.ampFixStd=ampFixStd;

EEG.neuCase=neuCase;
EEG.alcCase=alcCase;
EEG.fodCase=fodCase;
EEG.fixCase=fixCase;
EEG.badCase=badCase;

end