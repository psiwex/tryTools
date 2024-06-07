function EEG = lppParameters(EEG,timeOutputs,eegChan)
%% Calculate LPP parameters, like amplitude and magnitude. 
% By John LaRocco

neuCase=EEG.neuEpochs;
alcCase=EEG.alcEpochs;
fodCase=EEG.fodEpochs;

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

neuCase=mean(neuCase');
alcCase=mean(alcCase');
fodCase=mean(fodCase');
badCase=.5*(alcCase+fodCase);

badLpp=badCase(lBnd:uBnd);
neuLpp=neuCase(lBnd:uBnd);

ampBad=max(abs(badLpp));
magBad=sqrt(ampBad.*ampBad);
ampBadStd=std(badLpp);


ampNeu=max(abs(neuLpp));
magNeu=sqrt(ampNeu.*ampNeu);
ampNeuStd=max(abs(neuLpp));

EEG.ampBad=ampBad;
EEG.ampNeu=ampNeu;

EEG.magBad=magBad;
EEG.magNeu=magNeu;

EEG.ampBadStd=ampBadStd;
EEG.ampNeuStd=ampNeuStd;

EEG.neuCase=neuCase;
EEG.alcCase=alcCase;
EEG.fodCase=fodCase;
EEG.badCase=badCase;

end