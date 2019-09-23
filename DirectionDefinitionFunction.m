function [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas)
%% Loading Part
if IDIteration==3
    CellofNeurites=CellofNeuritesAcrossTime{IDIteration-2,1};
else
    CellofNeurites=CellofNeuritesAcrossTime{IDIteration-3,1};
end
BUMAP2Cell=BUMAP2CellAcrossTime{IDIteration-2,1};
PMAP2Cell=PMAP2CellAcrossTime{IDIteration-2,1};
LengthCell=LengthCellAcrossTime{IDIteration-2,2};
IterationTime=BasicSettings.IterationTime;
CBranching=BasicSettingsforChemical.CBranching;
CControalBranchingMemory=BasicSettingsforChemical.CControalBranchingMemory;
CCompetitiveBranchingMemory=BasicSettingsforChemical.CCompetitiveBranchingMemory;
CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;

if IDIteration==3
    CellofDirection=cell(size(CellofInitialCentroidofSomas,1),1);
    CellofIndexofCentrifugalOrder=cell(size(CellofInitialCentroidofSomas,1),1);
    CellofPreNewIndexofCentrifugalOrder=cell(size(CellofInitialCentroidofSomas,1),1);
    CellofSize=cell(size(CellofInitialCentroidofSomas,1),1);
    for IDSoma=1:size(CellofInitialCentroidofSomas,1)
          CentroidofSomas=CellofInitialCentroidofSomas{IDSoma,1};
          SingleNeuron=CellofNeurites{IDSoma,1};
          DirectiononSingleNeuron=cell(size(SingleNeuron,1),size(SingleNeuron,2));
          IndexofCentrifugalOrderSingleNeuron=cell(size(SingleNeuron,1),1);
          PreNewIndexofCentrifugalOrderSingleNeuron=cell(size(SingleNeuron,1),1);
          SizeofNeurtesofSingleNeuron=cell(size(SingleNeuron,1),1);
          for ID1=1:size(SingleNeuron,1)
                if isempty(SingleNeuron{ID1,1})~=1
                    CellofSingleDirectiononSingleNeurites=cell(size(SingleNeuron{ID1,1},1),size(SingleNeuron{ID1,1},2));
                    CellofSingleSizeSingleNeurites=cell(size(SingleNeuron{ID1,1},1),size(SingleNeuron{ID1,1},2));
                    SingleNeurte=SingleNeuron{ID1,1};
                    NeededSegment=SingleNeurte{1,1};
                    PreVector=NeededSegment(1,:)-CentroidofSomas;
                   CellofSingleDirectiononSingleNeurites{1,1}=PreVector/sqrt(PreVector(1)^2+PreVector(2)^2+PreVector(3)^2);
                   CellofSingleSizeSingleNeurites{1,1}=1;
                   DirectiononSingleNeuron{ID1,1}=CellofSingleDirectiononSingleNeurites;
                   SizeofNeurtesofSingleNeuron{ID1,1}=CellofSingleSizeSingleNeurites;
                end
          end
          CellofDirection{IDSoma,1}=DirectiononSingleNeuron;
          CellofIndexofCentrifugalOrder{IDSoma,1}=IndexofCentrifugalOrderSingleNeuron;
          CellofPreNewIndexofCentrifugalOrder{IDSoma,1}=PreNewIndexofCentrifugalOrderSingleNeuron;
          CellofSize{IDSoma,1}=SizeofNeurtesofSingleNeuron;
    end
    CellofDirectionAcrossTime{IDIteration-2,1}=CellofDirection;
    CellIndexofCentrifugalOrderAcrossTime{IDIteration-2,1}=CellofIndexofCentrifugalOrder;
     CellPreNewIndexofCentrifugalOrderAcrossTime{IDIteration-2,1}=CellofPreNewIndexofCentrifugalOrder;
     CellofSizeAcrossTime{IDIteration-2,1}=CellofSize;
