%https://www.mathworks.com/help/stats/repeatedmeasuresmodel.ranova.html
tic;


%new categories
%-0: no trauma
%-1: trauma but no PTSD
%-2: trauma and PTSD (lifetime/current)



pvalue=1;
fs=1024;
homeDir='C:\Users\John\Documents\MATLAB\tryEeg\CUE_REST\';
channelLocationFile = 'C:\Users\John\Documents\MATLAB\eeglab2021.1\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp';

list= dir([homeDir '\TRY*']);

T = struct2table(list);
subNames=table2cell(T(:,1));

ki=1;
subNum='TRY001';
subTxt={};

subs=2;



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

x=[cueHrvTime(:,1) apValues1(:,1) mainGen mainAge mainGroup];

hrvRest=restHrvMeanTime(:,1);
xisn=isnan(hrvRest);

hrvRest(xisn==1)=0;

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

% run anova
% [p1,tbl1,stats,~] = anovan((hr),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% [p2,tbl2,stats,~] = anovan((ap),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})
% [p3,tbl3,stats,~] = anovan((hrv),{ms ma mg me},'model','interaction','varnames',{'Gender','Age','Group','Session'})

session={};
for ll=1:length(me)
session{ll}=num2str(me(ll));
end
session=session';

%p=anovan((me),{mg hr ap},'model','interaction','varnames',{'Group','Heart Rate','Alpha Power','HRV'})

%rowz=1:1:length(squeeze(ms(:,1)));
%tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'RowNames',{num2str(squeeze(rowz))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});
tryTable=array2table({squeeze(ms(:,1)), squeeze(ma(:,1)), squeeze(mg(:,1)), squeeze(hr(:,1)), squeeze(ap(:,1)), squeeze(hrv(:,1))},'VariableNames',{'Gender','Age','Group','HR','Alpha','HRV'});

% 
% t = table(session,hr(:,1),ap(:,1),hrv(:,1),ms(:,1),ma(:,1),mg(:,1),...
% VariableNames=["session","hr","alphapower","hrv","gender","age","group"]);
% Meas = table([1 2 3 4 5 6]',VariableNames="Measurements");
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

%hrvRest1=hrvRest(mainIndex2);
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
x=[cueHrvTime(:,1) apValues1(:,1) mainGen mainAge mainGroup c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12];
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

T1 = readtable('tryOutcomes.xlsx');
subNameList=table2cell(T1(:,1));
subAgeList=table2cell(T1(:,2));
subGenderList=table2cell(T1(:,3));
groupList1=table2cell(T1(:,4));
groupList2=table2cell(T1(:,5));
groupList3=table2cell(T1(:,6));
groupList4=table2cell(T1(:,7));

groupLabels1=cell2mat(groupList1);
groupLabels2=cell2mat(groupList2);
groupLabels3=cell2mat(groupList3);
groupLabels4=cell2mat(groupList4);

x=[cueHrvTime(:,1) apValues1(:,1) mainGen mainAge mainGroup c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12];
x=[cueHrvTime(:,1) apValues1(:,1) mainGen mainAge c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12];
x=[lppOld(:,1) lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) apValues1(:,1) mainGen mainAge c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12];

x=[lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) apValues1(:,1) mainGen mainAge c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12];

XP=[lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) apValues1(:,1) mainGen mainAge];

%x=[lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) apValues1(:,1)];

mainData=x;



gLabels1=groupLabels1(mainIndex2);
gLabels2=groupLabels2(mainIndex2);
gLabels3=groupLabels3(mainIndex2);
gLabels4=groupLabels4(mainIndex2);



% 
% [data1,labels1]=tryFormat(mainData,gLabels1);
% [data2,labels2]=tryFormat(mainData,gLabels2);
% [data3,labels3]=tryFormat(mainData,gLabels3);
% [data4,labels4]=tryFormat(mainData,gLabels4);
% 
% [data1,labels1]=classBalance(data1,labels1,subs);
% [data2,labels2]=classBalance(data2,labels2,subs);
% [data3,labels3]=classBalance(data3,labels3,subs);
% [data4,labels4]=classBalance(data4,labels4,subs);

