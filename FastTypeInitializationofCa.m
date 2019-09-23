function [SpaceofCaCell]=FastTypeInitializationofCa(SituationCCaOutSide,BasicSettings)
%% Load the Information
Width=BasicSettings.Width;
Length=BasicSettings.Length;
Hight=BasicSettings.Hight;

MinCCaOutSideFast=SituationCCaOutSide.MinCCaOutSideFast;
MaxCCaOutSideFast=SituationCCaOutSide.MaxCCaOutSideFast;

%% Define the Distribution
SpaceofCa=zeros(Width,Length,Hight,1);
for ID1=1:Width
    for ID2=1:Length
        for ID3=1:Hight
              SpaceofCa(ID1,ID2,ID3,1)=MinCCaOutSideFast + (MaxCCaOutSideFast-MinCCaOutSideFast).*rand(1,1);
        end
    end
end
SpaceofCaCell{1,1}=SpaceofCa;