else
    CellofDirection=CellofDirectionAcrossTime{IDIteration-3,1};
    CellofIndexofCentrifugalOrder=CellIndexofCentrifugalOrderAcrossTime{IDIteration-3,1};
    CellofPreNewIndexofCentrifugalOrder=CellPreNewIndexofCentrifugalOrderAcrossTime{IDIteration-3,1};
    CellofSize=CellofSizeAcrossTime{IDIteration-3,1};
    for IDSoma=1
          SingleNeuron=CellofNeurites{IDSoma,1};
          DirectiononSingleNeuron=CellofDirection{IDSoma,1};
          CentroidofSomas=CellofInitialCentroidofSomas{IDSoma,1};
          SizeofNeurtesofSingleNeuron=CellofSize{IDSoma,1};
          for ID1=1:size(SingleNeuron,1)
                if isempty(SingleNeuron{ID1,1})~=1
                    NeededSet=SingleNeuron{ID1,1};
                    if size(NeededSet{1,1},1)>=1
                    CellofSingleDirectiononSingleNeurites=DirectiononSingleNeuron{ID1,1};
                    CellofSingleSizeSingleNeurites=SizeofNeurtesofSingleNeuron{ID1,1};  
                    else
                    CellofSingleDirectiononSingleNeurites=cell(size(SingleNeuron{ID1,1},1),size(SingleNeuron{ID1,1},2));
                    CellofSingleSizeSingleNeurites=cell(size(SingleNeuron{ID1,1},1),size(SingleNeuron{ID1,1},2));
                    SingleNeurte=SingleNeuron{ID1,1};
                    NeededSegment=SingleNeurte{1,1};
                    PreVector=NeededSegment(1,:)-CentroidofSomas;
                    CellofSingleDirectiononSingleNeurites{1,1}=PreVector/sqrt(PreVector(1)^2+PreVector(2)^2+PreVector(3)^2);
                    CellofSingleSizeSingleNeurites{1,1}=1;
                    end
                    DirectiononSingleNeuron{ID1,1}=CellofSingleDirectiononSingleNeurites;
                    SizeofNeurtesofSingleNeuron{ID1,1}=CellofSingleSizeSingleNeurites;   
                end
          end
          CellofDirection{IDSoma,1}=DirectiononSingleNeuron;
          CellofSize{IDSoma,1}=SizeofNeurtesofSingleNeuron;
    end
end

%% The Branching
for IDSoma=1:size(CellofNeurites,1)
      disp(['The Situation of Braching in the Soma ',num2cell(IDSoma)]);
      CellofNeuritesforSingleNeuron=CellofNeurites{IDSoma,1};
      VectorofPMAP2forSingleNeuron=PMAP2Cell{IDSoma,1};
      VectorofBUMAP2forSingleNeuron=BUMAP2Cell{IDSoma,1};
      DirectiononSingleNeuron=CellofDirection{IDSoma,1};
      SizeofNeurtesofSingleNeuron=CellofSize{IDSoma,1};
      VectorofLengthforSingleNeuron=LengthCell{IDSoma,1};
      IndexofCentrifugalOrderSingleNeuron=CellofIndexofCentrifugalOrder{IDSoma,1};
      PreNewIndexofCentrifugalOrderSingleNeuron=CellofPreNewIndexofCentrifugalOrder{IDSoma,1};
      for IDPart=1:size(CellofNeuritesforSingleNeuron,1)
            if isempty(CellofNeuritesforSingleNeuron{IDPart,1})~=1
                disp(['Braching in the Soma ', num2cell(IDSoma), '-', num2cell(IDPart)]);
               %% Definition and Calculation
               PMAP2Value=VectorofPMAP2forSingleNeuron(IDPart+1,1);
               BUMAP2Value=VectorofBUMAP2forSingleNeuron(IDPart+1,1);
               LengthValue=VectorofLengthforSingleNeuron(IDPart+1,1);
               NTime=(IDIteration-2)*IterationTime;
               NeededNeurite=CellofNeuritesforSingleNeuron{IDPart,1};
%                NSegments=size(NeededNeurite,1)*size(NeededNeurite,2)-sum(sum(cellfun('isempty',NeededNeurite)));
               [IndexofCentrifugalOrder,~,PreIndexBasedonCentrifugalOrder,NSegments,NUniSegments]=CentrifugalOrderDenefinition(NeededNeurite,CControalBranchingMemory);
               ExpectationofCentrifugalOrder=1/NUniSegments*sum(sum(PreIndexBasedonCentrifugalOrder));
               CellofSingleDirectiononSingleNeurites=DirectiononSingleNeuron{IDPart,1};
               %% Define the  Searching
               PreNewIndexofCentrifugalOrder=IndexofCentrifugalOrder;
               BranchingProb=zeros(size(PreIndexBasedonCentrifugalOrder,1),size(PreIndexBasedonCentrifugalOrder,2));
               BranchorNot=zeros(size(PreIndexBasedonCentrifugalOrder,1),size(PreIndexBasedonCentrifugalOrder,2));
               for IDSearch1=1:size(PreIndexBasedonCentrifugalOrder,1)-1
                     for IDSearch2=1:size(PreIndexBasedonCentrifugalOrder,2)/2
                         if IndexofCentrifugalOrder(IDSearch1,IDSearch2)>0