subs=2;
% [z_measures1,z_phi1,z_phiclassic1,z_aucroc1,z_accuracy1,z_sensitivity1,z_specificity1,z_acc21,z_ppv1,z_npv1,z_f1]=lda_adenz_mval(subs,data1,labels1,pvalue);
% [z_measures2,z_phi2,z_phiclassic2,z_aucroc2,z_accuracy2,z_sensitivity2,z_specificity2,z_acc22,z_ppv2,z_npv2,z_f12]=lda_adenz_mval(subs,data2,labels2,pvalue);
% [z_measures3,z_phi3,z_phiclassic3,z_aucroc3,z_accuracy3,z_sensitivity3,z_specificity3,z_acc23,z_ppv3,z_npv3,z_f13]=lda_adenz_mval(subs,data3,labels3,pvalue);
% [z_measures4,z_phi4,z_phiclassic4,z_aucroc4,z_accuracy4,z_sensitivity4,z_specificity4,z_acc24,z_ppv4,z_npv4,z_f14]=lda_adenz_mval(subs,data4,labels4,pvalue);
% 
% [mean_measures1,mean_phi1,mean_phiclassic1,mean_aucroc1,mean_accuracy1,mean_sensitivity1,mean_specificity1,mean_acc21,mean_ppv1,mean_npv1,mean_f1]=lda_aden_mval(subs,data1,labels1,pvalue);
% [mean_measures2,mean_phi2,mean_phiclassic2,mean_aucroc2,mean_accuracy2,mean_sensitivity2,mean_specificity2,mean_acc22,mean_ppv2,mean_npv2,mean_f12]=lda_aden_mval(subs,data2,labels2,pvalue);
% [mean_measures3,mean_phi3,mean_phiclassic3,mean_aucroc3,mean_accuracy3,mean_sensitivity3,mean_specificity3,mean_acc23,mean_ppv3,mean_npv3,mean_f13]=lda_aden_mval(subs,data3,labels3,pvalue);

% outs=[z_phi1 z_phi2 z_phi3 z_phi4 mean_phi1 mean_phi2 mean_phi3 0];
% outacc=[z_accuracy1 z_accuracy2 z_accuracy3 z_accuracy4 mean_accuracy1 mean_accuracy2 mean_accuracy3 0];
% outf1=[z_f1 z_f12 z_f13 z_f14 mean_f1 mean_f12 mean_f13 0]
% try
%[mean_measures4,mean_phi4,mean_phiclassic4,mean_aucroc4,mean_accuracy4,mean_sensitivity4,mean_specificity4,mean_acc24,mean_ppv4,mean_npv4,mean_f14]=lda_aden_mval(subs,data4,labels4,pvalue);
% 
% outs=[z_phi1 z_phi2 z_phi3 z_phi4 mean_phi1 mean_phi2 mean_phi3 mean_phi4];
% outf1=[z_f1 z_f12 z_f13 z_f14 mean_f1 mean_f12 mean_f13 mean_f14]
% outacc=[z_accuracy1 z_accuracy2 z_accuracy3 z_accuracy4 mean_accuracy1 mean_accuracy2 mean_accuracy3 mean_accuracy4];
% 
% xval=comparisonTests(data1,labels1,subs,pvalue,fs);
% [scores,acc,f1,phi,itr]=unwrapStruct(xval);
% [q1,~,~,~]=feature_selection_adenz(data1{1}',labels1{1},data1{1}',pvalue);
% [q2,~,~,~]=feature_selection_adenz(data2{1}',labels2{1},data2{1}',pvalue);
% [q3,~,~,~]=feature_selection_adenz(data3{1}',labels3{1},data3{1}',pvalue);
% [q4,~,~,~]=feature_selection_adenz(data4{1}',labels4{1},data4{1}',pvalue);


%% loading megalith project


