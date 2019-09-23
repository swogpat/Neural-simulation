function [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration)
disp(IDIteration);
AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
Pmax=0.0000001;
InfluenceRegion=40;   %% Can not be odd
CompetationValueVectorCell=cell(size(AddValueVectorMultiCell,1),1);
if IDIteration==1
    MValueVector1=zeros(size(AddValueVectorMultiCell,1),1);
    MValueVector2=zeros(size(AddValueVectorMultiCell,1),1);
    for ID=1:size(AddValueVectorMultiCell,1)
          AddValueVectorSingleCell=AddValueVectorMultiCell{ID,1};
          CompetationValueVector=ones(size(AddValueVectorSingleCell,1),1);
          CompetationValueVectorCell{ID,1}=CompetationValueVector;
    end
elseif IDIteration>1
    disp(IDIteration);
    DPofLamellipodiaCellAccrostheTime=MulitDPofLamellipodiaCellAccrostheTime{IDIteration-1,1};
    for ID=1:size(DPofLamellipodiaCellAccrostheTime,1)
         AddValueVectorSingleCell=AddValueVectorMultiCell{ID,1};
         NeededVector1=DPofLamellipodiaCellAccrostheTime{ID,2};
         MValueVector1(ID,1)=sum(sum(NeededVector1));
         NeededVector2=DPofLamellipodiaCellAccrostheTime{ID,3};
         MValueVector2(ID,1)=sum(sum(NeededVector2));
         CompetationValueVector=ones(size(AddValueVectorSingleCell,1),1);
         for ID1=1:size(AddValueVectorSingleCell,1)
               if (ID1>InfluenceRegion*0.5)&&(ID1<(size(AddValueVectorSingleCell,1)-InfluenceRegion*0.5+1))
                   CompetationValueVector(ID1,1)=(InfluenceRegion-sum(sum(NeededVector1(ID1-InfluenceRegion*0.5:ID1-1)))-sum(sum(NeededVector1(ID1+1:ID1+InfluenceRegion*0.5))))/InfluenceRegion;
               elseif (ID1<InfluenceRegion*0.5)||(ID1==InfluenceRegion*0.5)
                   CompetationValueVector(ID1,1)=(InfluenceRegion-sum(sum(NeededVector1(1:ID1-1)))-sum(sum(NeededVector1(size(AddValueVectorSingleCell,1)-(InfluenceRegion*0.5-(ID1-1))+1:size(AddValueVectorSingleCell,1))))-sum(sum(NeededVector1(ID1+1:ID1+InfluenceRegion*0.5))))/InfluenceRegion;
               elseif (ID1>(size(AddValueVectorSingleCell,1)-InfluenceRegion*0.5+1))||(ID1==(size(AddValueVectorSingleCell,1)-InfluenceRegion*0.5+1))
                   CompetationValueVector(ID1,1)=(InfluenceRegion-sum(sum(NeededVector1(ID1+1:size(AddValueVectorSingleCell,1))))-sum(sum(NeededVector1(1:(InfluenceRegion*0.5-(size(AddValueVectorSingleCell,1)-ID1+1)))))-sum(sum(NeededVector1(ID1-InfluenceRegion*0.5:ID1-1))))/InfluenceRegion;
               end
         end
         CompetationValueVectorCell{ID,1}=CompetationValueVector;
    end
end

