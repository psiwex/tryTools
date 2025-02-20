%% trajectoryTracking
T0 = readtable('TRY_lcmm_drinks_class_4groups.csv');
nameListLMS=table2cell(T0(:,3));
classLms=table2cell(T0(:,2));
classLms=cell2mat(classLms);
classLms=prototype_cleanup(classLms);
trajValue=classLms-1;

%[mainIndex22,mainDex1]=tableIndexer(mainDex,nameListLMS);

%% psychosoc
T1 = readtable('tryPsycho.xlsx');
xx=T1(:,3:end);
T1b=table2cell(xx);
[entries,varspace]=size(T1b);
T1c=str2double(T1b);

scanVal=T1(:,3);
screen=table2cell(scanVal);
screen=cell2mat(screen);
idx = find(~isnan(screen));
T1d=T1c(idx,:);

T1cc=T1b(idx,:);
T1cd=T1cc(:,[1:19 103]);
%T1d=cell2mat(T1cd);
%classLms=prototype_cleanup(classLms);

nameListPsychRaw=table2cell(T1(:,1));
nameListPsych=nameListPsychRaw(idx);





[mainIndex1,mainDex1]=tableIndexer(nameListPsych,nameListLMS);
%tryPsoc=T1d(mainIndex1,:);
totalSubs=unique(mainDex1);

outMat=zeros([length(totalSubs),varspace]);

for iii=1:length(totalSubs)
testSub=totalSubs{iii};
ind=find(ismember(nameListPsychRaw,testSub));
zipps=zeros([length(ind),varspace]);
for iiii=1:length(ind)
circleInd=ind(iiii);
for iv=1:varspace
variableCircle=T1b(circleInd,iv);
variableCircle=variableCircle{1};
if sum(isdoublep(variableCircle))==0
variableCircle=0;
end
zipps(iiii,iv)=variableCircle;


end

end
zipps=prototype_cleanup(zipps);
zipp1=sum(zipps);
outMat(iii,:)=zipp1;
end
tryPsoc=outMat;
%% demographics
T2 = readtable('tryDemographics.xlsx');
nameListDemo=table2cell(T2(:,1));
xy=T2(:,2:end);
T2b=table2cell(xy);
T2c=cell2mat(T2b);
[mainIndex2,mainDex2]=tableIndexer(nameListDemo,mainDex1);
tryDems=T2c(mainIndex2,:);

%% integrating table


pSoc=[tryDems tryPsoc];

%% export
% csvwrite('psocMetrics.csv', pSoc);
% csvwrite('pzocMetrics.csv', zscore(pSoc));
% csvwrite('psocLabels.csv', trajValue);

%features:  0   9  18  40  41  42  43  50  52  59  95 101 107, 24  27  31  34  50  67  86  89 107
x1=[  0   9  18  40  41  42  43  50  52  59  95 101 107  0   9  18  40  41  42  43  50  52  59  95 101 107];
x2=unique(x1);

% 0	9	18	40	41	42	43	50	52	59	95	101	107