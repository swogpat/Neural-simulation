function [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaDiffusion,InformationInitializedofSomas,BasicSettings)

MinCCaInSide=SituationCCaDiffusion.MinCCaInSide;
MaxCCaInSide=SituationCCaDiffusion.MaxCCaInSide;

Width=BasicSettings.Width;
Length=BasicSettings.Length;
Hight=BasicSettings.Hight;

CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;
VectorofInitialRadiusofSomas=InformationInitializedofSomas.VectorofInitialRadiusofSomas;

InitializedSpaceofCaCell=cell(size(SpaceofCaCell,1),1);
TheMembraneofSoma=zeros(Width,Length,Hight,1);
TheIndexofSoma=zeros(Width,Length,Hight,1);
for ID0=1:size(SpaceofCaCell,1)
disp([num2str(ID0), ' is under Processing for Adding Soma Information']);
InitializedSpaceofCa=SpaceofCaCell{ID0,1};
for ID1=1:Width
    for ID2=1:Length
        for ID3=1:Hight
             disp([num2str(ID1), '-', num2str(ID2), '-',num2str(ID3)]);
             for ID4=1:size(CellofInitialCentroidofSomas)
                     XYZS=CellofInitialCentroidofSomas{ID4,1};
                    if (sqrt((ID1-XYZS(1))^2+(ID2-XYZS(2))^2+(ID3-XYZS(3))^2)<VectorofInitialRadiusofSomas(ID4))||(sqrt((ID1-XYZS(1))^2+(ID2-XYZS(2))^2+(ID3-XYZS(3))^2)==VectorofInitialRadiusofSomas(ID4))
                     InitializedSpaceofCa(ID1,ID2,ID3,1)=MinCCaInSide + (MaxCCaInSide-MinCCaInSide).*rand(1,1);
                     TheIndexofSoma(ID1,ID2,ID3,1)=ID4;
                    end
             end
        end
    end
end
TheMembraneofSoma=TheIndexofSoma;
for ID1=2:Width-1
    for ID2=2:Length-1
        for ID3=2:Hight-1
              InsideIndex=TheIndexofSoma(ID1+1,ID2,ID3)*TheIndexofSoma(ID1-1,ID2,ID3)*TheIndexofSoma(ID1,ID2+1,ID3)*TheIndexofSoma(ID1,ID2-1,ID3)*TheIndexofSoma(ID1,ID2,ID3+1)*TheIndexofSoma(ID1,ID2,ID3-1);
             if InsideIndex~=0
                    TheMembraneofSoma(ID1,ID2,ID3,1)=0;
             end
        end
    end
end            

                    
InitializedSpaceofCaCell{ID0,1}=InitializedSpaceofCa;
end