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

lppAmpValues1=tryBatch{51};
lppAmpStdValues1=tryBatch{52};

%% more lpp
lppAmpNeuValues=tryBatch{40};
lppAmpNeuStdValues=tryBatch{41};

lppAmpAlcValues=tryBatch{42};
lppAmpAlcStdValues=tryBatch{43};

lppAmpFodValues=tryBatch{44};
lppAmpFodStdValues=tryBatch{45};

lppAmpFixValues=tryBatch{46};
lppAmpFixStdValues=tryBatch{47};

lppNeuMean=mean(cleanUp(lppAmpNeuValues(:,1)));
lppAlcMean=mean(cleanUp(lppAmpAlcValues(:,1)));
lppFodMean=mean(cleanUp(lppAmpFodValues(:,1)));
lppFixMean=mean(cleanUp(lppAmpFixValues(:,1)));

lppNeuStd=std(cleanUp(lppAmpNeuValues(:,1)));
lppAlcStd=std(cleanUp(lppAmpAlcValues(:,1)));
lppFodStd=std(cleanUp(lppAmpFodValues(:,1)));
lppFixStd=std(cleanUp(lppAmpFixValues(:,1)));

lppAlcContrast=[cleanUp(lppAmpAlcValues(:,1))-lppNeuMean; cleanUp(lppAmpAlcValues(:,2))-lppNeuMean]; 
lppFodContrast=[cleanUp(lppAmpFodValues(:,1))-lppNeuMean; cleanUp(lppAmpFodValues(:,2))-lppNeuMean]; 
lppFixContrast=[cleanUp(lppAmpFixValues(:,1))-lppNeuMean; cleanUp(lppAmpFixValues(:,2))-lppNeuMean];

hr=[cueMeanTime(:,1); cueMeanTime(:,2)];
%hr=[restMeanTime(:,1); cueMeanTime(:,1)];
%lpp=[lpp(:,1); lpp(:,2)];
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

val=round(length(cd12)/2);
ms=ms(1:val); 
mg=mg(1:val); 
me=me(1:val); 
lpp=lpp(1:val);
cd12=c12;
cd03=c03;
cd01=c01;

hrv=hrv(1:val);
hr=hr(1:val);
ap=ap(1:val);

scales='ius_total_baseline	ius_total_baseline_child_scale	bdi_total_baseline	bai_total_baseline	audit_total_baseline	dmqr_social_baseline	dmqr_cope_anxiety_baseline	dmqr_cope_depression_baseline	dmqr_enhancement_baseline	dmqr_conformity_baseline	pcl_total_baseline	subscore_fav_druguse_baseline';


% 
% p21 = anovan((hr),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
% p22 = anovan((ap),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
% p23 = anovan((hrv),{ms ma mg me cd01 cd02 cd03 cd04 cd05 cd06 cd07 cd08 cd09 cd10 cd11 cd12},'model','interaction','varnames',{'Gender','Age','Group','Session','Scale1','Scale2','Scale3','Scale4','Scale5','Scale6','Scale7','Scale8','Scale9','Scale10','Scale11','Scale12'})
%[p2112,tbl2112,stats,~] = anovan((hr),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})
%[p2212,tbl2212,stats,~] = anovan((ap),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})
%[p2312,tbl2312,stats,~] = anovan((hrv),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})
%[p2412,tbl2412,stats,~] = anovan((lpp),{ms mg me cd12},'model','interaction','varnames',{'Gender','Group','Sessions','Scale12'})


[p24121,tbl24121,stats,~] = anovan((lpp),{ms mg cd12},'model','interaction','varnames',{'Gender','Group','Scale12'})


[p24031,tbl24031,stats,~] = anovan((lpp),{ms mg c03},'model','interaction','varnames',{'Gender','Group','Scale03'})
[p24011,tbl24011,stats,~] = anovan((lpp),{ms mg c02},'model','interaction','varnames',{'Gender','Group','Scale02'})


[R12,P12] = corrcoef(lpp,cd12);
[R03,P03] = corrcoef(lpp,cd03);
[R01,P01] = corrcoef(lpp,cd01);

%[p23,tbl,stats,~] = anovan((hrv),{ms mg me cd01},'model','interaction','varnames',{'Gender','Group','Session','Scale1'})


% 
% pp1=corrcoef(hr,cd12);
% pp2=corrcoef(ap,cd12);
% pp3=corrcoef(hrv,cd12);
toc;



x0=find(mg==0);
x1=find(mg==1);

lpp0=lpp(x0);

lpp1=lpp(x1);

al0=mean(lpp0);
al1=mean(lpp1);
alpp=al1-al0;

c120=cd12(x0);

c121=cd12(x1);

ca0=mean(c120);
ca1=mean(c121);
cda=ca1-ca0;


