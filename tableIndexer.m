function [mainIndex,mainDex3]=tableIndexer(subNames,nameList)

%--------------------------------------------------------------------------
 % TABLEINDEXER

 % Last updated: November 18 2024, J. LaRocco

 % Details: Retrieve existing subjects from a table of data. 
 
 % Usage:
 % [mainIndex3,mainDex3]=tableIndexer(subNames,nameList)
 
 % Input: 
 %  subNames: Cell of strings for subject names.   
 %  nameList: Cell of strings for subject names, from new table. 

 % Output: 
 %  mainIndex3: Double array of indices for where each subject is.
 %  mainDex3: Cell of strings with subject names for new indices.
    
%--------------------------------------------------------------------------

mainIndex3=[];
mainDex3={};
subInd=1;

for ki=1:length(subNames)
subNum=subNames{ki};

for iii=1:length(nameList)

    strCell=nameList{iii};
%tf = contains(str, substr, 'IgnoreCase', true)
tf = contains(strCell, subNum, 'IgnoreCase', true);

ind=find(ismember(nameList,subNum));
if tf==1
%if any(strfind(nameList,subNum))
% Do Something
mainDex3{subInd}=subNum;

mainIndex3(ki)=iii;
subInd=subInd+1;

else
% Do Something else

end
end

mainIndex = (find(mainIndex3~=0));


end
