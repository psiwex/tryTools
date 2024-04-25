function timeOutputs = getTryTimestampsMeasures(fName)
%% Output time values from log files. 
% By John LaRocco, 19 April 2024
% Parameters:
%    fName          A string of the file name to load from '.log' format
%    timeOutputs    Output struct containing event types (timeOutputs.types),
%    timestamps (timeOutputs.timestamp), and durations (timeOutputs.duration)

%%

T = readtable(fName);
types1=table2cell(T(:,4));
timestamp1=table2cell(T(:,5));
duration1=table2cell(T(:,8));
timestamp1=celltomat(timestamp1);

timestamp1(~any(~isnan(timestamp1), 2),:)=[];
duration1=celltomat(duration1);

timeOutputs = struct();
timeOutputs.types=types1;
timeOutputs.timestamp=timestamp1;
timeOutputs.duration=duration1;


end
