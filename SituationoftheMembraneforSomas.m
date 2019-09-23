function [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace)
NumofInitialSomas=SituationSomas.NumofInitialSomas;
Width=BasicSettings.Width;
Length=BasicSettings.Length;
TheIndexofSoma=InitializedInformation.TheIndexofSoma;
TheMembraneofSoma=InitializedInformation.TheMembraneofSoma;
CaSpace=IterationCellofNeuralSpace{IDIteration,1};

LocationofMembraneVectorCell=cell(NumofInitialSomas,1);
SituationofMembraneVectorCell=cell(NumofInitialSomas,1);
InsidePointofAllSomaCell=cell(NumofInitialSomas,1);
OutsidePointofAllSomaCell=cell(NumofInitialSomas,1);
for ID=1:NumofInitialSomas
      disp(['Analyze the Situation of Soma-', num2str(ID)]);
      LocationofMembrane=find(TheMembraneofSoma(:,:,:,1)==ID);
      LocationofMembraneVectorCell{ID,1}=[rem(rem((LocationofMembrane-1),Width*Length),Width)+1, fix(rem((LocationofMembrane-1),(Width*Length))/Width)+1, fix((LocationofMembrane-1)/(Width*Length))+1];
      LocationofMembraneVector=LocationofMembraneVectorCell{ID,1};
      OutSideSituation=zeros(size(LocationofMembraneVector,1),1);
      InsidePointSingleSomaCell=cell(size(LocationofMembraneVector,1),1);
      OutsidePointSingleSomaCell=cell(size(LocationofMembraneVector,1),1);
      for ID1=1:size(LocationofMembraneVector,1)
            LocationofMembranePoint=LocationofMembraneVector(ID1,:);
            LocationContainsMembranePoint=LocationofMembranePoint+SearchSpace;
            IndexValueSet=zeros(size(SearchSpace,1),1);
            IndexValueSetInside=zeros(size(SearchSpace,1),1);
            for ID2=1:size(SearchSpace,1)
                   LocationContainsMembranePointSearched=LocationContainsMembranePoint(ID2,:);
                   IndexValueSet(ID2,1)=TheIndexofSoma(LocationContainsMembranePointSearched(1),LocationContainsMembranePointSearched(2),LocationContainsMembranePointSearched(3),1);
                   IndexValueSetInside(ID2,1)=TheMembraneofSoma(LocationContainsMembranePointSearched(1),LocationContainsMembranePointSearched(2),LocationContainsMembranePointSearched(3),1);
            end
            OutsideLocation=find(IndexValueSet(:,1)==0);
            InsideLocation=find((IndexValueSet(:,1)==ID)&(IndexValueSetInside(:,1)==0));
            OutsidePoint=zeros(size(OutsideLocation,1),3);
            OutsideCaValue=zeros(size(OutsideLocation,1),1);
            for ID3=1:size(OutsideLocation,1)
                  OutsidePoint(ID3,:)=LocationContainsMembranePoint(OutsideLocation(ID3,1),:);
                  OutsidePointLocation=OutsidePoint(ID3,:);
                  OutsideCaValue(ID3,1)=CaSpace(OutsidePointLocation(1),OutsidePointLocation(2),OutsidePointLocation(3),1);
            end
            OutSideSituation(ID1,1)=sum(sum(OutsideCaValue))/size(OutsideCaValue,1);
            InsidePoint=zeros(size(InsideLocation,1),3);
            for ID4=1:size(InsideLocation,1)
                  InsidePoint(ID4,:)=LocationContainsMembranePoint(InsideLocation(ID4,1),:);
            end
            InsidePointSingleSomaCell{ID1,1}=InsidePoint;
            OutsidePointSingleSomaCell{ID1,1}=OutsidePoint;
      end
      InsidePointofAllSomaCell{ID,1}=InsidePointSingleSomaCell;
      OutsidePointofAllSomaCell{ID,1}=OutsidePointSingleSomaCell;
      SituationofMembraneVectorCell{ID,1}=OutSideSituation;
end
IterationCellofInfluxSpace{IDIteration,1}=LocationofMembraneVectorCell;
IterationCellofInfluxSpace{IDIteration,2}=SituationofMembraneVectorCell;
IterationCellofInfluxSpace{IDIteration,3}=InsidePointofAllSomaCell;
IterationCellofInfluxSpace{IDIteration,4}=OutsidePointofAllSomaCell;



