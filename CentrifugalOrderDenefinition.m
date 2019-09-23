function [IndexofCentrifugalOrder,CentrifugalOrder,IndexBasedonCentrifugalOrder,NUniSegments,NSegments]=CentrifugalOrderDenefinition(NeededNeurite,CControalBranchingMemory)         

IndexofCentrifugalOrder=cellfun('isempty',NeededNeurite);
for ID1=1:size(IndexofCentrifugalOrder,1)
   for ID2=1:size(IndexofCentrifugalOrder,2)
        IndexofCentrifugalOrder(ID1,ID2)=(1-IndexofCentrifugalOrder(ID1,ID2));
   end
end
IndexofCentrifugalOrder=double(IndexofCentrifugalOrder);

UsedforNSegments=double(cellfun('isempty',NeededNeurite));
for ID1=1:size(UsedforNSegments,1)
   for ID2=1:size(UsedforNSegments,2)
        UsedforNSegments(ID1,ID2)=(1-UsedforNSegments(ID1,ID2))*size(NeededNeurite{ID1,ID2},1);
   end
end
NSegments=sum(sum(UsedforNSegments));

UsedforNUniSegments=double(cellfun('isempty',NeededNeurite));
for ID1=1:size(UsedforNUniSegments,1)
   for ID2=1:size(UsedforNUniSegments,2)
        UsedforNUniSegments(ID1,ID2)=(1-UsedforNUniSegments(ID1,ID2));
   end
end
NUniSegments=sum(sum(UsedforNUniSegments));

CentrifugalOrder=IndexofCentrifugalOrder;
for ID3=1:size(CentrifugalOrder,1)-1
     for ID4=1:size(CentrifugalOrder,2)/2
           if CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4-1)+CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4)==0
                CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)=CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)+CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4-1)+CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4);
           else
               CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)=CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4-1)+CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4);
           end
     end
end

IndexBasedonCentrifugalOrder=zeros(size(IndexofCentrifugalOrder,1),size(IndexofCentrifugalOrder,2));
for ID3=1:size(CentrifugalOrder,1)-1
     for ID4=1:size(CentrifugalOrder,2)/2
         if CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)~=0
          IndexBasedonCentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)=2^(-CControalBranchingMemory*CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4));
         end
     end
end

% for IDLength=1:size(NeededNeurite,1)-1
%      if (isempty(cell2mat(NeededNeurite(IDLength,:)))~=1)&&((isempty(cell2mat(NeededNeurite(IDLength+1,:)))==1))
%         IDLengthNeeded=IDLength;
%      break;
%      end
% end