function [data,labels]=tryFormat(mainData,gLabels)

%--------------------------------------------------------------------------
 % DATAFORMAT

 % Last updated: Jan 2016, J. LaRocco

 % Details: Function reformats TRY data so ICTOMI can handle it. The function merely
%           reformats data into cells and matrices (randomly reorganized). 

% Usage: [data,labels]=dataFormat(pf1,pf2);
% Inputs: 
 %  mainData: Matrix of features with dimensions observations by features.
 %  gLabels: Labels with dimensions 1 by observations (only with 0 and 1).

 % Outputs: 

%   data: 2 cells of randomized data.
%   labels: 2 cells of randomized targets for data.
   
%--------------------------------------------------------------------------
inds0=find(gLabels==0);
inds1=find(gLabels==1);

x0=mainData(inds0,:);
x1=mainData(inds1,:);

x0=x0';
x1=x1';

[a,b]=size(x0); [c,d]=size(x1);
t0=zeros(1,b);

t1=ones(1,d);

x=[x0 x1]; t=[t0 t1];
pp=length(t);
p=randperm(pp);
centerpoint=ceil(.5*pp);
startpoint=centerpoint+1;
x=prototype_cleanup(x);
x2=x(:,p); t1=t(p);

data=[];
labels=[];

data{1}=x2(:,1:centerpoint);

labels{1}=t1(:,1:centerpoint);

data{2}=x2(:,startpoint:pp);

labels{2}=t1(:,startpoint:pp);



end

