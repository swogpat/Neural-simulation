function [SearchSpace]=EnvelopeCreateFunction(EnvelopeType)
if EnvelopeType==1
    [X,Y,Z]=meshgrid([1,0,-1],[1,0,-1],[1,0,-1]);
    SearchSpace=[X(:),Y(:),Z(:)];
elseif EnvelopeType==2
    [X,Y,Z]=meshgrid([1,0,-1],[1,0,-1],[1,0,-1]);
    PreSearchSpace=[X(:),Y(:),Z(:)];
    SearchSpace=PreSearchSpace;
    for ID1=1:size(SearchSpace,1)
         if abs(PreSearchSpace(ID1,1))+abs(PreSearchSpace(ID1,2))+abs(PreSearchSpace(ID1,3))~=1
             SearchSpace(ID1,:)=zeros(1,size(SearchSpace,2));
         end
    end 
    SearchSpace(all(SearchSpace==0,2),:)=[];
end