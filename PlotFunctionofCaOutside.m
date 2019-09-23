function [IterationCellofNeuralSpace]=PlotFunctionofCaOutside(OutsideSpace,InitializedSpaceofCaCell,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace)
%% Load the Information
if  IDIteration==1
    CaSpace=InitializedSpaceofCaCell{end,1};
else
    CaSpace=IterationCellofNeuralSpace{IDIteration-1,1};
end

%% Start to Run the Iteration
      disp(['Space in the Iteration of', num2str(IDIt), '-Starts to Process the Outside Convection']);
      IterationCellofNeuralSpace{IDIteration,1}=ConvectionofCaOutsideDuringDevelopment(CaSpace,BasicSettings,SituationCCaConvection,OutsideSpace);