% [p,t,stats,~] = anovan((lpp),{ms mg c01},'model','interaction','varnames',{'Gender','Group','Scale01'})
% [p,t,stats,~] = anovan((lpp),{ms mg c02},'model','interaction','varnames',{'Gender','Group','Scale02'})
% [p,t,stats,~] = anovan((lpp),{ms mg c04},'model','interaction','varnames',{'Gender','Group','Scale04'})
% [p,t,stats,~] = anovan((lpp),{ms mg c05},'model','interaction','varnames',{'Gender','Group','Scale05'})
% [p,t,stats,~] = anovan((lpp),{ms mg c06},'model','interaction','varnames',{'Gender','Group','Scale06'})
% [p,t,stats,~] = anovan((lpp),{ms mg c07},'model','interaction','varnames',{'Gender','Group','Scale07'})
% [p,t,stats,~] = anovan((lpp),{ms mg c08},'model','interaction','varnames',{'Gender','Group','Scale08'})
% [p,t,stats,~] = anovan((lpp),{ms mg c09},'model','interaction','varnames',{'Gender','Group','Scale09'})
% [p,t,stats,~] = anovan((lpp),{ms mg c10},'model','interaction','varnames',{'Gender','Group','Scale10'})
% [p,t,stats,~] = anovan((lpp),{ms mg c11},'model','interaction','varnames',{'Gender','Group','Scale11'})
% [p,t,stats,~] = anovan((lpp),{ms mg c12},'model','interaction','varnames',{'Gender','Group','Scale12'})

[ra,pa]=corrcoef(cd12,lpp);
[rb,pb]=corrcoef(mg,lpp);
[rc,pc]=corrcoef(mg,cd12);

[rd,pd]=corrcoef(hr,lpp);
[re,pe]=corrcoef(ap,lpp);
[rf,pf]=corrcoef(hrv,lpp);

[rg,pg]=corrcoef(hr,cd12);
[rh,ph]=corrcoef(ap,cd12);
[ri,pi]=corrcoef(hrv,cd12);

[ra,pa]=corrcoef(cleanUp(cd12),cleanUp(lpp));
[rb,pb]=corrcoef(cleanUp(mg),cleanUp(lpp));
[rc,pc]=corrcoef(cleanUp(mg),cleanUp(cd12));

[rd,pd]=corrcoef([cleanUp(hr); hr(1)],cleanUp(lpp));
[re,pe]=corrcoef(cleanUp(ap),cleanUp(lpp));
[rf,pf]=corrcoef([cleanUp(hrv); hrv(1)],cleanUp(lpp));

[rg,pg]=corrcoef([cleanUp(hr); hr(1)],cleanUp(cd12));
[rh,ph]=corrcoef(cleanUp(ap),cleanUp(cd12));
[ri,pi]=corrcoef([cleanUp(hrv); hrv(1)],cleanUp(cd12));
[rj,pj]=corrcoef(cleanUp(lpp),cleanUp(cd12));

halfWay=round(.5*length(lppFodContrast));
lppFod=lppFodContrast(1:halfWay);
lppAlc=lppAlcContrast(1:halfWay);
lppFix=lppFixContrast(1:halfWay);

[p,t,stats,~] = anovan((lpp),{ms mg c07},'model','interaction','varnames',{'Gender','Group','Scale07'})
[p,t,stats,~] = anovan((lpp),{ms mg c12},'model','interaction','varnames',{'Gender','Group','Scale12'})
[p,t,stats,~] = anovan((lpp),{ms mg c07 c12},'model','interaction','varnames',{'Gender','Group','Scale07','Scale12'})


% alc

[p,t,stats,~] = anovan((lppAlc),{ms mg c07},'model','interaction','varnames',{'Gender','Group','Scale07'})
[p,t,stats,~] = anovan((lppAlc),{ms mg c12},'model','interaction','varnames',{'Gender','Group','Scale12'})
[p,t,stats,~] = anovan((lppAlc),{ms mg c07 c12},'model','interaction','varnames',{'Gender','Group','Scale07','Scale12'})


% fod
[p,t,stats,~] = anovan((lppFod),{ms mg c07},'model','interaction','varnames',{'Gender','Group','Scale07'})
[p,t,stats,~] = anovan((lppFod),{ms mg c12},'model','interaction','varnames',{'Gender','Group','Scale12'})
[p,t,stats,~] = anovan((lppFod),{ms mg c07 c12},'model','interaction','varnames',{'Gender','Group','Scale07','Scale12'})


% fix
[p,t,stats,~] = anovan((lppFix),{ms mg c07},'model','interaction','varnames',{'Gender','Group','Scale07'})
[p,t,stats,~] = anovan((lppFix),{ms mg c12},'model','interaction','varnames',{'Gender','Group','Scale12'})
[p,t,stats,~] = anovan((lppFix),{ms mg c07 c12},'model','interaction','varnames',{'Gender','Group','Scale07','Scale12'})
