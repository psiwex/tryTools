clear;
clc;

%t tests for TRY
numSamples=60;
load('tryCompareRestCue.mat',"tryBatch");
restMeanTime=(tryBatch{1});
restStdTime=(tryBatch{2});
cueMeanTime=(tryBatch{3});
cueStdTime=tryBatch{4};

apValues=tryBatch{11};
apstdValues=tryBatch{12};
apValues1=tryBatch{13};
apstdValues1=tryBatch{14};

restHrvMeanTime=tryBatch{31};
restHrvStdTime=tryBatch{32};
cueHrvTime=tryBatch{33};
cueHrvStdTime=tryBatch{34};


%% round 1 tests
% tests: Rest vs Cue
% rest1 vs rest2
% cue1 vs cue2
[subs,sessions]=size(cueMeanTime);
%test1: all rest vs all cue
rest=restMeanTime(:);
restsig=restStdTime(:);
cue=cueMeanTime(:);
cuesig=cueStdTime(:);

[h1,p1]=ttest2(cue,rest);
%test2: rest1 vs rest2
[h2,p2]=ttest2(restMeanTime(:,1),restMeanTime(:,2));
%test3: cue1 vs cue2
[h3,p3]=ttest2(cueMeanTime(:,1),cueMeanTime(:,2));

% test 4: hr and alpha
[h81,p81]=ttest2(cueMeanTime(:,1),apValues(:,1));
[h82,p82]=ttest2(cueMeanTime(:,2),apValues(:,2));
[h91,p91]=ttest2(restMeanTime(:,1),apValues1(:,1));
[h92,p92]=ttest2(restMeanTime(:,2),apValues1(:,2));


% test 5: hrv
[h01,p01]=ttest2(restHrvMeanTime(:),cueHrvTime(:));
%test2: rest1 vs rest2
[h02,p02]=ttest2(restHrvMeanTime(:,1),restHrvMeanTime(:,2));
%test3: cue1 vs cue2
[h03,p03]=ttest2(cueHrvTime(:,1),cueHrvTime(:,2));


testR2C1=[];
testR1C2=[];

testR1C1=[];
testR2C2=[];

% alpha
atestR2C1=[];
atestR1C2=[];

atestR1C1=[];
atestR2C2=[];

% hrv
hrvtestR2C1=[];
hrvtestR1C2=[];

hrvtestR1C1=[];
hrvtestR2C2=[];

% phi
phiS1C=[];
phiS1R=[];

phiS2C=[];
phiS2R=[];

hrvphiS1C=[];
hrvphiS1R=[];

hrvphiS2C=[];
hrvphiS2R=[];

atestR1C1=[];
atestR2C2=[];


resid1=[];
resid2=[];

presid=[];


aresid1=[];
aresid2=[];

apresid=[];

hrvresid1=[];
hrvresid2=[];

hrvpresid=[];

[synSubs,~]=size(restMeanTime);

h1Mean=mean(cleanUp(cueMeanTime(:,1)));
h2Mean=mean(cleanUp(cueMeanTime(:,2)));

h1Std=std(cleanUp(cueMeanTime(:,1)));
h2Std=std(cleanUp(cueMeanTime(:,2)));

newCueMean1= h1Mean + h1Std.*randn(synSubs, 1);
newCueMean2= h2Mean + h2Std.*randn(synSubs, 1);
newCue=[newCueMean1 newCueMean2];
cueMeanTime=newCue;
tryBatch{3}=cueMeanTime;

%% round 2 tests
%samples = mu + sigma.*randn(numSamples, 1);
ki=1;

X=linspace(1,numSamples,numSamples);
n=1; %order of model
for ki=1:subs
% initialize means
sess1c=cueMeanTime(ki,1);
sess1r=restMeanTime(ki,1);

sess2c=cueMeanTime(ki,2);
sess2r=restMeanTime(ki,2);

hrvsess1c=cueHrvTime(ki,1);
hrvsess1r=restHrvMeanTime(ki,1);