%                                BranchingProb(IDSearch1,IDSearch2)=real((0.001*(1+0.002)^(NSegments^(1/2))+(CBranching*(0.0001+PMAP2Value)/(0.001+PMAP2Value+BUMAP2Value))*exp(1)^(-NTime^(1/2))*NSegments^CCompetitiveBranchingMemory)*PreIndexBasedonCentrifugalOrder(IDSearch1,IDSearch2)/ExpectationofCentrifugalOrder*(size(NeededNeurite{IDSearch1,IDSearch2},1)/(size(NeededNeurite{1,1},1)^(1/2))));
%                               BranchingProb(IDSearch1,IDSearch2)=0.1;
%0.0003
%                                disp(PreIndexBasedonCentrifugalOrder(IDSearch1,IDSearch2)/ExpectationofCentrifugalOrder);
%                                BranchingProb(IDSearch1,IDSearch2)=real((0.0005*(1+0.002)^(NSegments^(1/2))+(CBranching*(0.0001+PMAP2Value)/(0.001+PMAP2Value+BUMAP2Value))*exp(1)^(-NTime^(1/2))*NSegments^CCompetitiveBranchingMemory)*PreIndexBasedonCentrifugalOrder(IDSearch1,IDSearch2)/ExpectationofCentrifugalOrder*(size(NeededNeurite{IDSearch1,IDSearch2},1)/(size(NeededNeurite{1,1},1)^(1/2))));
                                BranchingProb(IDSearch1,IDSearch2)=0.00001+real(((CBranching*(1+0.005)^(NSegments^(1/2))*(0.0001+PMAP2Value)/(0.001+PMAP2Value+BUMAP2Value))*NSegments^CCompetitiveBranchingMemory)*PreIndexBasedonCentrifugalOrder(IDSearch1,IDSearch2)/ExpectationofCentrifugalOrder*(size(NeededNeurite{IDSearch1,IDSearch2},1)/(size(NeededNeurite{1,1},1)^(1/2))));
                             disp(['The Braching Prob is' num2str(BranchingProb(IDSearch1,IDSearch2))]);
                             BranchingProb(IDSearch1,IDSearch2)=roundn(BranchingProb(IDSearch1,IDSearch2),-3);
                             NeededOnes=BranchingProb(IDSearch1,IDSearch2)*1000;
                             NeededZeros=1000-NeededOnes;
                             NeededValue=[ones(1,NeededOnes),zeros(1,NeededZeros)];
                             RandomedValue=NeededValue(randperm(1000));
                             NeedtoPick=randperm(1000);
                             BranchorNot(IDSearch1,IDSearch2)=RandomedValue(NeedtoPick(1));
                                 if (IndexofCentrifugalOrder(IDSearch1,IDSearch2)>0)&&(IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)+IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)>0)
                                          PreNewIndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)=IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)+0;
                                          PreNewIndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)=IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)+0;
                                 elseif (IndexofCentrifugalOrder(IDSearch1,IDSearch2)>0)&&(IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)+IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)==0)&&(BranchorNot(IDSearch1,IDSearch2)==1)
                                          PreNewIndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)=IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)+1;
                                          PreNewIndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)=IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)+1;
                                 elseif (IndexofCentrifugalOrder(IDSearch1,IDSearch2)>0)&&(IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)+IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)==0)&&(BranchorNot(IDSearch1,IDSearch2)==0)
                                          PreNewIndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)=IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2-1)+0;
                                          PreNewIndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)=IndexofCentrifugalOrder(IDSearch1+1,2*IDSearch2)+0;
                                 end
                         end
                     end
               end
            %% Growth!!!!!!!!!!!!
            [IndexBasedonCentrifugalOrder,~]=CentrifugalOrderModify(PreNewIndexofCentrifugalOrder);
            %% The Direction
            for IDSearch3=1:size(PreIndexBasedonCentrifugalOrder,1)-1
                   for IDSearch4=1:size(PreIndexBasedonCentrifugalOrder,2)/2
                          %% Situation 1
                          if (PreNewIndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1)>IndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1))&&(IndexofCentrifugalOrder(IDSearch3,IDSearch4)~=0)
                              %% Find the Direction Bases
                              DirectionBased=sum(CellofSingleDirectiononSingleNeurites{IDSearch3,IDSearch4})/size(CellofSingleDirectiononSingleNeurites{IDSearch3,IDSearch4},1);
                              %% Define the Direction
                              A=(pi/8+pi/2*rand(1))*(-1)^randi([1,2],1,1);
                              B=(pi/8+pi/2*rand(1))*(-1)^randi([1,2],1,1);
                              C=(pi/8+pi/2*rand(1))*(-1)^randi([1,2],1,1);
                              RoMatrix1=[cos(A)*cos(B), cos(A)*sin(B)*sin(C)-sin(A)*cos(C), cos(A)*sin(B)*cos(C)+sin(A)*sin(C); sin(A)*cos(B), sin(A)*sin(B)*sin(C)+cos(A)*cos(C), sin(A)*sin(B)*cos(C)-cos(A)*sin(C); -sin(B), cos(B)*sin(C), cos(B)*cos(C)];
                              D=(pi/8+pi/2*rand(1))*(-1)^randi([1,2],1,1);
                              E=(pi/8+pi/2*rand(1))*(-1)^randi([1,2],1,1);
                              F=(pi/8+pi/2*rand(1))*(-1)^randi([1,2],1,1);
                              RoMatrix2=[cos(D)*cos(E), cos(D)*sin(E)*sin(F)-sin(D)*cos(F), cos(D)*sin(E)*cos(F)+sin(D)*sin(F); sin(D)*cos(E), sin(D)*sin(E)*sin(F)+cos(D)*cos(F), sin(D)*sin(E)*cos(F)-cos(D)*sin(F); -sin(E), cos(E)*sin(F), cos(E)*cos(F)];
                              %% Left Son
                              DirectionModified1=DirectionBased*RoMatrix1;
                              DierctionUnied1=DirectionModified1/sqrt(DirectionModified1(1)^2+DirectionModified1(2)^2+DirectionModified1(3)^2);
                              if size(DierctionUnied1,1)>1
                                  DierctionUnied1=sum(DierctionUnied1)/size(DierctionUnied1,1);
                                  DierctionUnied1=DierctionUnied1/sqrt(DierctionUnied1(1)^2+DierctionUnied1(2)^2+DierctionUnied1(3)^2);
                              end
                              %% Right Son
                              DirectionModified2=DirectionBased*RoMatrix2;
                              DierctionUnied2=DirectionModified2/sqrt(DirectionModified2(1)^2+DirectionModified2(2)^2+DirectionModified2(3)^2);
                              if size(DierctionUnied2,1)>1
                                  DierctionUnied2=sum(DierctionUnied2)/size(DierctionUnied2,1);
                                  DierctionUnied2=DierctionUnied2/sqrt(DierctionUnied2(1)^2+DierctionUnied2(2)^2+DierctionUnied2(3)^2);
                              end
                              %% Save Part
                              DirectionL=CellofSingleDirectiononSingleNeurites{IDSearch3+1,2*IDSearch4-1};
                              DirectionR=CellofSingleDirectiononSingleNeurites{IDSearch3+1,2*IDSearch4};
                              CellofSingleDirectiononSingleNeurites{IDSearch3+1,2*IDSearch4-1}=[DirectionL;DierctionUnied1];
                              CellofSingleDirectiononSingleNeurites{IDSearch3+1,2*IDSearch4}=[DirectionR;DierctionUnied2];
                              NeededSegment=NeededNeurite{IDSearch3,IDSearch4};
                              NeedL=NeededNeurite{IDSearch3+1,2*IDSearch4-1};
                              NeededVL=NeededSegment(end,:)+DierctionUnied1*LengthValue*5*10^5*IndexBasedonCentrifugalOrder(IDSearch3+1,2*IDSearch4-1);
