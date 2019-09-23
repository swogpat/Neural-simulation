function [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation)
%% Loading
TheIndexofSoma= InitializedInformation.TheIndexofSoma;
TheMembraneofSoma=InitializedInformation.TheMembraneofSoma;

InsideSpace=zeros(size(TheIndexofSoma,1),size(TheIndexofSoma,2),size(TheIndexofSoma,3),1);
OutsideSpace=zeros(size(TheIndexofSoma,1),size(TheIndexofSoma,2),size(TheIndexofSoma,3),1);

for ID1=1:size(TheIndexofSoma,1)
    for ID2=1:size(TheIndexofSoma,2)
        for ID3=1:size(TheIndexofSoma,3)
             disp(['Point of', num2str(ID1), '-',num2str(ID2),'-',num2str(ID3), ' -Is under Processing for the Inside & Outside Space Judgement']);
              if TheIndexofSoma(ID1,ID2,ID3,1)==0
                  OutsideSpace(ID1,ID2,ID3,1)=1;
              end
              if (TheIndexofSoma(ID1,ID2,ID3,1)>0)&&(TheMembraneofSoma(ID1,ID2,ID3,1)==0)
                  InsideSpace(ID1,ID2,ID3,1)=1;
              end
        end
    end
end