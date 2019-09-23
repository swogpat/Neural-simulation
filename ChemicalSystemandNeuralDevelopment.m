function [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings)
%% Loading
TubulinProduction=BasicSettingsforChemical.TubulinProduction;
DiffusionCTubulin=BasicSettingsforChemical.DiffusionCTubulin;
AdvectionCTubulin=BasicSettingsforChemical.AdvectionCTubulin;
CEnlongation=BasicSettingsforChemical.CEnlongation;
CAssembly=BasicSettingsforChemical.CAssembly;
CDAssembly=BasicSettingsforChemical.CDAssembly;
CTubulinDecy=BasicSettingsforChemical.CTubulinDecy;
IterationTime=BasicSettings.IterationTime;
CalciumProduction=BasicSettingsforChemical.CalciumProduction;
DiffusionCCalcium=BasicSettingsforChemical.DiffusionCCalcium;
CCalciumDecy=BasicSettingsforChemical.CCalciumDecy;
UMAP2Production=BasicSettingsforChemical.UMAP2Production;
DiffusionCUMAP2=BasicSettingsforChemical.DiffusionCUMAP2;
AdvectionCUMAP2=BasicSettingsforChemical.AdvectionCUMAP2;
CUMAP2Decy=BasicSettingsforChemical.CUMAP2Decy;
PMAP2Decy=BasicSettingsforChemical.PMAP2Decy;
CPCP=BasicSettingsforChemical.CPCP;
CPP=BasicSettingsforChemical.CPP;
CPCD=BasicSettingsforChemical.CPCD;
CPD=BasicSettingsforChemical.CPD;
Beta1=BasicSettingsforChemical.Beta1;
Beta2=BasicSettingsforChemical.Beta2;
Beta3=BasicSettingsforChemical.Beta3;
Beta4=BasicSettingsforChemical.Beta4;
CBUMAP2Decy=BasicSettingsforChemical.CBUMAP2Decy;
% Note that in this computational model, we use the simplified form of our
% analytic model owing to the limitation of the computating power. If you
% want to use the complete form without any simplification, please download
% another vision marked as "Full Vision". And we want to inform you that
% this full vision costs a lot, to our best knowledge, we recommand that
% you use a super computer or a CPU at least 128GB combined with a nice
% GPU to run it (for a long time). We are really sorry about that we can't
% optimize this vision enough. If you are good at computer science and want
% to give us a hand, please feel free to e-mail us and download the file to optimize it.
% We only want you to make it be open source if you upload the optimized model. 

%% The Length Value Iteration
if IDIteration==3
    CellofNeurites=CellofNeuritesAcrossTime{IDIteration-2,1};
    LengthCell=cell(size(CellofNeurites,1),1);
    for IDSoma=1:size(CellofNeurites,1)
          PreLenghtVector=zeros(size(CellofNeurites{IDSoma,1},1)+1,1);
          NeededToThink=CellofNeurites{IDSoma,1};
          for ID0=1:size(CellofNeurites{IDSoma,1},1)
              if isempty(NeededToThink{ID0,1})==0
                  PreLenghtVector(ID0+1,1)=1;
              end
          end
          LengthCell{IDSoma,1}=PreLenghtVector;
    end
    LengthCellAcrossTime{IDIteration-2,1}=LengthCell;
else
     LengthCell=LengthCellAcrossTime{IDIteration-3,1};
    CellofNeurites=CellofNeuritesAcrossTime{IDIteration-2,1};
    PreCellofNeurites=CellofNeuritesAcrossTime{IDIteration-3,1};
    for IDSoma=1:size(CellofNeurites,1)
          PreLenghtVector=LengthCell{IDSoma,1};
          NeededToThink=CellofNeurites{IDSoma,1};
          PreNeededToThink=PreCellofNeurites{IDSoma,1};
          for ID0=1:size(CellofNeurites{IDSoma,1},1)
              if (isempty(NeededToThink{ID0,1})==0)&&(isempty(PreNeededToThink{ID0,1})==1)
                  PreLenghtVector(ID0+1,1)=1;
              elseif (isempty(NeededToThink{ID0,1})==1)&&(isempty(PreNeededToThink{ID0,1})==0)
                  PreLenghtVector(ID0+1,1)=0;
              end
          end
          LengthCell{IDSoma,1}=PreLenghtVector;
    end
end

