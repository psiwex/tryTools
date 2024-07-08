function EEG = tryEpocher(EEG,timeOutputs)
%% Epoch neutral, food, and alcohol EEG. 
% By John LaRocco

neuInd=timeOutputs.neuInd;
alcInd=timeOutputs.alcInd;
fodInd=timeOutputs.fodInd;
fixInd=timeOutputs.fixInd;

neuEpochs = tryEpochLoop(EEG,timeOutputs,neuInd);
alcEpochs = tryEpochLoop(EEG,timeOutputs,alcInd);
fodEpochs = tryEpochLoop(EEG,timeOutputs,fodInd);
fixEpochs = tryEpochLoop(EEG,timeOutputs,fixInd);
EEG.neuEpochs=neuEpochs;
EEG.alcEpochs=alcEpochs;
EEG.fodEpochs=fodEpochs;
EEG.fixEpochs=fixEpochs;

end