%% 
if IDIteration==1
    MulitDPofLamellipodiaCell=cell(size(AddValueVectorMultiCell,1),4);
    for ID=1:size(AddValueVectorMultiCell,1)
          disp(['We are analyzing the lamellipodia situation of Neuron', num2str(ID)])
          AddValueVectorSingleCell=AddValueVectorMultiCell{ID,1};
          AddValueforEachPoint=zeros(size(AddValueVectorSingleCell,1),1);
          CompetationValueVector=CompetationValueVectorCell{ID,1};
          for ID1=1:size(AddValueVectorSingleCell,1)
                 if isnan(AddValueVectorSingleCell{ID1,1})
                      AddValueforEachPoint(ID1,1)=0;
                 else
                      AddValueVector=AddValueVectorSingleCell{ID1,1};
                      AddValueforEachPoint(ID1,1)=AddValueVector(1,4);
                 end
          end
          MaxC=max(max(AddValueforEachPoint));
          DPofLamellipodia=zeros(size(AddValueVectorSingleCell,1),1);
          for ID2=1:size(AddValueVectorSingleCell,1)
                DPofLamellipodia(ID2,1)=Pmax*(2*(AddValueforEachPoint(ID2,1)/MaxC)-(AddValueforEachPoint(ID2,1)/MaxC)^2);
          end
          RuntheRandomizationforD=zeros(size(AddValueVectorSingleCell,1),1);
          for ID2=1:size(AddValueVectorSingleCell,1)
                PValue=(CompetationValueVector(ID2)^5)*DPofLamellipodia(ID2,1);
                NeededOnes=ceil(PValue*1000);
                NeededZeros=1000-NeededOnes;
                NeededValue=[ones(1,NeededOnes),zeros(1,NeededZeros)];
                RandomedValue=NeededValue(randperm(1000));
                NeedtoPick=randperm(1000);
                RuntheRandomizationforD(ID2,1)=RandomedValue(NeedtoPick(1));
          end
          MulitDPofLamellipodiaCell{ID,4}=RuntheRandomizationforD;
          if sum(sum(RuntheRandomizationforD))-(MValueVector1(ID,1)-MValueVector2(ID,1))>0
                  PrValueR=(sum(sum(RuntheRandomizationforD))-(MValueVector1(ID,1)-MValueVector2(ID,1)))/(size(AddValueVectorSingleCell,1)-sum(sum(RuntheRandomizationforD)));
                  RuntheRandomizationforR=zeros(size(AddValueVectorSingleCell,1),1);
                  for ID3=1:size(AddValueVectorSingleCell,1)
                        PRValue=PrValueR*(1-DPofLamellipodia(ID3,1));
                        NeededOnesR=ceil(PRValue*1000);
                        NeededZerosR=1000-NeededOnesR;
                        NeededValueR=[ones(1,NeededOnesR),zeros(1,NeededZerosR)];
                        RandomedValueR=NeededValueR(randperm(1000));
                        NeedtoPickR=randperm(1000);
                        RuntheRandomizationforR(ID2,1)=RandomedValueR(NeedtoPickR(1));
                  end
                  for ID3=1:size(AddValueVectorSingleCell,1)
                       if RuntheRandomizationforD(ID3,1)==1
                          RuntheRandomizationforR=0;
                       end
                  end
                  MulitDPofLamellipodiaCell{ID,3}=RuntheRandomizationforR;
          else
                 RuntheRandomizationforR=zeros(size(AddValueVectorSingleCell,1),1);
                 MulitDPofLamellipodiaCell{ID,3}=RuntheRandomizationforR;
          end
           MulitDPofLamellipodiaCell{ID,1}=DPofLamellipodia;
           MulitDPofLamellipodiaCell{ID,2}=RuntheRandomizationforD;
    end