if IDIteration==3
     TubluinCell=cell(size(CellofNeurites,1),1);
        for IDSoma=1:size(CellofNeurites,1)
              PreTubluinVector=zeros(size(CellofNeurites{IDSoma,1},1)+1,1);
              TubluinCell{IDSoma,1}=PreTubluinVector;
        end
else
      TubluinCell=TubluinCellAcrossTime{IDIteration-3,1};
end

if IDIteration==3
     CalciumCell=cell(size(CellofNeurites,1),1);
        for IDSoma=1:size(CellofNeurites,1)
              PreNewCalciumVector=zeros(size(CellofNeurites{IDSoma,1},1)+1,1);
              CalciumCell{IDSoma,1}=PreNewCalciumVector;
        end
else
      CalciumCell=CalciumCellAcrossTime{IDIteration-3,1};
end

if IDIteration==3
     UMAP2Cell=cell(size(CellofNeurites,1),1);
        for IDSoma=1:size(CellofNeurites,1)
              PreNewUMAP2Vector=zeros(size(CellofNeurites{IDSoma,1},1)+1,1);
              UMAP2Cell{IDSoma,1}=PreNewUMAP2Vector;
        end
else
      UMAP2Cell=UMAP2CellAcrossTime{IDIteration-3,1};
end

if IDIteration==3
     BUMAP2Cell=cell(size(CellofNeurites,1),1);
        for IDSoma=1:size(CellofNeurites,1)
              PreNewBUMAP2Vector=zeros(size(CellofNeurites{IDSoma,1},1)+1,1);
              BUMAP2Cell{IDSoma,1}=PreNewBUMAP2Vector;
        end
else
      BUMAP2Cell=BUMAP2CellAcrossTime{IDIteration-3,1};
end

if IDIteration==3
     PMAP2Cell=cell(size(CellofNeurites,1),1);
        for IDSoma=1:size(CellofNeurites,1)
              PreNewPMAP2Vector=zeros(size(CellofNeurites{IDSoma,1},1)+1,1);
              PMAP2Cell{IDSoma,1}=PreNewPMAP2Vector;
        end
else
      PMAP2Cell=PMAP2CellAcrossTime{IDIteration-3,1};
end

%% The Production, Diffuision and Active Transportation of Tubulin and bound and unphosphorylated MAP-2
NewTubluinCell=cell(size(CellofNeurites,1),1);
for IDSoma=1:size(CellofNeurites,1)
      disp(['Start to Analyze the Situation of Tubulin for Neuron- ',num2cell(IDSoma)]);
      PreTubluinVector=TubluinCell{IDSoma,1};
      PreNewTubluinVector=zeros(size(PreTubluinVector,1),1);
      NewTubluinVector=zeros(size(PreTubluinVector,1),1);
      PreBUMAP2Vector=BUMAP2Cell{IDSoma,1};
      %% Prediction
      %% Production and Decy for Soma
      PreNewTubluinVector(1,1)=PreTubluinVector(1,1)+TubulinProduction*IterationTime-CTubulinDecy*PreTubluinVector(1,1)*IterationTime;
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
      PreLenghtVector=LengthCell{IDSoma,1};
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
       BUMAP2Value=PreBUMAP2Vector(ID1+1,1);
           if LengthValue~=0
              PreNewTubluinVector(1,1)=PreNewTubluinVector(1,1)-1/LengthValue*(PreTubluinVector(1,1)-PreTubluinVector(ID1+1,1))*DiffusionCTubulin*IterationTime-real(AdvectionCTubulin*(CAssembly*CEnlongation*BUMAP2Value*PreTubluinVector(ID1+1,1)-CDAssembly)^0.5)*PreTubluinVector(ID1+1,1)*IterationTime;
              PreNewTubluinVector(ID1+1,1)=PreTubluinVector(ID1+1,1)+1/LengthValue*(PreTubluinVector(1,1)-PreTubluinVector(ID1+1,1))*DiffusionCTubulin*IterationTime+real(AdvectionCTubulin*(CAssembly*CEnlongation*BUMAP2Value*PreTubluinVector(ID1+1,1)-CDAssembly)^0.5)*PreTubluinVector(ID1+1,1)*IterationTime-CAssembly*BUMAP2Value*PreTubluinVector(ID1+1,1)*IterationTime-CTubulinDecy*PreTubluinVector(ID1+1,1)*IterationTime;
           end
      end
      %% Modification
      %% Production and Decy for Soma
      %% Modify
      NewTubluinVector(1,1)=PreTubluinVector(1,1)+TubulinProduction*IterationTime-IterationTime/2*CTubulinDecy*(PreTubluinVector(1,1)+PreNewTubluinVector(1,1));
      for ID1=1:size(PreLenghtVector,1)-1
      LengthValue=PreLenghtVector(ID1+1,1);
      BUMAP2Value=PreBUMAP2Vector(ID1+1,1);
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
          if LengthValue~=0
          %% Part One
         OldTubulinVariation=1/LengthValue*(PreTubluinVector(1,1)-PreTubluinVector(ID1+1,1))*DiffusionCTubulin+real(AdvectionCTubulin*(CAssembly*CEnlongation*BUMAP2Value*PreTubluinVector(ID1+1,1)-CDAssembly)^0.5)*PreTubluinVector(ID1+1,1);
          %% Part Two
         PredictedTubulinVariation=1/LengthValue*(PreNewTubluinVector(1,1)-PreNewTubluinVector(ID1+1,1))*DiffusionCTubulin+real(AdvectionCTubulin*(CAssembly*CEnlongation*BUMAP2Value*PreNewTubluinVector(ID1+1,1)-CDAssembly)^0.5)*PreNewTubluinVector(ID1+1,1);
         %% Modify
         NewTubluinVector(1,1)=NewTubluinVector(1,1)-IterationTime/2*(OldTubulinVariation+PredictedTubulinVariation);
         NewTubluinVector(ID1+1,1)=PreTubluinVector(ID1+1,1)+IterationTime/2*(OldTubulinVariation+PredictedTubulinVariation)-IterationTime/2*CTubulinDecy*(PreTubluinVector(ID1+1,1)+PreTubluinVector(ID1+1,1))-IterationTime/2*CAssembly*(BUMAP2Value*PreNewTubluinVector(ID1+1,1)+BUMAP2Value*PreTubluinVector(ID1+1,1));
          end
      end
      NewTubluinCell{IDSoma,1}=NewTubluinVector;