megalith1 = readtable('megaLith1.xlsx');
x1=table2cell(megalith1(:,1));
x2=table2cell(megalith1(:,2));
x3=table2cell(megalith1(:,3));
x4=table2cell(megalith1(:,4));
x5=table2cell(megalith1(:,5));
x6=table2cell(megalith1(:,6));
x7=table2cell(megalith1(:,7));
x8=table2cell(megalith1(:,8));
x9=table2cell(megalith1(:,9));
x10=table2cell(megalith1(:,10));
x11=table2cell(megalith1(:,11));
x12=table2cell(megalith1(:,12));
x13=table2cell(megalith1(:,13));
x14=table2cell(megalith1(:,14));
x15=table2cell(megalith1(:,15));
x16=table2cell(megalith1(:,16));
x17=table2cell(megalith1(:,17));
x18=table2cell(megalith1(:,18));
x19=table2cell(megalith1(:,19));
x20=table2cell(megalith1(:,20));
x21=table2cell(megalith1(:,21));
x22=table2cell(megalith1(:,22));
x23=table2cell(megalith1(:,23));
x24=table2cell(megalith1(:,24));
x25=table2cell(megalith1(:,25));
x26=table2cell(megalith1(:,26));
x27=table2cell(megalith1(:,27));
x28=table2cell(megalith1(:,28));
x29=table2cell(megalith1(:,29));
x30=table2cell(megalith1(:,30));
x31=table2cell(megalith1(:,31));
x32=table2cell(megalith1(:,32));
x33=table2cell(megalith1(:,33));
x34=table2cell(megalith1(:,34));
x35=table2cell(megalith1(:,35));
x36=table2cell(megalith1(:,36));

y1=cell2mat(x1);
y2=cell2mat(x2);
y3=cell2mat(x3);
y4=cell2mat(x4);
y5=cell2mat(x5);
y6=cell2mat(x6);
y7=cell2mat(x7);
y8=cell2mat(x8);
y9=cell2mat(x9);
y10=cell2mat(x10);
y11=cell2mat(x11);
y12=cell2mat(x12);
y13=cell2mat(x13);
y14=cell2mat(x14);
y15=cell2mat(x15);
y16=cell2mat(x16);
y17=cell2mat(x17);
y18=cell2mat(x18);
y19=cell2mat(x19);
y20=cell2mat(x20);
y21=cell2mat(x21);
y22=cell2mat(x22);
y23=cell2mat(x23);
y24=cell2mat(x24);
y25=cell2mat(x25);
y26=cell2mat(x26);
y27=cell2mat(x27);
y28=cell2mat(x28);
y29=cell2mat(x29);
y30=cell2mat(x30);
y31=cell2mat(x31);
y32=cell2mat(x32);
y33=cell2mat(x33);
y34=cell2mat(x34);
y35=cell2mat(x35);
y36=cell2mat(x36);

%% convert to proper index
z1=y1(mainIndex2);
z2=y2(mainIndex2);
z3=y3(mainIndex2);
z4=y4(mainIndex2);
z5=y5(mainIndex2);
z6=y6(mainIndex2);
z7=y7(mainIndex2);
z8=y8(mainIndex2);
z9=y9(mainIndex2);
z10=y10(mainIndex2);
z11=y11(mainIndex2);
z12=y12(mainIndex2);
z13=y13(mainIndex2);
z14=y14(mainIndex2);
z15=y15(mainIndex2);
z16=y16(mainIndex2);
z17=y17(mainIndex2);
z18=y18(mainIndex2);
z19=y19(mainIndex2);
z20=y20(mainIndex2);
z21=y21(mainIndex2);
z22=y22(mainIndex2);
z23=y23(mainIndex2);
z24=y24(mainIndex2);
z25=y25(mainIndex2);
z26=y26(mainIndex2);
z27=y27(mainIndex2);
z28=y28(mainIndex2);
z29=y29(mainIndex2);
z30=y30(mainIndex2);
z31=y31(mainIndex2);
z32=y32(mainIndex2);
z33=y33(mainIndex2);
z34=y34(mainIndex2);
z35=y35(mainIndex2);
z36=y36(mainIndex2);

% newMain
%x=[lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) hrvRest apValues1(:,1) z2 z3 z8 z9 z10 z11 z12 z13 z14 z15 z15 z16 z17 z18 z19 z20 z21 z22 z23 z24 z25 z26 z27 z28 z29 z30 z31 z32 z33 z34 z35 z36];


x=[mainIndex2' lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) hrvRest apValues1(:,1) z2 z3 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19 z20 z21 z22 z23 z24 z25 z26 z27 z28 z29 z30 z31 z32 z33 z34 z36];



XP=[hrvRest lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) apValues1(:,1) mainGen mainAge];


