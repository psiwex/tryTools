function EEG = tryEpocher(EEG,timeOutputs)
%% Epoch neutral, food, and alcohol EEG. 
% By John LaRocco

neuInd=timeOutputs.neuInd;
alcInd=timeOutputs.alcInd;
fodInd=timeOutputs.fodInd;

neuEpochs = tryEpochLoop(EEG,timeOutputs,neuInd);
alcEpochs = tryEpochLoop(EEG,timeOutputs,alcInd);
fodEpochs = tryEpochLoop(EEG,timeOutputs,fodInd);
EEG.neuEpochs=neuEpochs;
EEG.alcEpochs=alcEpochs;
EEG.fodEpochs=fodEpochs;


end
