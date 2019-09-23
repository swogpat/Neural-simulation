    function GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration)
    if IDIteration==6
    %% Load something
    CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;
    VectorofInitialRadiusofSomas=InformationInitializedofSomas.VectorofInitialRadiusofSomas;
    MinRadius=SituationSomas.MinRadius;
    MaxRadius=SituationSomas.MaxRadius;
    LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};

    %% General Information
    XLocationofCentroid=zeros(size(CellofInitialCentroidofSomas,1),1);
    YLocationofCentroid=zeros(size(CellofInitialCentroidofSomas,1),1);
    ZLocationofCentroid=zeros(size(CellofInitialCentroidofSomas,1),1);
    for ID=1:size(CellofInitialCentroidofSomas,1)
          CentroidLocation=CellofInitialCentroidofSomas{ID,1};
          XLocationofCentroid(ID,1)=CentroidLocation(1);
          YLocationofCentroid(ID,1)=CentroidLocation(2);
          ZLocationofCentroid(ID,1)=CentroidLocation(3);
    end

    VectorofInitialColorofSomas=zeros(size(VectorofInitialRadiusofSomas,1),3);
    for ID1=1:size(VectorofInitialRadiusofSomas,1)
        VectorofInitialColorofSomas(ID1,1)=floor(255-(VectorofInitialRadiusofSomas(ID1,1)-MinRadius)*255/(MaxRadius-MinRadius));
        VectorofInitialColorofSomas(ID1,2)=floor((VectorofInitialRadiusofSomas(ID1,1)-MinRadius)*255/(MaxRadius-MinRadius));
        VectorofInitialColorofSomas(ID1,3)=0;
    end

    %% Start to Draw
    FigureofNeuron=figure('Color',[1 1 1]);
    NumberDonnotChange=300;
    Memebrane=cell(size(CellofInitialCentroidofSomas,1),1);
    for ID0=1:IDIteration
        subplot(2,3,ID0);
        MulitDPofLamellipodiaCell=MulitDPofLamellipodiaCellAccrostheTime{ID0,1};
        for ID=1:size(CellofInitialCentroidofSomas,1)
              hold on;
              Memebrane{ID,1} = MemebraneGenerateFunction(VectorofInitialRadiusofSomas(ID),XLocationofCentroid(ID,1),YLocationofCentroid(ID,1),ZLocationofCentroid(ID,1),VectorofInitialColorofSomas(ID,:),NumberDonnotChange);
              RuntheRandomizationforD=MulitDPofLamellipodiaCell{ID,2};
              GrowthLocationCell=LocationofMembraneVectorCell{ID,1};
              for ID1=1:size(RuntheRandomizationforD,1)
                   if RuntheRandomizationforD(ID1,1)==1
                       GrowthLocation=GrowthLocationCell(ID1,:);
                       Lamellipodia=MemebraneGenerateFunction(1,GrowthLocation(1),GrowthLocation(2),GrowthLocation(3),[0,0,0],NumberDonnotChange);
                   end
              end
              hold off;
        end
        axis equal;
        grid off;
    end
end