end
TubluinCellAcrossTime{IDIteration-2,1}=NewTubluinCell;

%% The Production, Diffuision and Active Transportation of Calcium
NewCalciumCell=cell(size(CellofNeurites,1),1);
for IDSoma=1:size(CellofNeurites,1)
    disp(['Start to Analyze the Situation of Calcium for Neuron- ',num2cell(IDSoma)]);
      PreCalciumVector=CalciumCell{IDSoma,1};
       PreNewCalciumVector=zeros(size(PreCalciumVector,1),1);
      NewCalciumVector=zeros(size(PreCalciumVector,1),1);
      %% Prediction
      %% Production and Decy for Soma
      PreNewCalciumVector(1,1)=PreCalciumVector(1,1)+CalciumProduction*IterationTime-CCalciumDecy*PreCalciumVector(1,1)*IterationTime;
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
      PreLenghtVector=LengthCell{IDSoma,1};
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
           if LengthValue~=0
              PreNewCalciumVector(1,1)=PreNewCalciumVector(1,1)-1/LengthValue*(PreCalciumVector(1,1)-PreCalciumVector(ID1+1,1))*DiffusionCCalcium*IterationTime;
              PreNewCalciumVector(ID1+1,1)=PreCalciumVector(ID1+1,1)+1/LengthValue*(PreCalciumVector(1,1)-PreCalciumVector(ID1+1,1))*DiffusionCCalcium*IterationTime-CCalciumDecy*PreCalciumVector(ID1+1,1)*IterationTime;
           end
      end
      %% Modification
      %% Production and Decy for Soma
      %% Modify
      NewCalciumVector(1,1)=PreCalciumVector(1,1)+CalciumProduction*IterationTime-IterationTime/2*CCalciumDecy*(PreCalciumVector(1,1)+PreNewCalciumVector(1,1));
      for ID1=1:size(PreLenghtVector,1)-1
      LengthValue=PreLenghtVector(ID1+1,1);
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
          if LengthValue~=0
          %% Part One
         OldCalciumVariation=1/LengthValue*(PreCalciumVector(1,1)-PreCalciumVector(ID1+1,1))*DiffusionCCalcium;
          %% Part Two
         PredictedCalciumVariation=1/LengthValue*(PreNewCalciumVector(1,1)-PreNewCalciumVector(ID1+1,1))*DiffusionCCalcium;
         %% Modify
         NewCalciumVector(1,1)=NewCalciumVector(1,1)-IterationTime/2*(OldCalciumVariation+PredictedCalciumVariation);
         NewCalciumVector(ID1+1,1)=PreCalciumVector(ID1+1,1)+IterationTime/2*(OldCalciumVariation+PredictedCalciumVariation)-IterationTime/2*CCalciumDecy*(PreCalciumVector(ID1+1,1)+PreNewCalciumVector(ID1+1,1));
          end
      end
      NewCalciumCell{IDSoma,1}=NewCalciumVector;