%                                disp(NeededVL-NeededSegment(end,:));
                              NeedR=NeededNeurite{IDSearch3+1,2*IDSearch4};
                              NeededVR=NeededSegment(end,:)+DierctionUnied2*LengthValue*5*10^5*IndexBasedonCentrifugalOrder(IDSearch3+1,2*IDSearch4);
                              NeededNeurite{IDSearch3+1,2*IDSearch4-1}=[NeedL;NeededVL];
%                               disp(NeededVR-NeededSegment(end,:));
                              NeededNeurite{IDSearch3+1,2*IDSearch4}=[NeedR;NeededVR];
                          end
                           %% Situation 2
                           if (PreNewIndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4)+PreNewIndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1)==IndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1)+IndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4))&&(IndexofCentrifugalOrder(IDSearch3,IDSearch4)~=0)&&(PreNewIndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4)+PreNewIndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1)==0)
                              DirectionBased=sum(CellofSingleDirectiononSingleNeurites{IDSearch3,IDSearch4})/size(CellofSingleDirectiononSingleNeurites{IDSearch3,IDSearch4},1);
                              A=pi/4*rand(1)*(-1)^randi([1,2],1,1);
                              B=pi/4*rand(1)*(-1)^randi([1,2],1,1);
                              C=pi/4*rand(1)*(-1)^randi([1,2],1,1);
                              RoMatrix1=[cos(A)*cos(B), cos(A)*sin(B)*sin(C)-sin(A)*cos(C), cos(A)*sin(B)*cos(C)+sin(A)*sin(C); sin(A)*cos(B), sin(A)*sin(B)*sin(C)+cos(A)*cos(C), sin(A)*sin(B)*cos(C)-cos(A)*sin(C); -sin(B), cos(B)*sin(C), cos(B)*cos(C)];
                              DirectionModified1=DirectionBased*RoMatrix1;
                              DierctionUnied1=DirectionModified1/sqrt(DirectionModified1(1)^2+DirectionModified1(2)^2+DirectionModified1(3)^2);
                              if size(DierctionUnied1,1)>1
                                  DierctionUnied1=sum(DierctionUnied1)/size(DierctionUnied1,1);
                                  DierctionUnied1=DierctionUnied1/sqrt(DierctionUnied1(1)^2+DierctionUnied1(2)^2+DierctionUnied1(3)^2);
                              end
                              DirectionNeed=CellofSingleDirectiononSingleNeurites{IDSearch3,IDSearch4};
                              CellofSingleDirectiononSingleNeurites{IDSearch3,IDSearch4}=[DirectionNeed;DierctionUnied1];
                              NeededSegment=NeededNeurite{IDSearch3,IDSearch4};
                              NeededV=NeededSegment(end,:)+DierctionUnied1*LengthValue*5*10^5*IndexBasedonCentrifugalOrder(IDSearch3,IDSearch4);
