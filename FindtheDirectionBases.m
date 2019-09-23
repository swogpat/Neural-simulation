function DirectionBased=FindtheDirectionBases(A,B,CellofSingleDirectiononSingleNeurites)
DirectionBasedMatrix=[];
% B=B+mod(B,2);
%  while (A>1)&&(B>0)
%      DirectionBasedMatrix=[DirectionBasedMatrix; CellofSingleDirectiononSingleNeurites{A,B}];
%      A=A-1;
%      B=ceil(B/2);
%  end
if A~=1
 A=A-1;
 B=ceil(B/2);
 DirectionBasedMatrix=[DirectionBasedMatrix; CellofSingleDirectiononSingleNeurites{A,B}];
else
  A=1;
  B=1;
  DirectionBasedMatrix=[DirectionBasedMatrix; CellofSingleDirectiononSingleNeurites{A,B}];
end
DirectionBased=sum(DirectionBasedMatrix)/size(DirectionBasedMatrix,1);