end
CalciumCellAcrossTime{IDIteration-2,1}=NewCalciumCell;

%% The Production, Diffuision and Active Transportation of unbound MAP-2
NewUMAP2Cell=cell(size(CellofNeurites,1),1);
for IDSoma=1:size(CellofNeurites,1)
      disp(['Start to Analyze the Situation of unbound MAP-2 for Neuron- ',num2cell(IDSoma)]);
      PreUMAP2Vector=UMAP2Cell{IDSoma,1};
      PreBUMAP2Vector=BUMAP2Cell{IDSoma,1};
      PreNewUMAP2Vector=zeros(size(PreUMAP2Vector,1),1);
      NewUMAP2Vector=zeros(size(PreUMAP2Vector,1),1);
      %% Prediction
      %% Production and Decy for Soma
      PreNewUMAP2Vector(1,1)=PreUMAP2Vector(1,1)+UMAP2Production*IterationTime-CUMAP2Decy*PreUMAP2Vector(1,1)*IterationTime;
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
      PreLenghtVector=LengthCell{IDSoma,1};
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
       BUMAP2Value=PreBUMAP2Vector(ID1+1,1);
           if LengthValue~=0
              PreNewUMAP2Vector(1,1)=PreNewUMAP2Vector(1,1)-1/LengthValue*(PreUMAP2Vector(1,1)-PreUMAP2Vector(ID1+1,1))*DiffusionCUMAP2*IterationTime-real(AdvectionCUMAP2*(CAssembly*CEnlongation*BUMAP2Value*PreUMAP2Vector(ID1+1,1)-CDAssembly)^0.5)*PreUMAP2Vector(ID1+1,1)*IterationTime;
              PreNewUMAP2Vector(ID1+1,1)=PreUMAP2Vector(ID1+1,1)+1/LengthValue*(PreUMAP2Vector(1,1)-PreUMAP2Vector(ID1+1,1))*DiffusionCUMAP2*IterationTime+real(AdvectionCUMAP2*(CAssembly*CEnlongation*BUMAP2Value*PreUMAP2Vector(ID1+1,1)-CDAssembly)^0.5)*PreUMAP2Vector(ID1+1,1)*IterationTime-Beta1*PreUMAP2Vector(ID1+1,1)*IterationTime+Beta2*BUMAP2Value*IterationTime-CUMAP2Decy*PreUMAP2Vector(ID1+1,1)*IterationTime;
           end
      end
      %% Modification
      %% Production and Decy for Soma
      %% Modify
      NewUMAP2Vector(1,1)=PreUMAP2Vector(1,1)+UMAP2Production*IterationTime-IterationTime/2*CUMAP2Decy*(PreUMAP2Vector(1,1)+PreNewUMAP2Vector(1,1));
      for ID1=1:size(PreLenghtVector,1)-1
      LengthValue=PreLenghtVector(ID1+1,1);
      BUMAP2Value=PreBUMAP2Vector(ID1+1,1);
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
          if LengthValue~=0
          %% Part One
         OldUMAP2Variation=1/LengthValue*(PreUMAP2Vector(1,1)-PreUMAP2Vector(ID1+1,1))*DiffusionCUMAP2+real(AdvectionCUMAP2*(CAssembly*CEnlongation*BUMAP2Value*PreUMAP2Vector(ID1+1,1)-CDAssembly)^0.5)*PreUMAP2Vector(ID1+1,1);
          %% Part Two
         PredictedUMAP2Variation=1/LengthValue*(PreNewUMAP2Vector(1,1)-PreNewUMAP2Vector(ID1+1,1))*DiffusionCUMAP2+real(AdvectionCUMAP2*(CAssembly*CEnlongation*BUMAP2Value*PreNewUMAP2Vector(ID1+1,1)-CDAssembly)^0.5)*PreNewUMAP2Vector(ID1+1,1);
         %% Modify
         NewUMAP2Vector(1,1)=NewUMAP2Vector(1,1)-IterationTime/2*(OldUMAP2Variation+PredictedUMAP2Variation);
         NewUMAP2Vector(ID1+1,1)=PreUMAP2Vector(ID1+1,1)+IterationTime/2*(OldUMAP2Variation+PredictedUMAP2Variation)-IterationTime/2*CUMAP2Decy*(PreUMAP2Vector(ID1+1,1)+PreNewUMAP2Vector(ID1+1,1))+IterationTime/2*Beta1*PreUMAP2Vector(ID1+1,1)+Beta2*BUMAP2Value*IterationTime;
          end
      end
      NewUMAP2Cell{IDSoma,1}=NewUMAP2Vector;
