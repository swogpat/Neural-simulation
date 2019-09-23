function [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration)
%% Loading Part
MulitDPofLamellipodiaCell=MulitDPofLamellipodiaCellAccrostheTime{IDIteration,1};
LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
TheIndexofSoma=InitializedInformation.TheIndexofSoma;
CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;
%% Define the Index of Neurites
if IDIteration==3
    TheNeuritesofSomas=zeros(size(TheIndexofSoma,1),size(TheIndexofSoma,2),size(TheIndexofSoma,3),1);
    TheNeuritesofEachSoma=zeros(size(TheIndexofSoma,1),size(TheIndexofSoma,2),size(TheIndexofSoma,3),1);
    CellofNeurites=cell(size(CellofInitialCentroidofSomas,1),1);
    for ID=1:size(CellofInitialCentroidofSomas,1)
          RuntheRandomizationforD=MulitDPofLamellipodiaCell{ID,2};
          GrowthLocationCell=LocationofMembraneVectorCell{ID,1};
          CellofNeuritesinOneSoma=cell(size(RuntheRandomizationforD,1),1);
          for ID1=1:size(RuntheRandomizationforD,1)
                if RuntheRandomizationforD(ID1,1)==1
                    CellofSigleNeurites=cell(50,2^9);
                   GrowthLocation=GrowthLocationCell(ID1,:);  
                   TheNeuritesofSomas(GrowthLocation(1),GrowthLocation(2),GrowthLocation(3),1)=ID;
                   TheNeuritesofEachSoma(GrowthLocation(1),GrowthLocation(2),GrowthLocation(3),1)=ID1;
                   CellofSigleNeurites{1,1}=GrowthLocation;
                   CellofNeuritesinOneSoma{ID1,1}=CellofSigleNeurites;
                end
          end
          CellofNeurites{ID,1}=CellofNeuritesinOneSoma;
    end
    CellofNeuritesAcrossTime{IDIteration-2,1}=CellofNeurites;
else
    TheNeuritesofSomas=zeros(size(TheIndexofSoma,1),size(TheIndexofSoma,2),size(TheIndexofSoma,3),1);
    TheNeuritesofEachSoma=zeros(size(TheIndexofSoma,1),size(TheIndexofSoma,2),size(TheIndexofSoma,3),1);
    CellofNeurites=CellofNeuritesAcrossTime{IDIteration-3,1};
    for ID=1:size(CellofInitialCentroidofSomas,1)
          RuntheRandomizationforD=MulitDPofLamellipodiaCell{ID,2};
          GrowthLocationCell=LocationofMembraneVectorCell{ID,1};
          CellofNeuritesinOneSoma=CellofNeurites{ID,1};
          for ID1=1:size(RuntheRandomizationforD,1)
                if RuntheRandomizationforD(ID1,1)==1
                    if isempty(CellofNeuritesinOneSoma{ID1,1})~=1
                        CellofSigleNeurites=CellofNeuritesinOneSoma{ID1,1};
                    else
                        CellofSigleNeurites=cell(50,2^9);
                    end
                   GrowthLocation=GrowthLocationCell(ID1,:);  
                   TheNeuritesofSomas(GrowthLocation(1),GrowthLocation(2),GrowthLocation(3),1)=ID;
                   TheNeuritesofEachSoma(GrowthLocation(1),GrowthLocation(2),GrowthLocation(3),1)=ID1;
                   CellofSigleNeurites{1,1}=GrowthLocation;
                   CellofNeuritesinOneSoma{ID1,1}=CellofSigleNeurites;
                end
          end
          CellofNeurites{ID,1}=CellofNeuritesinOneSoma;
    end
    CellofNeuritesAcrossTime{IDIteration-2,1}=CellofNeurites;
end
