%https://www.mathworks.com/help/stats/repeatedmeasuresmodel.ranova.html
homeDir='C:\Users\John\Documents\MATLAB\tryEeg\CUE_REST\';
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

list= dir([homeDir '\TRY*']);

T = struct2table(list);
subNames=table2cell(T(:,1));

ki=1;
subNum='TRY001';
subTxt={};


T1 = readtable('tryDemo.xlsx');
nameList=table2cell(T1(:,1));
ageList=table2cell(T1(:,2));
genderList=table2cell(T1(:,3));
groupList=table2cell(T1(:,6));

leng=length(ageList);
subInd=1;
mainDex={};
mainIndex=[];

for ki=1:length(subNames)
subNum=subNames{ki};


if any(strcmp(nameList,subNum))
% Do Something
mainDex{subInd}=subNum;

mainIndex(ki)=find(strcmp(nameList,subNum));
subInd=subInd+1;

else
% Do Something else

end

end


% vector for gender, age, exp/control group
mainGen=cell2mat(genderList);
mainGen=mainGen(mainIndex);
mainAge=cell2mat(ageList);
mainAge=mainAge(mainIndex);
mainGroup=cell2mat(groupList);
mainGroup=mainGroup(mainIndex);

ms=[mainGen; mainGen];
ma=[mainAge; mainAge];
mg=[mainGroup; mainGroup];
me=[zeros(size(mainGen)); ones(size(mainGen))];

% load data
load('tryCompareRestCue.mat',"tryBatch");
restMeanTime=tryBatch{1};
restStdTime=tryBatch{2};
cueMeanTime=tryBatch{3};
cueStdTime=tryBatch{4};

hr=[cueMeanTime(:,1); cueMeanTime(:,2)];

apValues=tryBatch{11};
apstdValues=tryBatch{12};
apValues1=tryBatch{13};
apstdValues1=tryBatch{14};

ap=[apValues1(:,1); apValues1(:,2)];

restHrvMeanTime=tryBatch{31};
restHrvStdTime=tryBatch{32};
cueHrvTime=tryBatch{33};
cueHrvStdTime=tryBatch{34};

hrv=[cueHrvTime(:,1); cueHrvTime(:,2)];

% run anova
% p1 = anovan((hr),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% p2 = anovan((ap),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% p3 = anovan((hrv),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% 
% ms=cleanUp(ms);
% ma=cleanUp(ma);
% mg=cleanUp(mg);
% me=cleanUp(me);

% hr=cleanUp(hr);
% ap=cleanUp(ap);
% hrv=cleanUp(hrv);
% hrv(length(hrv)+1)=hrv(end);

% pa1 = anovan(hr,{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% pa2 = anovan(ap,{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% pa3 = anovan(hrv,{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})

% pb1 = anovan(hr,{ms ma mg},'model','interaction','varnames',{'Gender','Age','Group'})
% pb2 = anovan(ap,{ms ma mg},'model','interaction','varnames',{'Gender','Age','Group'})
% pb3 = anovan(hrv,{ms ma mg},'model','interaction','varnames',{'Gender','Age','Group'})
% 
% 

%p4 = anovan(hrv,{ms ma mg me hr},'model','interaction','varnames',{'Gender','Age','Group','Session','Heart Rate'})
%p5 = anovan(hrv,{ms ma mg me ap},'model','interaction','varnames',{'Gender','Age','Group','Session','Alpha Power'})
% pb1 = anovan(hr,{ms ma mg},'model','interaction','varnames',{'Gender','Age','Group'})
% pb2 = anovan(ap,{ms ma mg},'model','interaction','varnames',{'Gender','Age','Group'})
% pb3 = anovan(hrv,{ms ma mg},'model','interaction','varnames',{'Gender','Age','Group'})
% 

%p0 = anovan((me),{ms ma mg hr ap hrv},'model','interaction','varnames',{'Gender','Age','Group','Heart Rate','Alpha Power','HRV'})
%rowz=1:1:length(squeeze(ms(:,1)));
%tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'RowNames',{num2str(squeeze(rowz))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});
tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});


ttab = table([squeeze(me(:,1))]','VariableNames',{'Session'});

%rm = fitrm(tryTable,'Gender-HRV ~ Session','WithinDesign',ttab);