end
UMAP2CellAcrossTime{IDIteration-2,1}=NewUMAP2Cell;

%% The Production, Diffuision and Active Transportation of bound and unphosphorylated MAP-2
NewBUMAP2Cell=cell(size(CellofNeurites,1),1);
for IDSoma=1:size(CellofNeurites,1)
      disp(['Start to Analyze the Situation of bound and unphosphorylated MAP-2 for Neuron- ',num2cell(IDSoma)]);
      PreUMAP2Vector=UMAP2Cell{IDSoma,1};
      PreBUMAP2Vector=BUMAP2Cell{IDSoma,1};
      PreTubluinVector=TubluinCell{IDSoma,1};
      PrePMAP2Vector=PMAP2Cell{IDSoma,1};
       PreNewBUMAP2Vector=zeros(size(PreBUMAP2Vector,1),1);
      NewBUMAP2Vector=zeros(size(PreBUMAP2Vector,1),1);
      %% Prediction
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
      PreLenghtVector=LengthCell{IDSoma,1};
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
       TubluinValue=PreTubluinVector(ID1+1,1);
       PMAP2Value=PrePMAP2Vector(ID1+1,1);
           if LengthValue~=0
              PreNewBUMAP2Vector(ID1+1,1)=0.0001+PreBUMAP2Vector(ID1+1,1)+Beta1*PreUMAP2Vector(ID1+1,1)*IterationTime-Beta2*PreBUMAP2Vector(ID1+1,1)*IterationTime+Beta3*(TubluinValue^CPCP)/(CPP+TubluinValue^CPCP)*PreBUMAP2Vector(ID1+1,1)*IterationTime-CBUMAP2Decy*PreBUMAP2Vector(ID1+1,1)*IterationTime+Beta4*(TubluinValue^CPCD)/(CPD+TubluinValue^CPCD)*PMAP2Value*IterationTime;
           end
      end
      %% Modification
      %% Production and Decy for Soma
      %% Modify
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
       TubluinValue=PreTubluinVector(ID1+1,1);
       PMAP2Value=PrePMAP2Vector(ID1+1,1);
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
          if LengthValue~=0
          %% Part One
         OldBUMAP2Variation=0.0001+Beta1*PreUMAP2Vector(ID1+1,1)-Beta2*PreBUMAP2Vector(ID1+1,1)+Beta3*(TubluinValue^CPCP)/(CPP+TubluinValue^CPCP)*PreBUMAP2Vector(ID1+1,1)-CBUMAP2Decy*PreBUMAP2Vector(ID1+1,1)+Beta4*(TubluinValue^CPCD)/(CPD+TubluinValue^CPCD)*PMAP2Value;
          %% Part Two
         PredictedBUMAP2Variation=0.0001+Beta1*PreUMAP2Vector(ID1+1,1)-Beta2*PreNewBUMAP2Vector(ID1+1,1)+Beta3*(TubluinValue^CPCP)/(CPP+TubluinValue^CPCP)*PreNewBUMAP2Vector(ID1+1,1)-CBUMAP2Decy*PreNewBUMAP2Vector(ID1+1,1)+Beta4*(TubluinValue^CPCD)/(CPD+TubluinValue^CPCD)*PMAP2Value;
         %% Modify
         NewBUMAP2Vector(ID1+1,1)=PreBUMAP2Vector(ID1+1,1)+IterationTime/2*(OldBUMAP2Variation+PredictedBUMAP2Variation);
          end
      end
      NewBUMAP2Cell{IDSoma,1}=NewBUMAP2Vector;
end
BUMAP2CellAcrossTime{IDIteration-2,1}=NewBUMAP2Cell;

