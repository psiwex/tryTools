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

%pSoc=[tryDems tryPsoc(:,[1:12]) tryPsoc(:,[14:103])];

%% export
% csvwrite('psocMetrics.csv', pSoc);
% csvwrite('pzocMetrics.csv', zscore(pSoc));
% csvwrite('psocLabels.csv', trajValue);

%features:  0   9  18  40  41  42  43  50  52  59  95 101 107, 24  27  31  34  50  67  86  89 107
x1=[  0   9  18  40  41  42  43  50  52  59  95 101 107  0   9  18  40  41  42  43  50  52  59  95 101 107];
x2=unique(x1);

% 0	9	18	40	41	42	43	50	52	59	95	101	107


%% four class breakdown
[sData01,sLabels01]=booleanCat(0,1,pSoc,trajValue);
[sData02,sLabels02]=booleanCat(0,2,pSoc,trajValue);
[sData03,sLabels03]=booleanCat(0,3,pSoc,trajValue);
[sData12,sLabels12]=booleanCat(1,2,pSoc,trajValue);
[sData13,sLabels13]=booleanCat(1,3,pSoc,trajValue);
[sData23,sLabels23]=booleanCat(2,3,pSoc,trajValue);


[sFeatures01]=featureRanks(sData01,sLabels01);
[sFeatures02]=featureRanks(sData02,sLabels02);
[sFeatures03]=featureRanks(sData03,sLabels03);
[sFeatures12]=featureRanks(sData12,sLabels12);
[sFeatures13]=featureRanks(sData13,sLabels13);
[sFeatures23]=featureRanks(sData23,sLabels23);


[sOuts01,sRow01]=featureScanner(sData01,sLabels01);
[sOuts02,sRow02]=featureScanner(sData02,sLabels02);
[sOuts03,sRow03]=featureScanner(sData03,sLabels03);
[sOuts12,sRow12]=featureScanner(sData12,sLabels12);
[sOuts13,sRow13]=featureScanner(sData13,sLabels13);
[sOuts23,sRow23]=featureScanner(sData23,sLabels23);



% csvwrite('psData01.csv', prototype_cleanup(sData01));
% csvwrite('psData02.csv', prototype_cleanup(sData02));
% csvwrite('psData03.csv', prototype_cleanup(sData03));
% csvwrite('psData12.csv', prototype_cleanup(sData12));
% csvwrite('psData13.csv', prototype_cleanup(sData13));
% csvwrite('psData23.csv', prototype_cleanup(sData23));
 
% csvwrite('psLabels01.csv', prototype_cleanup(sLabels01));
% csvwrite('psLabels02.csv', prototype_cleanup(sLabels02));
% csvwrite('psLabels03.csv', prototype_cleanup(sLabels03));
% csvwrite('psLabels12.csv', prototype_cleanup(sLabels12));
% csvwrite('psLabels13.csv', prototype_cleanup(sLabels13));
% csvwrite('psLabels23.csv', prototype_cleanup(sLabels23));

%0v1: [24 27 33 67]
%0v2: [24 31 34]
%0v3: [24 31 34 47 50 69 89]
%1v2: [24 31 34]
%1v3: [24 31 49 50 86 95]
%2v3: [24 34 50 86 90 93]
% top: topSoc=[24, 31, 34, 50]
topSoc=[24, 31, 34, 50];
pSocClassFeatures=topSoc+1;
%25: ucla_impaired_caregiver, r=0.04
%32: dass_dep, r=0.24
%35: ssi_total, r=0.17
%51: bpa_verbal, r=0.34
mainFeature=25;
traumaGroup=6;

%[r,p]=corrcoef(pSoc(:,mainFeature),tryDems(:,traumaGroup));


sRow01(sOuts01)
sRow02(sOuts02)
sRow03(sOuts03)
sRow12(sOuts12)
sRow13(sOuts13)
sRow23(sOuts23)


% new cases
sOuts01 %41, r=0.41, aces_total
sOuts02 %44, r=0.60, dmqr_cope_depression
sOuts03 %96, r=0.30, ctq_phsy_neglect
sOuts12 %42, r=0.31, dmqr_social
sOuts13 %96, r=0.25, ctq_phsy_neglect
sOuts23 %10, r=0.31, ucla_phys_abuse
% 10: ucla_phys_abuse
% 41: aces_total
% 42: dmqr_social
% 44: dmqr_cope_depression
% 96: ctq_phsy_neglect


interCase=unique([sOuts01,sOuts02,sOuts03,sOuts12,sOuts13,sOuts23]);

x1=[0  9 33 40 43]; 
x2=[40 41 43];
x3=[18  40  43  50  52  95 105];
x4=[9 41 59];
x5=[7 18 44 50 59 95 97];
x6=[0   9  41  43  44  84 100];

X=[x1 x2 x3 x4 x5 x6];

xx=unique(X);
xaaa=xx+1;



