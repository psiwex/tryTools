function eegChan = chanFinder(EEG,plotChan)
%% Find the number of an EEG channel. 
% By John LaRocco

las=EEG.chanlocs;
%labs=las.labels;
chanValues={};
myfield=squeeze(struct2cell(las));
for i=1:length(las)
chanValues{i}=myfield{1,i};
end

idx = strfind(chanValues,plotChan);

for iss=1:length(las)
y1=idx{iss};
    if y1==1
eegChan=iss;
    end

end