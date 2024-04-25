load('tryCompareRestCue.mat',"tryBatch");
p=.05;
testR2C1=tryBatch{5};
testR1C2=tryBatch{6};

testR1C1=tryBatch{7};
testR2C2=tryBatch{8};
l1=length(testR2C1);
l2=length(testR1C2);
l3=length(testR1C1);
l4=length(testR2C2);

tR2C1=cleanUp(testR2C1);
tR1C2=cleanUp(testR1C2);
tR1C1=cleanUp(testR1C1);
tR2C2=cleanUp(testR2C2);

[ptR2C1]=pFind(tR2C1,p);
[ptR1C2]=pFind(tR1C2,p);
[ptR1C1]=pFind(tR1C1,p);
[ptR2C2]=pFind(tR2C2,p);

prtR2C1=length(ptR2C1)/l1;
prtR1C2=length(ptR1C2)/l2;
prtR1C1=length(ptR1C1)/l3;
prtR2C2=length(ptR2C2)/l4;

prtgR2C1=length(ptR2C1)/length(tR2C1);
prtgR1C2=length(ptR1C2)/length(tR1C2);
prtgR1C1=length(ptR1C1)/length(tR1C1);
prtgR2C2=length(ptR2C2)/length(tR2C2);


