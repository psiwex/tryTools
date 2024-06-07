%https://www.mathworks.com/help/stats/repeatedmeasuresmodel.ranova.html
tic;

homeDir='C:\Users\John\Documents\MATLAB\tryEeg\CUE_REST\';
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

list= dir([homeDir '\TRY*']);

T = struct2table(list);
subNames=table2cell(T(:,1));

ki=1;
subNum='TRY001';
subTxt={};


T1 = readtable('tryDemo.xlsx');
nameList=table2cell(forgotT1(:,1));
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
p1 = anovan((hr),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
p2 = anovan((ap),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
p3 = anovan((hrv),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})

session={};
for ll=1:length(me)
session{ll}=num2str(me(ll));
end
session=session';

%p=anovan((me),{mg hr ap},'model','interaction','varnames',{'Group','Heart Rate','Alpha Power','HRV'})

%rowz=1:1:length(squeeze(ms(:,1)));
%tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'RowNames',{num2str(squeeze(rowz))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});
tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});


t = table(session,hr(:,1),ap(:,1),hrv(:,1),ms(:,1),ma(:,1),mg(:,1),...
VariableNames=["session","hr","alphapower","hrv","gender","age","group"]);
Meas = table([1 2 3 4 5 6]',VariableNames="Measurements");
rm = fitrm(t,"hr-group~session",WithinDesign=Meas);
rm.Coefficients

%% exam data
%5 to 16
T2 = readtable('TRY_baseline_scales.xlsx');
col1=table2cell(T2(:,5));
col2=table2cell(T2(:,6));
col3=table2cell(T2(:,7));
col4=table2cell(T2(:,8));

col5=table2cell(T2(:,9));
col6=table2cell(T2(:,10));
col7=table2cell(T2(:,11));
col8=table2cell(T2(:,12));

col9=table2cell(T2(:,13));
col10=table2cell(T2(:,14));
col11=table2cell(T2(:,15));
col12=table2cell(T2(:,16));

% convert them to mat
col1=cleanZero(cell2mat(col1));
col2=cleanZero(cell2mat(col2));
col3=cleanZero(cell2mat(col3));
col4=cleanZero(cell2mat(col4));

col5=cleanZero(cell2mat(col5));
col6=cleanZero(cell2mat(col6));
col7=cleanZero(cell2mat(col7));
col8=cleanZero(cell2mat(col8));

col9=cleanZero(cell2mat(col9));
col10=cleanZero(cell2mat(col10));
col11=cleanZero(cell2mat(col11));
col12=cleanZero(cell2mat(col12));

% calculate offset
% [x0,~]=size(T);
% [x1,~]=size(T2);
% offSets=abs(x1-x0)+1;
% mainIndex2=mainIndex-offSets;

nameList=table2cell(T2(:,1));
subInd=1;
mainDex2={};
mainIndex2=[];

for ki=1:length(subNames)
subNum=subNames{ki};


if any(strcmp(nameList,subNum))
% Do Something
mainDex2{subInd}=subNum;

mainIndex2(ki)=find(strcmp(nameList,subNum));
subInd=subInd+1;

else
% Do Something else

end

end


% call index
c01=col1(mainIndex2);
c02=col2(mainIndex2);
c03=col3(mainIndex2);
c04=col4(mainIndex2);

c05=col5(mainIndex2);
c06=col6(mainIndex2);
c07=col7(mainIndex2);
c08=col8(mainIndex2);

c09=col9(mainIndex2);
c10=col10(mainIndex2);
c11=col11(mainIndex2);
c12=col12(mainIndex2);

% the column added
cd01=[c01; c01];
cd02=[c02; c02];
cd03=[c03; c03];
cd04=[c04; c04];

cd05=[c05; c05];
cd06=[c06; c06];
cd07=[c07; c07];
cd08=[c08; c08];

cd09=[c09; c09];
cd10=[c10; c10];
cd11=[c11; c11];
cd12=[c12; c12];

% next anova
t = table(session,hr(:,1),ap(:,1),hrv(:,1),ms(:,1),ma(:,1),mg(:,1),cd01(:,1),cd02(:,1),cd03(:,1),cd04(:,1),cd05(:,1),cd06(:,1),cd07(:,1),cd08(:,1),cd09(:,1),cd10(:,1),cd11(:,1),cd12(:,1),...
VariableNames=["session","hr","alphapower","hrv","gender","age","group","scale1","scale2","scale3","scale4","scale5","scale6","scale7","scale8","scale9","scale10","scale11","scale12"]);
Meas = table([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18]',VariableNames="Measurements");
rm = fitrm(t,"hr-scale12~session",WithinDesign=Meas);
rm.Coefficients

scales='ius_total_baseline	ius_total_baseline_child_scale	bdi_total_baseline	bai_total_baseline	audit_total_baseline	dmqr_social_baseline	dmqr_cope_anxiety_baseline	dmqr_cope_depression_baseline	dmqr_enhancement_baseline	dmqr_conformity_baseline	pcl_total_baseline	subscore_fav_druguse_baseline';
%scales='ius_total_baseline (scale1),	ius_total_baseline_child_scale (scale2),	bdi_total_baseline (scale3),	bai_total_baseline (scale4),	audit_total_baseline (scale5),	dmqr_social_baseline (scale6),	dmqr_cope_anxiety_baseline (scale7),	dmqr_cope_depression_baseline (scale8),	dmqr_enhancement_baseline (scale9),	dmqr_conformity_baseline (scale10),	pcl_total_baseline (scale11),	subscore_fav_druguse_baseline (scale12)';


t = table(session,hr(:,1),hrv(:,1),ap(:,1),ms(:,1),ma(:,1),mg(:,1),cd01(:,1),cd02(:,1),cd03(:,1),cd04(:,1),cd05(:,1),cd06(:,1),cd07(:,1),cd08(:,1),cd09(:,1),cd10(:,1),cd11(:,1),cd12(:,1),...
VariableNames=["session","hr","hrv","alphapower","gender","age","group","scale1","scale2","scale3","scale4","scale5","scale6","scale7","scale8","scale9","scale10","scale11","scale12"]);
Meas = table([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]',VariableNames="Measurements");
rm = fitrm(t,"gender-scale12~session+hr+hrv+alphapower",WithinDesign=Meas);
rm.Coefficients

% 
% p21 = anovan((hr),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
% p22 = anovan((ap),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
% p23 = anovan((hrv),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
p21 = anovan((hr),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Session','Scale12'})
p22 = anovan((ap),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Session','Scale12'})
p23 = anovan((hrv),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Session','Scale12'})
% 
% pp1=corrcoef(hr,cd12);
% pp2=corrcoef(ap,cd12);
% pp3=corrcoef(hrv,cd12);
toc;

% 
% p31 = anovan((ms),{hr me cd12},'model','interaction','varnames',{'HR','Group','Scale12'})
% p32 = anovan((ms),{ap me cd12},'model','interaction','varnames',{'Alpha','Group','Scale12'})
% p33 = anovan((ms),{hrv me cd12},'model','interaction','varnames',{'HRV','Group','Scale12'})