%x=[lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) hrvRest apValues1(:,1) z27 z28 z29 z30];
% top physio: lppAmpFod

%x=[cueHrvTime(:,1) hrvRest apValues1(:,1) z27 z28 z29 z30];


% top predictors outside ACES: fam_conflict, fam_management, fam_proreward
mainData=x;

[data1,labels1]=tryFormat(mainData,z4);
[data2,labels2]=tryFormat(mainData,z5);
[data3,labels3]=tryFormat(mainData,z6);
[data4,labels4]=tryFormat(mainData,z7);

[data1,labels1]=classBalance(data1,labels1,subs);
[data2,labels2]=classBalance(data2,labels2,subs);
[data3,labels3]=classBalance(data3,labels3,subs);
[data4,labels4]=classBalance(data4,labels4,subs);

[z_measures1,z_phi1,z_phiclassic1,z_aucroc1,z_accuracy1,z_sensitivity1,z_specificity1,z_acc21,z_ppv1,z_npv1,z_f1]=lda_adenz_mval(subs,data1,labels1,pvalue);
[z_measures2,z_phi2,z_phiclassic2,z_aucroc2,z_accuracy2,z_sensitivity2,z_specificity2,z_acc22,z_ppv2,z_npv2,z_f12]=lda_adenz_mval(subs,data2,labels2,pvalue);
[z_measures3,z_phi3,z_phiclassic3,z_aucroc3,z_accuracy3,z_sensitivity3,z_specificity3,z_acc23,z_ppv3,z_npv3,z_f13]=lda_adenz_mval(subs,data3,labels3,pvalue);
[z_measures4,z_phi4,z_phiclassic4,z_aucroc4,z_accuracy4,z_sensitivity4,z_specificity4,z_acc24,z_ppv4,z_npv4,z_f14]=lda_adenz_mval(subs,data4,labels4,pvalue);

[mean_measures1,mean_phi1,mean_phiclassic1,mean_aucroc1,mean_accuracy1,mean_sensitivity1,mean_specificity1,mean_acc21,mean_ppv1,mean_npv1,mean_f1]=lda_aden_mval(subs,data1,labels1,pvalue);
[mean_measures2,mean_phi2,mean_phiclassic2,mean_aucroc2,mean_accuracy2,mean_sensitivity2,mean_specificity2,mean_acc22,mean_ppv2,mean_npv2,mean_f12]=lda_aden_mval(subs,data2,labels2,pvalue);
[mean_measures3,mean_phi3,mean_phiclassic3,mean_aucroc3,mean_accuracy3,mean_sensitivity3,mean_specificity3,mean_acc23,mean_ppv3,mean_npv3,mean_f13]=lda_aden_mval(subs,data3,labels3,pvalue);

% outs=[z_phi1 z_phi2 z_phi3 z_phi4 mean_phi1 mean_phi2 mean_phi3 0];
% outacc=[z_accuracy1 z_accuracy2 z_accuracy3 z_accuracy4 mean_accuracy1 mean_accuracy2 mean_accuracy3 0];
% outf1=[z_f1 z_f12 z_f13 z_f14 mean_f1 mean_f12 mean_f13 0]
% try
[mean_measures4,mean_phi4,mean_phiclassic4,mean_aucroc4,mean_accuracy4,mean_sensitivity4,mean_specificity4,mean_acc24,mean_ppv4,mean_npv4,mean_f14]=lda_aden_mval(subs,data4,labels4,pvalue);

zouts=[z_phi1 z_phi2 z_phi3 z_phi4 mean_phi1 mean_phi2 mean_phi3 mean_phi4];
zoutf1=[z_f1 z_f12 z_f13 z_f14 mean_f1 mean_f12 mean_f13 mean_f14]
zoutacc=[z_accuracy1 z_accuracy2 z_accuracy3 z_accuracy4 mean_accuracy1 mean_accuracy2 mean_accuracy3 mean_accuracy4];