else
%       MulitDPofLamellipodiaCell=MulitDPofLamellipodiaCellAccrostheTime{IDIteration-1,1};
          MulitDPofLamellipodiaCell=cell(size(AddValueVectorMultiCell,1),4);
      for ID=1:size(AddValueVectorMultiCell,1)
          disp(['We are analyzing the lamellipodia situation of Neuron', num2str(ID)])
          AddValueVectorSingleCell=AddValueVectorMultiCell{ID,1};
          AddValueforEachPoint=zeros(size(AddValueVectorSingleCell,1),1);
          CompetationValueVector=CompetationValueVectorCell{ID,1};
          for ID1=1:size(AddValueVectorSingleCell,1)
                 if isnan(AddValueVectorSingleCell{ID1,1})
                      AddValueforEachPoint(ID1,1)=0;
                 else
                      AddValueVector=AddValueVectorSingleCell{ID1,1};
                      AddValueforEachPoint(ID1,1)=AddValueVector(1,4);
                 end
          end
          MaxC=max(max(AddValueforEachPoint));
          DPofLamellipodia=zeros(size(AddValueVectorSingleCell,1),1);
          for ID2=1:size(AddValueVectorSingleCell,1)
                DPofLamellipodia(ID2,1)=Pmax*(2*(AddValueforEachPoint(ID2,1)/MaxC)-(AddValueforEachPoint(ID2,1)/MaxC)^2);
          end
          RuntheRandomizationforD=zeros(size(AddValueVectorSingleCell,1),1);
          for ID2=1:size(AddValueVectorSingleCell,1)
                PValue=(CompetationValueVector(ID2)^5)*DPofLamellipodia(ID2,1);
                NeededOnes=ceil(PValue*1000);
                NeededZeros=1000-NeededOnes;
                NeededValue=[ones(1,NeededOnes),zeros(1,NeededZeros)];
                RandomedValue=NeededValue(randperm(1000));
                NeedtoPick=randperm(1000);
                RuntheRandomizationforD(ID2,1)=RandomedValue(NeedtoPick(1));
          end
%           OldRuntheRandomizationforD=MulitDPofLamellipodiaCell{ID,4};
%           RuntheRandomizationforD=RuntheRandomizationforD+OldRuntheRandomizationforD;
          MulitDPofLamellipodiaCell{ID,4}=RuntheRandomizationforD;
          if sum(sum(RuntheRandomizationforD))-(MValueVector1(ID,1)-MValueVector2(ID,1))>0
                  PrValueR=(sum(sum(RuntheRandomizationforD))-(MValueVector1(ID,1)-MValueVector2(ID,1)))/(size(AddValueVectorSingleCell,1)-sum(sum(RuntheRandomizationforD)));
                  RuntheRandomizationforR=zeros(size(AddValueVectorSingleCell,1),1);
                  for ID3=1:size(AddValueVectorSingleCell,1)
                        PRValue=PrValueR*(1-DPofLamellipodia(ID3,1));
                        NeededOnesR=ceil(PRValue*1000);
                        NeededZerosR=1000-NeededOnesR;
                        NeededValueR=[ones(1,NeededOnesR),zeros(1,NeededZerosR)];
                        RandomedValueR=NeededValueR(randperm(1000));
                        NeedtoPickR=randperm(1000);
                        RuntheRandomizationforR(ID2,1)=RandomedValueR(NeedtoPickR(1));
                  end
                  for ID3=1:size(AddValueVectorSingleCell,1)
                       if RuntheRandomizationforD(ID3,1)==1
                          RuntheRandomizationforR=0;
                       end
                  end
                  MulitDPofLamellipodiaCell{ID,3}=RuntheRandomizationforR;
          else
                 RuntheRandomizationforR=zeros(size(AddValueVectorSingleCell,1),1);
                 MulitDPofLamellipodiaCell{ID,3}=RuntheRandomizationforR;
          end
              PreMulitDPofLamellipodiaCell=MulitDPofLamellipodiaCellAccrostheTime{IDIteration-1,1};
              PreRuntheRandomizationforD=PreMulitDPofLamellipodiaCell{ID,2};
              RuntheRandomizationforD=RuntheRandomizationforD+PreRuntheRandomizationforD;
              for ID4=1:size(RuntheRandomizationforR,1)
                    if RuntheRandomizationforR(ID4,1)==1
                       RuntheRandomizationforD(ID4,1)=0;
                    end
              end
           MulitDPofLamellipodiaCell{ID,1}=DPofLamellipodia;
           MulitDPofLamellipodiaCell{ID,2}=RuntheRandomizationforD;
      end
end
MulitDPofLamellipodiaCellAccrostheTime{IDIteration,1}=MulitDPofLamellipodiaCell;