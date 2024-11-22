load('varTry.mat')

x=varTry';

% figure;
% plot(x)
% 
% x1=downsample(x,2);
% figure;
% plot(x1)
% 
% 
% x2=downsample(x,3);
% figure;
% plot(x2)
% 


table1 = readtable('drinksWave.xlsx');
table2 = readtable('drinksBinge.xlsx');

drinkWave=table2cell(table1);
drinkBingge=table2cell(table2);

cellWave=cell2mat(drinkWave(:,2:end));
cellBinge=cell2mat(drinkBingge(:,2:end));

cellWave=prototype_cleanup(cellWave);
cellBinge=prototype_cleanup(cellBinge);

endWave=downsample(cellWave',2);
endBinge=downsample(cellBinge',4);

endWave=round(endWave);
endBinge=round(endBinge);

[taxWave]=trajectoryTax(endWave);
[taxBinge]=trajectoryTax(endBinge);

thresPer=.15;
[elWave]=elasticNet(taxWave,thresPer);
[elBinge]=elasticNet(taxBinge,thresPer);

[outWave]=trajAverager(elWave,endWave);
[outBinge]=trajAverager(elBinge,endBinge);

scaledWave=outWave./max(outWave);
scaledBinge=outBinge./max(outBinge);


% figure;
% hist(taxWave,unique(taxWave))
% title('Wave Trajectory Types')
% 
% figure;
% hist(taxBinge,unique(taxBinge))
% title('Binge Trajectory Types')
% 
% figure;
% plot(endWave)
% title('Wave Trajectory Archetypes')
% 
% figure;
% plot(endBinge)
% title('Binge Trajectory Archetypes')

figure;
hist(elWave,unique(elWave))
title('Scaled Wave Trajectory Types')

figure;
hist(elBinge,unique(elBinge))
title('Scaled Binge Trajectory Types')

figure;
plot(scaledWave)
title('Scaled Wave Trajectory Archetypes')
%legend('1','2','3')
figure;
plot(scaledBinge)
title('Scaled Binge Trajectory Archetypes')
%legend('2','3')