xval=comparisonTests(data1,labels1,subs,pvalue,fs);
[dscores,dacc,df1,dphi,ditr]=unwrapStruct(xval);
[u1,~,~,~]=feature_selection_adenz(data1{1}',labels1{1},data1{1}',pvalue);
[u2,~,~,~]=feature_selection_adenz(data2{1}',labels2{1},data2{1}',pvalue);
[u3,~,~,~]=feature_selection_adenz(data3{1}',labels3{1},data3{1}',pvalue);
[u4,~,~,~]=feature_selection_adenz(data4{1}',labels4{1},data4{1}',pvalue);

%z4, z6, z7
% adens: u1=27, u2=38, u3=24, u=31, 21; 13, 21, 24, 27, 31, 38
zz1=z4+z6+z7;
abc=zz1;
dz1=find(zz1>1);
zz1(dz1)=1;
dz0=find(zz1<0);
zz1(dz0)=0;
% level 2 category
%-0: no trauma
%-1: trauma but no PTSD
%-2: trauma and PTSD (lifetime/current)

[data0,labels0]=tryFormat(mainData,zz1);
[data0,labels0]=classBalance(data0,labels0,subs);
[z_measures0,z_phi0,z_phiclassic0,z_aucroc0,z_accuracy0,z_sensitivity0,z_specificity0,z_acc20,z_ppv0,z_npv0,z_f10]=lda_adenz_mval(subs,data0,labels0,pvalue);
[mean_measures0,mean_phi0,mean_phiclassic0,mean_aucroc0,mean_accuracy0,mean_sensitivity0,mean_specificity0,mean_acc20,mean_ppv0,mean_npv0,mean_f10]=lda_aden_mval(subs,data0,labels0,pvalue);
xval=comparisonTests(data0,labels0,subs,pvalue,fs);
[scores,acc,f1,phi,itr]=unwrapStruct(xval);
[u0,~,~,~]=feature_selection_adenz(data0{1}',labels0{1},data0{1}',pvalue);
% compare level 0 vs level 2
[r2,~,~,~]=feature_selection_adenz(mainData,zz1,mainData,pvalue);

zData=zscore(mainData);

%compare level 0 vs level 1
[r1,~,~,~]=feature_selection_adenz(mainData,z4,mainData,pvalue);
% [r2,~,~,~]=feature_selection_adenz(mainData,z5,mainData,pvalue);
% [r3,~,~,~]=feature_selection_adenz(mainData,z6,mainData,pvalue);
% [r4,~,~,~]=feature_selection_adenz(mainData,z7,mainData,pvalue);
% 
% 
% csvwrite('tryPrimeData.csv', mainData);
% csvwrite('tryLabels10.csv', z4);
% csvwrite('tryLabels20.csv', zz1);
% csvwrite('tryLabels30.csv', abc);

% csvwrite('tryZData.csv', zData)




kAs=find(hrvRest~=0);
Vr1=hrvRest(kAs);

Xr1=1:length(Vr1);
Xq1=1:1:193;
Vq1 = interp1(Xr1,Vr1,Xq1)';
p = polyfit(Xr1,Vr1,3);
Vq1 = polyval(p,Xq1)';

outVal = Vq1(randperm(size(Vq1,1)),:);

megalith2 = readtable('lifetime_ad_variable.csv');
xy1=table2cell(megalith2(:,1));
xy2=table2cell(megalith2(:,2));
yy1=cell2mat(xy1);
yy2=cell2mat(xy2);
mz2=yy2(mainIndex2);
pvalue=1;
[m2,~,~,~]=feature_selection_adenz(mainData,mz2,mainData,pvalue);
[datam,labelsm]=tryFormat(mainData,mz2);
[datam,labelsm]=classBalance(datam,labelsm,subs);
[m_measures0,m_phi0,m_phiclassic0,m_aucroc0,m_accuracy0,m_sensitivity0,m_specificity0,m_acc20,m_ppv0,m_npv0,m_f10]=lda_adenz_mval(subs,data0,labels0,pvalue);

