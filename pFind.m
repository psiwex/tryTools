function [X]=pFind(X,p)

%--------------------------------------------------------------------------
 % CLEANUP

 % Last updated: June 2013, J. LaRocco

 % Details: Removes Infs and NaNs. 
 
 % Usage:
 % [X]=prototype_cleanup(X)
 
 % Input: 
 %  X: Input data matrix.   
 %  p: p threshold

 % Output: 
 %  X: Cleaned data matrix.    
    
%--------------------------------------------------------------------------
X_nanindices=find(X>=p);

X(X_nanindices)=[];