hrvsess2c=cueHrvTime(ki,2);
hrvsess2r=restHrvMeanTime(ki,2);


asess1c=apValues1(ki,1);
asess1r=apValues(ki,1);

asess2c=apValues1(ki,2);
asess2r=apValues(ki,2);

% stdevs
sig1c=cueStdTime(ki,1);
sig1r=restStdTime(ki,1);

sig2c=cueStdTime(ki,2);
sig2r=restStdTime(ki,2);

asig1c=apstdValues1(ki,1);
asig1r=apstdValues(ki,1);

asig2c=apstdValues1(ki,2);
asig2r=apstdValues(ki,2);

hrvsig1c=cueHrvStdTime(ki,1);
hrvsig1r=restHrvStdTime(ki,1);

hrvsig2c=cueHrvStdTime(ki,2);
hrvsig2r=restHrvStdTime(ki,2);


% generate
% hr
s1c = sess1c + sig1c.*randn(numSamples, 1);
s1r = sess1r + sig1r.*randn(numSamples, 1);

s2c = sess2c + sig2c.*randn(numSamples, 1);
s2r = sess2r + sig2r.*randn(numSamples, 1);
% alpha

as1c = asess1c + asig1c.*randn(numSamples, 1);
as1r = asess1r + asig1r.*randn(numSamples, 1);

as2c = asess2c + asig2c.*randn(numSamples, 1);
as2r = asess2r + asig2r.*randn(numSamples, 1);

% hrv
hrvs1c = hrvsess1c + hrvsig1c.*randn(numSamples, 1);
hrvs1r = hrvsess1r + hrvsig1r.*randn(numSamples, 1);

hrvs2c = hrvsess2c + hrvsig2c.*randn(numSamples, 1);
hrvs2r = hrvsess2r + hrvsig2r.*randn(numSamples, 1);




% ttests 2
[h21,p21]=ttest2(s1c,s2r);
[h22,p22]=ttest2(s1c,s1r);
[h23,p23]=ttest2(s2c,s2r);
[h24,p24]=ttest2(s2c,s1r);

[h31,p31]=ttest2(as1c,as2r);
[h32,p32]=ttest2(as1c,as1r);
[h33,p33]=ttest2(as2c,as2r);
[h34,p34]=ttest2(as2c,as1r);

[h011,p011]=ttest2(hrvs1c,hrvs2r);
[h012,p012]=ttest2(hrvs1c,hrvs1r);
[h013,p013]=ttest2(hrvs2c,hrvs2r);
[h014,p014]=ttest2(hrvs2c,hrvs1r);


[~,P]=corrcoef(s1c,as1c);
Ps1c=P(1,2);

[~,P]=corrcoef(s2c,as2c);
Ps2c=P(1,2);

[~,P]=corrcoef(s1r,as1r);
Ps1r=P(1,2);

[~,P]=corrcoef(s2r,as2r);
Ps2r=P(1,2);


[~,P]=corrcoef(hrvs1c,as1c);
Phs1c=P(1,2);

[~,P]=corrcoef(hrvs2c,as2c);
Phs2c=P(1,2);

[~,P]=corrcoef(hrvs1r,as1r);
Phs1r=P(1,2);

[~,P]=corrcoef(hrvs2r,as2r);
Phs2r=P(1,2);



phiS1C=[phiS1C; Ps1c];
phiS1R=[phiS1R; Ps1r];

phiS2C=[phiS2C; Ps2c];
phiS2R=[phiS2R; Ps2r];

hrvphiS1C=[hrvphiS1C; Phs1c];
hrvphiS1R=[hrvphiS1R; Phs1r];

hrvphiS2C=[hrvphiS2C; Phs2c];
hrvphiS2R=[hrvphiS2R; Phs2r];


testR2C1=[testR2C1; p21];
testR1C2=[testR1C2; p24];

testR1C1=[testR1C1; p22];
testR2C2=[testR1C2; p23];

