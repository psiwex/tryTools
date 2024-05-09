function [X]=cleanZero(X)

%--------------------------------------------------------------------------
 % CLEANZERO

 % Last updated: June 2013, J. LaRocco

 % Details: Removes Infs and NaNs with zeros. 
 
 % Usage:
 % [X]=cleanZero(X)
 
 % Input: 
 %  X: Input data matrix.   

 % Output: 
 %  X: Cleaned data matrix.    
    
%--------------------------------------------------------------------------


%gets rid of NaNs and Infs
X_nanindices=isnan(X);

X(X_nanindices==1)=0;

X_infindices=isinf(X);

X(X_infindices==1)=0;


end