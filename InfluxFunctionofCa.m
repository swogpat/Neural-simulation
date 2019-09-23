function [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime)
%% Loading Part
LocationofMembraneVectorCell=InfluxSituationInformation.LocationofMembraneVectorCell;
SituationofMembraneVectorCell=InfluxSituationInformation.SituationofMembraneVectorCell;
InsidePointofAllSomaCell=InfluxSituationInformation.InsidePointofAllSomaCell;
OutsidePointofAllSomaCell=InfluxSituationInformation.OutsidePointofAllSomaCell;
DiffusionCCaX=SituationCCaConvection.DiffusionCCaX;
DiffusionCCaY=SituationCCaConvection.DiffusionCCaY;
DiffusionCCaZ=SituationCCaConvection.DiffusionCCaZ;
DiffusionCCa=(DiffusionCCaX+DiffusionCCaY+DiffusionCCaZ)/3;
NumofInitialSomas=SituationSomas.NumofInitialSomas;
InitializedSpaceofCaCell=InitializedInformation.InitializedSpaceofCaCell;
InfluxPermeabilityConstant=SituationCaInflux.InfluxPermeabilityConstant;
VectorofInitialRadiusofSomas=InformationInitializedofSomas.VectorofInitialRadiusofSomas;
if  IDIteration==1
    CaSpace=InitializedSpaceofCaCell{end,1};
else
    CaSpace=IterationCellofNeuralSpace{IDIteration-1,1};
end

%% 
InfluexedCaSpace=CaSpace;
AddValueVectorMultiCell=cell(NumofInitialSomas,1);
for ID=1:NumofInitialSomas
     SingleMembraneofSoma=LocationofMembraneVectorCell{ID,1};
     InsidePointSingleSomaCell=InsidePointofAllSomaCell{ID,1};
     OutsidePointSingleSomaCell=OutsidePointofAllSomaCell{ID,1};
     OutSideSituation=SituationofMembraneVectorCell{ID,1};
     InitialRadiusofSomas=VectorofInitialRadiusofSomas(ID,1);
     AddValueVectorSingleCell=cell(size(SingleMembraneofSoma,1),1);
     for ID1=1:size(SingleMembraneofSoma,1)
          InsidePoint=InsidePointSingleSomaCell{ID1,1};
          OutsidePoint=OutsidePointSingleSomaCell{ID1,1};
          OutSideSituationValue=OutSideSituation(ID1,1);
          DivisionValue=size(InsidePoint,1);
          AddValueVector=zeros(size(InsidePoint,1),4);
          for ID2=1:size(InsidePoint,1)
                AddValue=InfluxofCaforPassiveSoma(OutSideSituationValue,DivisionValue,InitialRadiusofSomas,InfluxPermeabilityConstant,IterationTime,DiffusionCCa);
                LocationofInsidePoint=InsidePoint(ID2,:);
                InfluexedCaSpace(LocationofInsidePoint(1),LocationofInsidePoint(2),LocationofInsidePoint(3),1)=AddValue;
                AddValueVector(ID2,1)=CaSpace(LocationofInsidePoint(1),LocationofInsidePoint(2),LocationofInsidePoint(3),1);
                AddValueVector(ID2,2)=AddValue;
                AddValueVector(ID2,3)=AddValue-CaSpace(LocationofInsidePoint(1),LocationofInsidePoint(2),LocationofInsidePoint(3),1);
                AddValueVector(ID2,4)=AddValue*DivisionValue;
          end
          AddValueVectorSingleCell{ID1,1}=AddValueVector;
          for ID3=1:size(OutsidePoint,1)
                LocationofOutsidePoint=OutsidePoint(ID3,:);
                InfluexedCaSpace(LocationofOutsidePoint(1),LocationofOutsidePoint(2),LocationofOutsidePoint(3),1)=InfluexedCaSpace(LocationofOutsidePoint(1),LocationofOutsidePoint(2),LocationofOutsidePoint(3),1)-sum(sum(AddValueVector(:,3)))/size(OutsidePoint,1);
          end
     end
     AddValueVectorMultiCell{ID,1}=AddValueVectorSingleCell;
end
IterationCellofNeuralSpace{IDIteration,1}=InfluexedCaSpace;
IterationCellofNeuralSpace{IDIteration,2}=AddValueVectorMultiCell;