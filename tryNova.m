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
lpp=tryBatch{50};
lppOld=tryBatch{51};

hr=[cueMeanTime(:,1); cueMeanTime(:,2)];
hr=[restMeanTime(:,1); cueMeanTime(:,1)];
lpp=[lpp(:,1); lpp(:,2)];
lpp=[lppOld(:,1); lppOld(:,2)];

apValues=tryBatch{11};
apstdValues=tryBatch{12};
apValues1=tryBatch{13};
apstdValues1=tryBatch{14};

ap=[apValues1(:,1); apValues1(:,2)];
ap=[apValues(:,1); apValues1(:,1)];


restHrvMeanTime=tryBatch{31};
restHrvStdTime=tryBatch{32};
cueHrvTime=tryBatch{33};
cueHrvStdTime=tryBatch{34};

hrv=[cueHrvTime(:,1); cueHrvTime(:,2)];
hrv=[restHrvMeanTime(:,1); cueHrvTime(:,1)];

% run anova
% [p1,tbl1,stats,~] = anovan((hr),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% [p2,tbl2,stats,~] = anovan((ap),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% [p3,tbl3,stats,~] = anovan((hrv),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
%[p4,tbl4,stats,~] = anovan((lpp),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})

session={};
for ll=1:length(me)
session{ll}=num2str(me(ll));
end
session=session';

%p=anovan((me),{mg hr ap},'model','interaction','varnames',{'Group','Heart Rate','Alpha Power','HRV'})

%rowz=1:1:length(squeeze(ms(:,1)));
%tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'RowNames',{num2str(squeeze(rowz))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});
tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});