atestR2C1=[atestR2C1; p31];
atestR1C2=[atestR1C2; p34];

atestR1C1=[atestR1C1; p32];
atestR2C2=[atestR1C2; p33];

hrvtestR2C1=[hrvtestR2C1; p011];
hrvtestR1C2=[hrvtestR1C2; p014];

hrvtestR1C1=[hrvtestR1C1; p012];
hrvtestR2C2=[hrvtestR1C2; p013];


%% residuals
% regress baseline out of cue
% lmfit each
% remove rest from cue
% plot sess 1 vs sess 2
% residual = data – fit


ps1c = polyfit(X,s1c,n);
ps1r = polyfit(X,s1r,n);
ps2c = polyfit(X,s2c,n);
ps2r = polyfit(X,s2r,n);
% apply fitted poly
zs1c = polyval(ps1c,X);
zs1r = polyval(ps1r,X);
zs2c = polyval(ps2c,X);
zs2r = polyval(ps2r,X);

session1=zs1r-zs1c;
session2=zs2r-zs2c;
resid1(ki,:)=session1;
resid2(ki,:)=session2;
[hres,pres]=ttest2(session1,session2);
presid(ki)=pres;
% test phi for residudal vs. alpha
aps1c = polyfit(X,as1c,n);
aps1r = polyfit(X,as1r,n);
aps2c = polyfit(X,as2c,n);
aps2r = polyfit(X,as2r,n);

azs1c = polyval(aps1c,X);
azs1r = polyval(aps1r,X);
azs2c = polyval(aps2c,X);
azs2r = polyval(aps2r,X);

asession1=azs1r-azs1c;
asession2=azs2r-azs2c;
aresid1(ki,:)=asession1;
aresid2(ki,:)=asession2;
[ahres,apres]=ttest2(asession1,asession2);
apresid(ki)=apres;



hrvzs1c = polyval(hrvs1c,X);
hrvzs1r = polyval(hrvs1r,X);
hrvzs2c = polyval(hrvs2c,X);
hrvzs2r = polyval(hrvs2r,X);

hrvsession1=hrvzs1r-hrvzs1c;
hrvsession2=hrvzs2r-hrvzs2c;
hrvresid1(ki,:)=hrvsession1;
hrvresid2(ki,:)=hrvsession2;
[hrvhres,hrvpres]=ttest2(hrvsession1,hrvsession2);
hrvpresid(ki)=hrvpres;

% [~,P]=corrcoef(zs1c,as1c);
% Ps1c=P(1,2);
% 
% [~,P]=corrcoef(zs2c,as2c);
% Ps2c=P(1,2);
% 
% [~,P]=corrcoef(zs1r,as1r);
% Ps1r=P(1,2);
% 
% [~,P]=corrcoef(zs2r,as2r);
% Ps2r=P(1,2);

% 
% phiS1C=[phiS1C; Ps1c];
% phiS1R=[phiS1R; Ps1r];
% 
% phiS2C=[phiS2C; Ps2c];
% phiS2R=[phiS2R; Ps2r];

end
tryBatch{5}=testR2C1;
tryBatch{6}=testR1C2;
tryBatch{7}=testR1C1;
tryBatch{8}=testR2C2;
tryBatch{9}=presid;

tryBatch{15}=atestR2C1;
tryBatch{16}=atestR1C2;
tryBatch{17}=atestR1C1;
tryBatch{18}=atestR2C2;

tryBatch{19}=phiS1C;
tryBatch{20}=phiS1R;
tryBatch{21}=phiS2C;
tryBatch{22}=phiS2R;

tryBatch{23}=apresid;

tryBatch{35}=hrvphiS1C;
tryBatch{36}=hrvphiS1R;
tryBatch{37}=hrvphiS2C;
tryBatch{38}=hrvphiS2R;

tryBatch{39}=hrvpresid;

save('tryCompareRestCue.mat',"tryBatch");



