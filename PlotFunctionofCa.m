function [SpaceofCaCell]=PlotFunctionofCa(InformationInitializedofCa,InformationInitializedofSomas,SituationCCaConvection,BasicSettings)
%% Load the Information
Width=BasicSettings.Width;
Length=BasicSettings.Length;
Hight=BasicSettings.Hight;
InitialIterationTimes=BasicSettings.InitialIterationTimes;

CellofInitialCentroidofCa=InformationInitializedofCa.CellofInitialCentroidofCa;
VectorofInitialCofCa=InformationInitializedofCa.VectorofInitialCofCa;

CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;
VectorofInitialRadiusofSomas=InformationInitializedofSomas.VectorofInitialRadiusofSomas;

%% Distinguishment between the Inside and Outside of Soma
SpaceofCa=zeros(Width,Length,Hight,1);
for ID=1:size(CellofInitialCentroidofCa,1)
     XYZCa=CellofInitialCentroidofCa{ID,1};
     SpaceofCa(XYZCa(1),XYZCa(2),XYZCa(3),1)=VectorofInitialCofCa(ID);
     for ID1=1:size(CellofInitialCentroidofSomas)
           XYZS=CellofInitialCentroidofSomas{ID1,1};
           if (sqrt((XYZCa(1)-XYZS(1))^2+(XYZCa(2)-XYZS(2))^2+(XYZCa(3)-XYZS(3))^2)<VectorofInitialRadiusofSomas(ID1))||(sqrt((XYZCa(1)-XYZS(1))^2+(XYZCa(2)-XYZS(2))^2+(XYZCa(3)-XYZS(3))^2)==VectorofInitialRadiusofSomas(ID1))
               SpaceofCa(XYZCa(1),XYZCa(1),XYZCa(1),1)=0;
           end
    end
end

%% Start to Run the Iteration
SpaceofCaCell=cell(InitialIterationTimes,1);
SpaceofCaCell{1,1}=SpaceofCa;
for IDIt=1:(InitialIterationTimes-1)
      disp(['Space under Initialization in the Iteration of', num2str(IDIt), '-Starts to Process']);
      SpaceofCaCell{IDIt+1,1}=ConvectionofCa(SpaceofCaCell{IDIt,1},SituationCCaConvection,BasicSettings);
end


















