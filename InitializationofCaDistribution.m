function [CellofInitialCentroidofCa,VectorofInitialCofCa]=InitializationofCaDistribution(SituationCCaOutSide,BasicSettings)

Width=BasicSettings.Width;
Length=BasicSettings.Length;
Hight=BasicSettings.Hight;

NumofInitialCa=SituationCCaOutSide.NumofInitialCa;
MinCCaOutSide=SituationCCaOutSide.MinCCaOutSide;
MaxCCaOutSide=SituationCCaOutSide.MaxCCaOutSide;

%% Generation of the Whole Space
Limitation=[Width,Length,Hight];

%% Generation of the Somas
CellofInitialCentroidofCa=cell(NumofInitialCa,1);
VectorofInitialCofCa=zeros(NumofInitialCa,1);
for ID=1:NumofInitialCa
InitialCentroidofCa=[randi([2, Limitation(1,1)-1],1,1),randi([2, Limitation(1,2)-1],1,1),randi([2, Limitation(1,3)-1],1,1)];
CellofInitialCentroidofCa{ID,1}=InitialCentroidofCa;
VectorofInitialCofCa(ID,1)=MinCCaOutSide + (MaxCCaOutSide-MinCCaOutSide).*rand(1,1);
end