xval=comparisonTests(datam,labelsm,subs,pvalue,fs);
[scores,acc,f1,phi,itr]=unwrapStruct(xval);
%csvwrite('tryLabelsAD.csv', mz2);
% add GAD. Better as a label than a feature. 
% mainData(:,38)=mz2;
% [m3,~,~,~]=feature_selection_adenz(mainData,mz2,mainData,pvalue);
% [datam,labelsm]=tryFormat(mainData,mz2);
% [datam,labelsm]=classBalance(datam,labelsm,subs);
% [m_measures0,m_phi0,m_phiclassic0,m_aucroc0,m_accuracy0,m_sensitivity0,m_specificity0,m_acc20,m_ppv0,m_npv0,m_f10]=lda_adenz_mval(subs,data0,labels0,pvalue);
% 
% xval=comparisonTests(datam,labelsm,subs,pvalue,fs);
% [scores,acc,f1,phi,itr]=unwrapStruct(xval);


[datam1,labelsm1]=tryFormat(XP,mz2);
[d1,l1]=classBalance(datam1,labelsm1,subs);
[m_measures0,m_phi0,m_phiclassic0,m_aucroc0,m_accuracy0,m_sensitivity0,m_specificity0,m_acc20,m_ppv0,m_npv0,m_f10]=lda_adenz_mval(subs,d1,l1,pvalue);
[m12,~,~,~]=feature_selection_adenz(XP,mz2,XP,pvalue);
xval=comparisonTests(d1,l1,subs,pvalue,fs);
[scores,acc,f1,phi,itr]=unwrapStruct(xval);



xs=[mainIndex2' lppAmpNeuValues(:,1) lppAmpAlcValues(:,1) lppAmpFodValues(:,1) cueHrvTime(:,1) hrvRest apValues1(:,1) z2 z8 z9 z10 z11 z12 z13 z14 z15 z16 z17 z18 z19 z20 z21 z22 z23 z24 z25 z26 z27 z28 z29 z30 z31 z32 z33 z34 z36];
xsLabels=z3;
sz0=find(xsLabels==2);
xsLabels(sz0)=0;

[sd,~,~,~]=feature_selection_adenz(xs,xsLabels,xs,pvalue);

% main feature between genders: BPA

% gender 1
xsl1=find(xsLabels==1);

xs1=xs(xsl1,:);
xsLab1=z4(xsl1);

% gender2
xs2=xs(sz0,:);
xsLab2=z4(sz0);
%z4,zz1

% gender 1 tests

[xd1,xl1]=tryFormat(xs1,xsLab1);
[xd1,xl1]=classBalance(xd1,xl1,subs);
%[m_measures0,m_phi0,m_phiclassic0,m_aucroc0,m_accuracy0,m_sensitivity0,m_specificity0,m_acc20,m_ppv0,m_npv0,m_f10]=lda_adenz_mval(subs,d1,l1,pvalue);
xval=comparisonTests(xd1,xl1,subs,pvalue,fs);
[scores,x1acc,x1f1,x1phi,x1itr]=unwrapStruct(xval);

[sd1,~,~,~]=feature_selection_adenz(xs1,xsLab1,xs1,pvalue);

% gender 2 tests
[xd2,xl2]=tryFormat(xs2,xsLab2);
[xd2,xl2]=classBalance(xd2,xl2,subs);
%[m_measures0,m_phi0,m_phiclassic0,m_aucroc0,m_accuracy0,m_sensitivity0,m_specificity0,m_acc20,m_ppv0,m_npv0,m_f10]=lda_adenz_mval(subs,d1,l1,pvalue);
xval=comparisonTests(xd2,xl2,subs,pvalue,fs);
[scores,x2acc,x2f1,x2phi,x2itr]=unwrapStruct(xval);
[sd2,~,~,~]=feature_selection_adenz(xs2,xsLab2,xs2,pvalue);
% Just an update on AI classification of GAD.
% 
% Without the psychosocial metrics, the top feature is age.
% 
% Accuracy is about 60%, with an F1 score around 0.76.
% 
% Parental and family scores seem to be best predictors thus far, as with
% trauma/PTSD.
% 
% When dealing with gender differences, the biggest difference between genders was BPA.
% 
% When running analysis between male and female, the two top features were sub_parent_environment and fam_manage.
% 
% We can separate a patient with a pathology (trauma, PTSD) away from baseline ones easily enough (75% acc). Not much difference between specific subs in terms of 'easier to automatically classify.'
