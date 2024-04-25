function [EEG,params] = tryPreproc(EEG)
%% Preprocess EEG data for TRY. Requires EEGLAB and EEGBEATS
% By John LaRocco, 19 April 2024
% Parameters:
%    EEG          EEGLAB struct with data to preprocess. Output after
%                 processing. 
%    params    Output struct containing metadata for EEGBEATS

%%
EEG = pop_resample(EEG, 256, 0.8, 0.4);
x=EEG.data;
ekg=x(35:36,:);
ecg=mean(ekg);

x(35,:)=ecg;
EEG.data=x;
	EEG = pop_basicfilter(EEG, 1:EEG.nbchan,...
		'Boundary', 'boundary',...	% Boundary events
		'Cutoff', [ 0.1 30],...		% High and low cutoff
		'Design', 'butter',...		% IIR Butterworth filter
		'Filter', 'bandpass',...	% Bandpass filter type
		'Order',  2,...				% Filter order
		'RemoveDC', 'on' );			% Remove DC offset

figureDir='.';
params = struct();
params.figureVisibility = 'off';
params.figureClose = true;
params.ekgChannelLabel='EKG1';
params.srate=EEG.srate;
params.rrsAroundOutlierAmpPeaks = 1;
params.rrOutlierNeighborhood = 5;
params.removeOutOfRangeRRs = true;
params.filename=['fromEEG_'];


end