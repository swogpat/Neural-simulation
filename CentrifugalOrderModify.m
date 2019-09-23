function [IndexBasedonCentrifugalOrder,NewIndexofCentrifugalOrder]=CentrifugalOrderModify(PreNewIndexofCentrifugalOrder)    
NewIndexofCentrifugalOrder=double(PreNewIndexofCentrifugalOrder);
IndexBasedonCentrifugalOrder=zeros(size(NewIndexofCentrifugalOrder,1),size(NewIndexofCentrifugalOrder,2));
for ID3=1:size(NewIndexofCentrifugalOrder,1)-1
     for ID4=1:size(NewIndexofCentrifugalOrder,2)/2
        if NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3+1,2*ID4-1)+NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3+1,2*ID4)==0
           NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3,ID4)=NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3,ID4)+NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3+1,2*ID4-1)+NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3+1,2*ID4);
        else
           NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3,ID4)=NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3+1,2*ID4-1)+NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3+1,2*ID4);
        end
     end
end

for ID3=1:size(NewIndexofCentrifugalOrder,1)-1
     for ID4=1:size(NewIndexofCentrifugalOrder,2)
         if NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3,ID4)~=0
          IndexBasedonCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3,ID4)=double(NewIndexofCentrifugalOrder(size(NewIndexofCentrifugalOrder,1)-ID3,ID4))/double(NewIndexofCentrifugalOrder(1,1));
         end
     end
end