%t = table(session,hr(:,1),ap(:,1),hrv(:,1),ms(:,1),ma(:,1),mg(:,1),...
%VariableNames=["session","hr","alphapower","hrv","gender","age","group"]);
%Meas = table([1 2 3 4 5 6]',VariableNames="Measurements");
%rm = fitrm(t,"hr-group~session",WithinDesign=Meas);
%Rrm.Coefficients

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
% t = table(session,hr(:,1),ap(:,1),hrv(:,1),ms(:,1),ma(:,1),mg(:,1),cd01(:,1),cd02(:,1),cd03(:,1),cd04(:,1),cd05(:,1),cd06(:,1),cd07(:,1),cd08(:,1),cd09(:,1),cd10(:,1),cd11(:,1),cd12(:,1),...
% VariableNames=["session","hr","alphapower","hrv","gender","age","group","scale1","scale2","scale3","scale4","scale5","scale6","scale7","scale8","scale9","scale10","scale11","scale12"]);
% Meas = table([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18]',VariableNames="Measurements");
% rm = fitrm(t,"hr-scale12~session",WithinDesign=Meas);
% rm.Coefficients

scales='ius_total_baseline	ius_total_baseline_child_scale	bdi_total_baseline	bai_total_baseline	audit_total_baseline	dmqr_social_baseline	dmqr_cope_anxiety_baseline	dmqr_cope_depression_baseline	dmqr_enhancement_baseline	dmqr_conformity_baseline	pcl_total_baseline	subscore_fav_druguse_baseline';
%scales='ius_total_baseline (scale1),	ius_total_baseline_child_scale (scale2),	bdi_total_baseline (scale3),	bai_total_baseline (scale4),	audit_total_baseline (scale5),	dmqr_social_baseline (scale6),	dmqr_cope_anxiety_baseline (scale7),	dmqr_cope_depression_baseline (scale8),	dmqr_enhancement_baseline (scale9),	dmqr_conformity_baseline (scale10),	pcl_total_baseline (scale11),	subscore_fav_druguse_baseline (scale12)';


% t = table(session,hr(:,1),hrv(:,1),ap(:,1),ms(:,1),ma(:,1),mg(:,1),cd01(:,1),cd02(:,1),cd03(:,1),cd04(:,1),cd05(:,1),cd06(:,1),cd07(:,1),cd08(:,1),cd09(:,1),cd10(:,1),cd11(:,1),cd12(:,1),...
% VariableNames=["session","hr","hrv","alphapower","gender","age","group","scale1","scale2","scale3","scale4","scale5","scale6","scale7","scale8","scale9","scale10","scale11","scale12"]);
% Meas = table([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]',VariableNames="Measurements");
% rm = fitrm(t,"gender-scale12~session+hr+hrv+alphapower",WithinDesign=Meas);
% rm.Coefficients

% 
% p21 = anovan((hr),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
% p22 = anovan((ap),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
% p23 = anovan((hrv),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
%[p2112,tbl2112,stats,~] = anovan((hr),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})
%[p2212,tbl2212,stats,~] = anovan((ap),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})
%[p2312,tbl2312,stats,~] = anovan((hrv),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})
[p2412,tbl2412,stats,~] = anovan((lpp),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})


% 
% [p2111,tbl2111,stats,~] = anovan((hr),{ms mg me cd11},'model','interaction','varnames',{'Gender','Group','Trials','Scale11'})
% [p2211,tbl2211,stats,~] = anovan((ap),{ms mg me cd11},'model','interaction','varnames',{'Gender','Group','Trials','Scale11'})
% [p2311,tbl2311,stats,~] = anovan((hrv),{ms mg me cd11},'model','interaction','varnames',{'Gender','Group','Trials','Scale11'})
% 
% [p2110,tbl2110,stats,~] = anovan((hr),{ms mg me cd10},'model','interaction','varnames',{'Gender','Group','Trials','Scale10'})
% [p2210,tbl2219,stats,~] = anovan((ap),{ms mg me cd10},'model','interaction','varnames',{'Gender','Group','Trials','Scale10'})
% [p2310,tbl2310,stats,~] = anovan((hrv),{ms mg me cd10},'model','interaction','varnames',{'Gender','Group','Trials','Scale10'})
% 
% [p2109,tbl2109,stats,~] = anovan((hr),{ms mg me cd09},'model','interaction','varnames',{'Gender','Group','Trials','Scale9'})
% [p2209,tbl2209,stats,~] = anovan((ap),{ms mg me cd09},'model','interaction','varnames',{'Gender','Group','Trials','Scale9'})
% [p2309,tbl2309,stats,~] = anovan((hrv),{ms mg me cd09},'model','interaction','varnames',{'Gender','Group','Trials','Scale9'})
% 
% [p2108,tbl2108,stats,~] = anovan((hr),{ms mg me cd08},'model','interaction','varnames',{'Gender','Group','Trials','Scale8'})
% [p2208,tbl2208,stats,~] = anovan((ap),{ms mg me cd08},'model','interaction','varnames',{'Gender','Group','Trials','Scale8'})
% [p2308,tbl2308,stats,~] = anovan((hrv),{ms mg me cd08},'model','interaction','varnames',{'Gender','Group','Trials','Scale8'})

% [p2107,tbl2107,stats,~] = anovan((hr),{ms mg me cd07},'model','interaction','varnames',{'Gender','Group','Trials','Scale7'})
% [p2207,tbl2207,stats,~] = anovan((ap),{ms mg me cd07},'model','interaction','varnames',{'Gender','Group','Trials','Scale7'})
% [p2307,tbl2307,stats,~] = anovan((hrv),{ms mg me cd07},'model','interaction','varnames',{'Gender','Group','Trials','Scale7'})
% 
% [p2106,tbl2106,stats,~] = anovan((hr),{ms mg me cd06},'model','interaction','varnames',{'Gender','Group','Trials','Scale6'})
% [p2206,tbl2206,stats,~] = anovan((ap),{ms mg me cd06},'model','interaction','varnames',{'Gender','Group','Trials','Scale6'})
% [p2306,tbl2306,stats,~] = anovan((hrv),{ms mg me cd06},'model','interaction','varnames',{'Gender','Group','Trials','Scale6'})

% [p2105,tbl2105,stats,~] = anovan((hr),{ms mg me cd05},'model','interaction','varnames',{'Gender','Group','Trials','Scale5'})
% [p2205,tbl2205,stats,~] = anovan((ap),{ms mg me cd05},'model','interaction','varnames',{'Gender','Group','Trials','Scale5'})
% [p2305,tbl2305,stats,~] = anovan((hrv),{ms mg me cd05},'model','interaction','varnames',{'Gender','Group','Trials','Scale5'})
% 
% [p2104,tbl2104,stats,~] = anovan((hr),{ms mg me cd04},'model','interaction','varnames',{'Gender','Group','Trials','Scale4'})
% [p2204,tbl2204,stats,~] = anovan((ap),{ms mg me cd04},'model','interaction','varnames',{'Gender','Group','Trials','Scale4'})
% [p2304,tbl2304,stats,~] = anovan((hrv),{ms mg me cd04},'model','interaction','varnames',{'Gender','Group','Trials','Scale4'})

%[p2103,tbl2103,stats,~] = anovan((hr),{ms mg me cd03},'model','interaction','varnames',{'Gender','Group','Sessions','Scale3'})
%[p2203,tbl2203,stats,~] = anovan((ap),{ms mg me cd03},'model','interaction','varnames',{'Gender','Group','Sessions','Scale3'})
%[p2303,tbl2303,stats,~] = anovan((hrv),{ms mg me cd03},'model','interaction','varnames',{'Gender','Group','Sessions','Scale3'})
[p2403,tbl2403,stats,~] = anovan((lpp),{ms mg me cd03},'model','interaction','varnames',{'Gender','Group','Sessions','Scale3'})


% 
% [p2102,tbl2102,stats,~] = anovan((hr),{ms mg me cd02},'model','interaction','varnames',{'Gender','Group','Trials','Scale2'})
% [p2202,tbl2202,stats,~] = anovan((ap),{ms mg me cd02},'model','interaction','varnames',{'Gender','Group','Trials','Scale2'})
% [p2302,tbl2302,stats,~] = anovan((hrv),{ms mg me cd02},'model','interaction','varnames',{'Gender','Group','Trials','Scale2'})

%[p2101,tbl2101,stats,~] = anovan((hr),{ms mg me cd01},'model','interaction','varnames',{'Gender','Group','Sessions','Scale1'})
%[p2201,tbl2201,stats,~] = anovan((ap),{ms mg me cd01},'model','interaction','varnames',{'Gender','Group','Sessions','Scale1'})
%[p2301,tbl2301,stats,~] = anovan((hrv),{ms mg me cd01},'model','interaction','varnames',{'Gender','Group','Sessions','Scale1'})
[p2401,tbl2401,stats,~] = anovan((lpp),{ms mg me cd01},'model','interaction','varnames',{'Gender','Group','Sessions','Scale1'})


%[p23,tbl,stats,~] = anovan((hrv),{ms mg me cd01},'model','interaction','varnames',{'Gender','Group','Session','Scale1'})


% 
% pp1=corrcoef(hr,cd12);
% pp2=corrcoef(ap,cd12);
% pp3=corrcoef(hrv,cd12);
toc;

% 
% p31 = anovan((ms),{hr me cd12},'model','interaction','varnames',{'HR','Group','Scale12'})
% p32 = anovan((ms),{ap me cd12},'model','interaction','varnames',{'Alpha','Group','Scale12'})
% p33 = anovan((ms),{hrv me cd12},'model','interaction','varnames',{'HRV','Group','Scale12'})
% figure;
% scatter(hrv,cd12);
% xlabel('HRV')
% ylabel('Scale 12')
% 
% figure;
% scatter(hrv,cd03);
% xlabel('HRV')
% ylabel('Scale 03')
% 
% figure;
% scatter(hrv,cd01);
% xlabel('HRV')
% ylabel('Scale 01')
% 
% [R1,P1] = corrcoef(hrv,cd01);
% [R3,P3] = corrcoef(hrv,cd03);
% [R12,P12] = corrcoef(hrv,cd12);
% 
% [R1,P1] = corrcoef(hr,cd01);
% [R3,P3] = corrcoef(hr,cd03);
% [R12,P12] = corrcoef(hr,cd12);
% 
% [R1,P1] = corrcoef(ap,cd01);
% [R3,P3] = corrcoef(ap,cd03);
% [R12,P12] = corrcoef(ap,cd12);
% 
% [p3111,tbl3111,stats,~] = anovan((cd01),{ms mg me hrv},'model','interaction','varnames',{'Gender','Group','Session','HRV'})
% [p3211,tbl3211,stats,~] = anovan((cd03),{ms mg me hrv},'model','interaction','varnames',{'Gender','Group','Session','HRV'})
% [p3311,tbl3311,stats,~] = anovan((cd12),{ms mg me hrv},'model','interaction','varnames',{'Gender','Group','Session','HRV'})
% 
% hrk = hr(find(prototype_cleanup(hrv)));
% apk = ap(find(prototype_cleanup(hrv)));
% hrvk = hrv(find(prototype_cleanup(hrv)));
% kd01=cd01(find(prototype_cleanup(hrv)));
% kd03=cd03(find(prototype_cleanup(hrv)));
% kd12=cd12(find(prototype_cleanup(hrv)));
% 
% kms=ms(find(prototype_cleanup(hrv)));
% kmg=mg(find(prototype_cleanup(hrv)));
% kme=me(find(prototype_cleanup(hrv)));
% 
% figure;
% scatter(hrvk,kd12);
% xlabel('HRV')
% ylabel('Scale 12')
% 
% figure;
% scatter(hrvk,kd03);
% xlabel('HRV')
% ylabel('Scale 03')
% 
% figure;
% scatter(hrvk,kd01);
% xlabel('HRV')
% ylabel('Scale 01')
% 
% [R1,P1] = corrcoef(hrvk,kd01);
% [R3,P3] = corrcoef(hrvk,kd03);
% [R12,P12] = corrcoef(hrvk,kd12);
% 
% [p3111,tbl3111,stats,~] = anovan((hrvk),{kms kmg kme kd01},'model','interaction','varnames',{'Gender','Group','Session','Scale01'})
% [p3211,tbl3211,stats,~] = anovan((hrvk),{kms kmg kme kd03},'model','interaction','varnames',{'Gender','Group','Session','Scale03'})
% [p3311,tbl3311,stats,~] = anovan((hrvk),{kms kmg kme kd12},'model','interaction','varnames',{'Gender','Group','Session','Scale12'})
% 
% figure;
% plot(hrvk,kd12);
% xlabel('HRV')
% ylabel('Scale 12')
% 
% figure;
% plot(hrvk,kd03);
% xlabel('HRV')
% ylabel('Scale 03')
% 
% figure;
% plot(hrvk,kd01);
% xlabel('HRV')
% ylabel('Scale 01')
% 
% c01 = polyfit(hrvk,kd01,1);
% c03 = polyfit(hrvk,kd03,1);
% c12 = polyfit(hrvk,kd12,1);
% 
% hrvk_est1 = polyval(c01,hrvk);
% hrvk_est3 = polyval(c03,hrvk);
% hrvk_est12 = polyval(c12,hrvk);
% 
% figure;
% plot(hrvk,hrvk_est1);
% xlabel('HRV')
% ylabel('Scale 01')
% 
% figure;
% plot(hrvk,hrvk_est3);
% xlabel('HRV')
% ylabel('Scale 03')
% 
% figure;
% plot(hrvk,hrvk_est12);
% xlabel('HRV')
% ylabel('Scale 12')
% 
% c01 = polyfit(apk,kd01,1);
% c03 = polyfit(apk,kd03,1);
% c12 = polyfit(apk,kd12,1);
% 
% apk_est1 = polyval(c01,apk);
% apk_est3 = polyval(c03,apk);
% apk_est12 = polyval(c12,apk);
% 
% figure;
% plot(apk,apk_est1);
% xlabel('Alpha Power')
% ylabel('Scale 01')
% 
% figure;
% plot(apk,apk_est3);
% xlabel('Alpha Power')
% ylabel('Scale 03')
% 
% figure;
% plot(apk,apk_est12);
% xlabel('Alpha Power')
% ylabel('Scale 12')
% 
% c01 = polyfit(hrk,kd01,1);
% c03 = polyfit(hrk,kd03,1);
% c12 = polyfit(hrk,kd12,1);
% 
% hrk_est1 = polyval(c01,hrk);
% hrk_est3 = polyval(c03,hrk);
% hrk_est12 = polyval(c12,hrk);
% 
% figure;
% plot(hrk,hrk_est1);
% xlabel('HR (bpm)')
% ylabel('Scale 01')
% 
% figure;
% plot(hrk,hrk_est3);
% xlabel('HR (bpm)')
% ylabel('Scale 03')
% 
% figure;
% plot(hrk,hrk_est12);
% xlabel('HR (bpm)')
% ylabel('Scale 12')
% 
