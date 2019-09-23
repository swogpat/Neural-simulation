






%% Generation of the Whole Space

Limitation=[Width Length Hight];
SpaceforNeuronSystem=zeros(Width,Length,Hight);

%% Generation of the Somas
CellofInitialCentroidofSomas=cell(NumofInitialSomas,1);
VectorofInitialRadiusofSomas=zeros(NumofInitialSomas,1);
for ID=1:NumofInitialSomas
InitialCentroidofSomas=[randi([1 Limitation(1,1)],1,1) randi([1 Limitation(1,2)],1,1) randi([1 Limitation(1,3)],1,1)];
CellofInitialCentroidofSomas{ID,1}=InitialCentroidofSomas;
VectorofInitialRadiusofSomas(ID,1)=randi([1,],1,1)
end