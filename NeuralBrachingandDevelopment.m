function NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
if IDIteration==ExperimentTimes-1
%% Load something
    disp(['Start to Growth the Synapes!'])
    CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;
    VectorofInitialRadiusofSomas=InformationInitializedofSomas.VectorofInitialRadiusofSomas;
    MinRadius=SituationSomas.MinRadius;
    MaxRadius=SituationSomas.MaxRadius;
    CellofNeurites=CellofNeuritesAcrossTime{end-1,1};
    CellofSize=CellofSizeAcrossTime{end-1,1};
    LocationofMembraneVectorCell=IterationCellofInfluxSpace{end-1,1};
    MulitDPofLamellipodiaCell=MulitDPofLamellipodiaCellAccrostheTime{end-1,1};
    %% General Information
    XLocationofCentroid=zeros(size(CellofInitialCentroidofSomas,1),1);
    YLocationofCentroid=zeros(size(CellofInitialCentroidofSomas,1),1);
    ZLocationofCentroid=zeros(size(CellofInitialCentroidofSomas,1),1);
    for IDSoma=1:size(CellofInitialCentroidofSomas,1)
          CentroidLocation=CellofInitialCentroidofSomas{IDSoma,1};
          XLocationofCentroid(IDSoma,1)=CentroidLocation(1);
          YLocationofCentroid(IDSoma,1)=CentroidLocation(2);
          ZLocationofCentroid(IDSoma,1)=CentroidLocation(3);
    end
    VectorofInitialColorofSomas=zeros(size(VectorofInitialRadiusofSomas,1),3);
    for IDPart=1:size(VectorofInitialRadiusofSomas,1)
        VectorofInitialColorofSomas(IDPart,1)=floor(255-(VectorofInitialRadiusofSomas(IDPart,1)-MinRadius)*255/(MaxRadius-MinRadius));
        VectorofInitialColorofSomas(IDPart,2)=floor((VectorofInitialRadiusofSomas(IDPart,1)-MinRadius)*255/(MaxRadius-MinRadius));
        VectorofInitialColorofSomas(IDPart,3)=0;
    end
    %% Start to Draw
    figure('Color',[1 1 1]);
    NumberDonnotChange=300;
    Memebrane=cell(size(CellofInitialCentroidofSomas,1),1);
        for IDSoma=1:size(CellofInitialCentroidofSomas,1)
              hold on;
              Memebrane{IDSoma,1} = MemebraneGenerateFunction(VectorofInitialRadiusofSomas(IDSoma),XLocationofCentroid(IDSoma,1),YLocationofCentroid(IDSoma,1),ZLocationofCentroid(IDSoma,1),[46 139 87],NumberDonnotChange);
              RuntheRandomizationforD=MulitDPofLamellipodiaCell{IDSoma,2};
              GrowthLocationCell=LocationofMembraneVectorCell{IDSoma,1};
              CellofNeuritesforSingleNeuron=CellofNeurites{IDSoma,1};
              CellofSizeforSingleNeuron=CellofSize{IDSoma,1};
              for IDPart=1:size(RuntheRandomizationforD,1)
                   if (isempty(CellofNeuritesforSingleNeuron{IDPart,1})~=1)
                       disp(['Start to growth the segment on', num2str(IDPart), 'of' num2str(size(RuntheRandomizationforD,1))]);
                       GrowthLocation=GrowthLocationCell(IDPart,:);
                       NeededNeurite=CellofNeuritesforSingleNeuron{IDPart,1};
                       Lamellipodia=MemebraneGenerateFunction(1,GrowthLocation(1),GrowthLocation(2),GrowthLocation(3),[46 139 87],NumberDonnotChange);
                       NeededSize=CellofSizeforSingleNeuron{IDPart,1};
                       for ID1=1:size(NeededNeurite,1)-1
                             for ID2=1:size(NeededNeurite,1)/2
                                   if (isempty(NeededNeurite{ID1,ID2})~=1)&&(size(NeededNeurite{ID1,ID2},1)>1)
                                       NeededSegment=NeededNeurite{ID1,ID2};
                                       for ID0=1:size(NeededNeurite{ID1,ID2})-1
                                             if NeededSegment(ID0,:)~=NeededSegment(ID0+1,:)
                                                disp('Start to Growth without Braching');
                                             Plotcylinder(NeededSegment(ID0,:),NeededSegment(ID0+1,:),[32/255, 178/255, 170/255],NeededSize{ID1,ID2});
                                             end
                                       end
                                   end
                                   if (isempty(NeededNeurite{ID1,ID2})~=1)&&(isempty(NeededNeurite{ID1+1,2*ID2-1})~=1)
                                        NeededSegmentPre=NeededNeurite{ID1,ID2};
                                        NeededSegmentNew=NeededNeurite{ID1+1,2*ID2-1};
                                        DifferenceValue=zeros(size(NeededSegmentPre,1),1);
                                        for IDSearch=1:size(NeededSegmentPre,1)
                                              DifferenceValue(IDSearch,1)=norm(NeededSegmentNew(1,:)-NeededSegmentPre(IDSearch,:));
                                        end
                                        Needed=find(DifferenceValue(:,1)==min(DifferenceValue(:,1)));
                                        if length(Needed)>1
                                            Needed=Needed(1);
                                        end
                                         disp('Braching for the Left Daughter Segment');
                                         Plotcylinder(NeededSegmentPre(Needed,:),NeededSegmentNew(1,:),[32/255, 178/255, 170/255],NeededSize{ID1+1,2*ID2-1});
                                   end
                                   if (isempty(NeededNeurite{ID1,ID2})~=1)&&(isempty(NeededNeurite{ID1+1,2*ID2})~=1)
                                        NeededSegmentPre=NeededNeurite{ID1,ID2};
                                        NeededSegmentNew=NeededNeurite{ID1+1,2*ID2};
                                        DifferenceValue=zeros(size(NeededSegmentPre,1),1);
                                        for IDSearch=1:size(NeededSegmentPre,1)
                                              DifferenceValue(IDSearch,1)=norm(NeededSegmentNew(1,:)-NeededSegmentPre(IDSearch,:));
                                        end
                                        Needed=find(DifferenceValue(:,1)==min(DifferenceValue(:,1)));
                                        if length(Needed)>1
                                            Needed=Needed(1);
                                        end
                                        disp('Braching for the Right Daughter Segment');
                                         Plotcylinder(NeededSegmentPre(Needed,:),NeededSegmentNew(1,:),[32/255, 178/255, 170/255],NeededSize{ID1+1,2*ID2});
                                   end
                             end
                       end
                   end
              end
              hold off;
        end
        axis equal;
        grid off;
end