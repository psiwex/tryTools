function eegEpochs = tryEpochLoop(EEG,timeOutputs,inputInd)
%% Iteratively stack epochs for a category. 
% By John LaRocco

newSrate=EEG.srate;
eegEpochs=[];

baselineWindow=timeOutputs.baselineWindow;
endWindow=timeOutputs.endWindow;
totalWindow=timeOutputs.totalWindow;

newBaselineWindow=floor(newSrate*baselineWindow);
newEndWindow=floor(newSrate*endWindow);
newTotalWindow=floor(newSrate*totalWindow);

eegData=EEG.data;
trueLeng=size(eegData,2);
inputInd(any(inputInd>trueLeng))=[];
for ii=1:length(inputInd)
indExplore=inputInd(ii);
lowBnd=abs(ceil(indExplore-newBaselineWindow));
if lowBnd > trueLeng
    break
end
uprBnd=abs(ceil(indExplore+newEndWindow));
if uprBnd > trueLeng
    break
end
x=eegData(:,lowBnd:uprBnd);
xBase=mean(x(:,1:newBaselineWindow)');
x=x-xBase';
eegEpochs(:,:,ii)=x;

end



end