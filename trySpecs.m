load('tryCompareRestCue.mat',"tryBatch");
p=.05;
testR2C1=tryBatch{5};
testR1C2=tryBatch{6};

testR1C1=tryBatch{7};
testR2C2=tryBatch{8};
testresid=tryBatch{9};

atestresid=tryBatch{23};


hrvtestresid=tryBatch{39};

l1=length(testR2C1);
l2=length(testR1C2);
l3=length(testR1C1);
l4=length(testR2C2);
l5=length(testresid);
l6=length(atestresid);
l7=length(hrvtestresid);

tR2C1=cleanUp(testR2C1);
tR1C2=cleanUp(testR1C2);
tR1C1=cleanUp(testR1C1);
tR2C2=cleanUp(testR2C2);
tRes=cleanUp(testresid);
atRes=cleanUp(atestresid);
hrvtRes=cleanUp(hrvtestresid);

[ptR2C1]=pFind(tR2C1,p);
[ptR1C2]=pFind(tR1C2,p);
[ptR1C1]=pFind(tR1C1,p);
[ptR2C2]=pFind(tR2C2,p);
[ptRes]=pFind(tRes,p);
[aptRes]=pFind(atRes,p);
[hrvptRes]=pFind(hrvtRes,p);

prtR2C1=length(ptR2C1)/l1;
prtR1C2=length(ptR1C2)/l2;
prtR1C1=length(ptR1C1)/l3;
prtR2C2=length(ptR2C2)/l4;
prtRes=length(ptRes)/l5;
aprtRes=length(aptRes)/l6;
hrvprtRes=length(hrvptRes)/l7;

prtgR2C1=length(ptR2C1)/length(tR2C1);
prtgR1C2=length(ptR1C2)/length(tR1C2);
prtgR1C1=length(ptR1C1)/length(tR1C1);
prtgR2C2=length(ptR2C2)/length(tR2C2);
prtgResid=length(ptRes)/length(tRes);
aprtgResid=length(aptRes)/length(atRes);
hrvprtgResid=length(hrvptRes)/length(hrvtRes);

phiS1C=tryBatch{19};
phiS1R=tryBatch{20};
phiS2C=tryBatch{21};
phiS2R=tryBatch{22};

phiMeanS1C=mean(cleanUp(phiS1C));
phiMeanS1R=mean(cleanUp(phiS1R));
phiMeanS2C=mean(cleanUp(phiS2C));
phiMeanS2R=mean(cleanUp(phiS2R));

phiStdS1C=std(cleanUp(phiS1C));
phiStdS1R=std(cleanUp(phiS1R));
phiStdS2C=std(cleanUp(phiS2C));
phiStdS2R=std(cleanUp(phiS2R));

hrvphiS1C=tryBatch{35};
hrvphiS1R=tryBatch{36};
hrvphiS2C=tryBatch{37};
hrvphiS2R=tryBatch{38};

phiMeanHrvS1C=mean(cleanUp(hrvphiS1C));
phiMeanHrvS1R=mean(cleanUp(hrvphiS1R));
phiMeanHrvS2C=mean(cleanUp(hrvphiS2C));
phiMeanHrvS2R=mean(cleanUp(hrvphiS2R));

phiStdHrvS1C=std(cleanUp(hrvphiS1C));
phiStdHrvS1R=std(cleanUp(hrvphiS1R));
phiStdHrvS2C=std(cleanUp(hrvphiS2C));
phiStdHrvS2R=std(cleanUp(hrvphiS2R));

