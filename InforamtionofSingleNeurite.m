function []=InforamtionofSingleNeurite(NeededNeurite,CControalBranchingMemory)

IndexofCentrifugalOrder=cellfun('isempty',NeededNeurite);
for ID1=1:size(IndexofCentrifugalOrder,1)
   for ID2=1:size(IndexofCentrifugalOrder,2)
        IndexofCentrifugalOrder(ID1,ID2)=1-IndexofCentrifugalOrder(ID1,ID2);
   end
end

for IDLength=1:size(NeededNeurite,1)-1
     if (isempty(cell2mat(NeededNeurite(IDLength,1)))~=1)&&((isempty(cell2mat(NeededNeurite(IDLength+1,1)))==1))
        IDLengthNeeded=IDLength;
     break;
     end
end
NSegments=IDLengthNeeded;

%% Left Son


for IDSearch=IDStart:IDLengthNeeded
    while size(NeededNeurite{IDSearch,1},2)==2
             PreNeededNeurite=NeededNeurite{IDLengthNeeded,1};
             NeededNeurite=

    end
end

if isempty(NeededNeurite{2,2})~=1
    while size(NeededNeurite{IDLengthNeeded,1},2)==2
             NeededNeurite{}
             if isempty(NeededNeurite{2,2})~=1
                



             end
    end
end
