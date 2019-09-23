function [IterationCellofNeuralSpace]=PlotFunctionofCaInside(InsideSpace,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace)
%% Load the Information
CaSpace=IterationCellofNeuralSpace{IDIteration,1};


%% Start to Run the Iteration
disp(['Space in the Iteration of', num2str(IDIt), '-Starts to Process the Outside Convection']);
IterationCellofNeuralSpace{IDIteration,1}=ConvectionofCaInsideDuringDevelopment(CaSpace,BasicSettings,SituationCCaConvection,InsideSpace);