%                               disp(IndexBasedonCentrifugalOrder(IDSearch3,IDSearch4));
%                               disp(NeededV-NeededSegment(end,:));
                              NeededNeurite{IDSearch3,IDSearch4}=[NeededSegment;NeededV];
                           end
                   end
            end
            %% The Size
            for IDSearch3=1:size(PreIndexBasedonCentrifugalOrder,1)-1
                   for IDSearch4=1:size(PreIndexBasedonCentrifugalOrder,2)/2
                          if (PreNewIndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1)>IndexofCentrifugalOrder(IDSearch3+1,2*IDSearch4-1))&&(IndexofCentrifugalOrder(IDSearch3,IDSearch4)~=0)
                              SizeBased=CellofSingleSizeSingleNeurites{IDSearch3,IDSearch4};
                              CellofSingleSizeSingleNeurites{IDSearch3+1,2*IDSearch4-1}=(0.5*(SizeBased)^(3/2))^(2/3);
                              CellofSingleSizeSingleNeurites{IDSearch3+1,2*IDSearch4}=(0.5*(SizeBased)^(3/2))^(2/3);
                          end
                   end
            end
            DirectiononSingleNeuron{IDPart,1}=CellofSingleDirectiononSingleNeurites;
            IndexofCentrifugalOrderSingleNeuron{IDPart,1}=IndexofCentrifugalOrder;
            PreNewIndexofCentrifugalOrderSingleNeuron{IDPart,1}=PreNewIndexofCentrifugalOrder;
            SizeofNeurtesofSingleNeuron{IDPart,1}=CellofSingleSizeSingleNeurites;
            CellofNeuritesforSingleNeuron{IDPart,1}=NeededNeurite;
            end
      end
      CellofDirection{IDSoma,1}=DirectiononSingleNeuron;
      CellofIndexofCentrifugalOrder{IDSoma,1}=IndexofCentrifugalOrderSingleNeuron;
      CellofPreNewIndexofCentrifugalOrder{IDSoma,1}=PreNewIndexofCentrifugalOrderSingleNeuron;
      CellofSize{IDSoma,1}=SizeofNeurtesofSingleNeuron;
      CellofNeurites{IDSoma,1}=CellofNeuritesforSingleNeuron;
end
CellofDirectionAcrossTime{IDIteration-2,1}=CellofDirection;
CellIndexofCentrifugalOrderAcrossTime{IDIteration-2,1}=CellofIndexofCentrifugalOrder;
CellPreNewIndexofCentrifugalOrderAcrossTime{IDIteration-2,1}=CellofPreNewIndexofCentrifugalOrder;
CellofSizeAcrossTime{IDIteration-2,1}=CellofSize;
CellofNeuritesAcrossTime{IDIteration-2,1}=CellofNeurites;