%% The Production, Diffuision and Active Transportation of phosphorylated MAP-2
NewPMAP2Cell=cell(size(CellofNeurites,1),1);
for IDSoma=1:size(CellofNeurites,1)
      disp(['Start to Analyze the Situation of bound and phosphorylated MAP-2 for Neuron- ',num2cell(IDSoma)]);
      PreBUMAP2Vector=BUMAP2Cell{IDSoma,1};
      PreTubluinVector=TubluinCell{IDSoma,1};
      PrePMAP2Vector=PMAP2Cell{IDSoma,1};
      PreNewPMAP2Vector=zeros(size(PrePMAP2Vector,1),1);
      NewPMAP2Vector=zeros(size(PrePMAP2Vector,1),1);
      %% Prediction
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
      PreLenghtVector=LengthCell{IDSoma,1};
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
           if LengthValue~=0
        TubluinValue=PreTubluinVector(ID1+1,1);
%         disp(['TubluinValue is ',num2cell(TubluinValue)]);
              PreNewPMAP2Vector(ID1+1,1)=0.0001+PrePMAP2Vector(ID1+1,1)+Beta3*(TubluinValue^CPCP)/(CPP+TubluinValue^CPCP)*PreBUMAP2Vector(ID1+1,1)*IterationTime-(Beta4*(TubluinValue^CPCD)/(CPD+TubluinValue^CPCD)+PMAP2Decy)*PrePMAP2Vector(ID1+1,1)*IterationTime;
           end
      end
      %% Modification
      %% Production and Decy for Soma
      %% Modify
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
       TubluinValue=PreTubluinVector(ID1+1,1);
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
          if LengthValue~=0
          %% Part One
         OldPMAP2Variation=0.0001+Beta3*(TubluinValue^CPCP)/(CPP+TubluinValue^CPCP)*PreBUMAP2Vector(ID1+1,1)-(Beta4*(TubluinValue^CPCD)/(CPD+TubluinValue^CPCD)+PMAP2Decy)*PrePMAP2Vector(ID1+1,1);
          %% Part Two
         PredictedPMAP2Variation=0.0001+Beta3*(TubluinValue^CPCP)/(CPP+TubluinValue^CPCP)*PreBUMAP2Vector(ID1+1,1)-(Beta4*(TubluinValue^CPCD)/(CPD+TubluinValue^CPCD)+PMAP2Decy)*PreNewPMAP2Vector(ID1+1,1);
         %% Modify
         NewPMAP2Vector(ID1+1,1)=PrePMAP2Vector(ID1+1,1)+IterationTime/2*(OldPMAP2Variation+PredictedPMAP2Variation);
          end
      end
      NewPMAP2Cell{IDSoma,1}=NewPMAP2Vector;
end
PMAP2CellAcrossTime{IDIteration-2,1}=NewPMAP2Cell;

%% Length
NewLengthCell=cell(size(CellofNeurites,1),1);
DeltaLengthCell=cell(size(CellofNeurites,1),1);
for IDSoma=1:size(CellofNeurites,1)
      disp(['Start to Analyze the Growth Length for Neuron- ',num2cell(IDSoma)]);
      PreBUMAP2Vector=BUMAP2Cell{IDSoma,1};
      PreTubluinVector=TubluinCell{IDSoma,1};
      NewTubluinVector=NewTubluinCell{IDSoma,1};
      NewBUMAP2Vector=NewBUMAP2Cell{IDSoma,1};
      %% Prediction
      %% Diffuision, Active Transportation and Decy for Soma and Neurites
      PreLenghtVector=LengthCell{IDSoma,1};
      PreNewLenghtVector=zeros(size(PreLenghtVector,1),1);
      DeltaLenghtVector=zeros(size(PreLenghtVector,1),1);
      for ID1=1:size(PreLenghtVector,1)-1
       LengthValue=PreLenghtVector(ID1+1,1);
           if LengthValue~=0
              PreNewLenghtVector(ID1+1,1)=PreLenghtVector(ID1+1,1)+(CAssembly*CEnlongation*PreBUMAP2Vector(ID1+1,1)*PreTubluinVector(ID1+1,1)-CDAssembly)*IterationTime;
              DeltaLenghtVector(ID1+1,1)=(CAssembly*CEnlongation*(NewBUMAP2Vector(ID1+1,1)-PreBUMAP2Vector(ID1+1,1))*(NewTubluinVector(ID1+1,1)-PreTubluinVector(ID1+1,1)))*IterationTime;
           end
      end
      NewLengthVector=PreNewLenghtVector;
      DeltaLengthCell{IDSoma,1}=DeltaLenghtVector;
      NewLengthCell{IDSoma,1}=NewLengthVector;
end
LengthCellAcrossTime{IDIteration-2,1}=NewLengthCell;
LengthCellAcrossTime{IDIteration-2,2}=DeltaLengthCell;
