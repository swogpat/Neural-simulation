IndexofCentrifugalOrder=cellfun('isempty',NeededNeurite);
for ID1=1:size(IndexofCentrifugalOrder,1)
   for ID2=1:size(IndexofCentrifugalOrder,2)
        IndexofCentrifugalOrder(ID1,ID2)=1-IndexofCentrifugalOrder(ID1,ID2);
   end
end

CentrifugalOrder=IndexofCentrifugalOrder;
for ID3=1:size(CentrifugalOrder,1)-1
     for ID4=1:size(CentrifugalOrder,2)/2
     CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)=CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4-1)+CentrifugalOrder(size(CentrifugalOrder,1)-ID3+1,2*ID4);
     end
end
 if CentrifugalOrder(1,1)==0
         CentrifugalOrder(1,1)=1;
 end

IndexBasedonCentrifugalOrder=zeros(size(IndexofCentrifugalOrder,1),size(IndexofCentrifugalOrder,2));
for ID3=1:size(CentrifugalOrder,1)-1
     for ID4=1:size(CentrifugalOrder,2)/2
         if CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)~=0
          IndexBasedonCentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4)=2^(-CControalBranchingMemory*CentrifugalOrder(size(CentrifugalOrder,1)-ID3,ID4));
         end
     end
end

for IDLength=1:size(NeededNeurite,1)-1
    disp(IDLength);
     if (isempty(cell2mat(NeededNeurite(IDLength,:)))~=1)&&((isempty(cell2mat(NeededNeurite(IDLength+1,:)))==1))
        IDLengthNeeded=IDLength;
     break
     end
end