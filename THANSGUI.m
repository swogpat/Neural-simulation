function varargout = THANSGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @THANSGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @THANSGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before THANSGUI is made visible.
function THANSGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to THANSGUI (see VARARGIN)

% Choose default command line output for THANSGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes THANSGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = THANSGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
  if get(hObject,'Value') == 1
      %%
% clc; clear all; close all;
%%

% Thanks for using the THANS, an artificial neural system that is
% biological plausible and directly based on biophysics.

% This project is supported by Tsinghua University, China. The Copyright
% belongs to Mr. Yang Tian at tianyang16@mails.tsinghua.edu.cn and Mr.
% Weihua He at hwh16@mails.tsinghua.edu.cn. If you have any question about
% the code, please connect with them via e-mail.

% Note that this code is the vision without GUI, if you want to use GUI,
% please see another vision whose name ends with GUI.

% In short, you need to finish two steps to start your own experiment.
% The first step is to set the initial settings for the system. The second
% step is to set the experiment type.

%% Setting Part for the Whole System
%% Initial Settings
% In this part, we define some basic information for our computtational
% model. The [Width,Length,Hight] will define the whole space, and the norm
% is 1 micrometer. The IterationTime=0.001 means that each iteration
% corresponds to 0.01 s or 10 ms. Apart of that, the norm of all
% concentration is umol/um^3.

Width=50;
Length=50;
Hight=50;
InitialIterationTimes=400;       % This is the iteration number of the initalization part.
MinRadius=15;
MaxRadius=17;
NumofInitialSomas=1;
NumofInitialCa=500;
MinCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*1000*10^(-15);
MaxCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*2000*10^(-15);
MinCCaOutSideFast=1000*10^(-15);
MaxCCaOutSideFast=2000*10^(-15);
MinCCaInSide=0.1*10^(-15);
MaxCCaInSide=1*10^(-15);
IterationTime=0.1;
DeltaX=1;
DeltaY=1;
DeltaZ=1;
DiffusionCCaX=1*10^(-2);
DiffusionCCaY=1*10^(-2);
DiffusionCCaZ=1*10^(-2);
AdvectionCCaX=1*10^(-3);
AdvectionCCaY=1*10^(-3);
AdvectionCCaZ=1*10^(-3);
InfluxPermeabilityConstant=0.0001;      % This is the passive membrane of permeability.
ExperimentTimes=48;  % This is the iteration number of the experiment part.
EnvelopeType=1;

TubulinProduction=2;
DiffusionCTubulin=1*10^(-2);
AdvectionCTubulin=2*10^(-2);
CEnlongation=100;
CAssembly=0.1;
CDAssembly=0.0005;
CTubulinDecy=0.001;
CalciumProduction=0.5;
DiffusionCCalcium=1*10^(-2);
CCalciumDecy=0.001;
CBUMAP2Decy=0.001;
UMAP2Production=1;
DiffusionCUMAP2=1*10^(-2);
AdvectionCUMAP2=2*10^(-2);
CUMAP2Decy=0.001;
PMAP2Decy=0.001;
% CPCP=2;
% CPP=1;
% CPCD=2;
% CPD=1;
% Beta1=0.8;
% Beta2=0.1;
% Beta3=0.1;
% Beta4=1;
CPCP=0.5;
CPP=2;
CPCD=0.5;
CPD=1;
Beta1=0.4;
Beta2=0.05;
Beta3=0.05;
Beta4=0.5;
CBranching=0.01;
CControalBranchingMemory=1; 
CCompetitiveBranchingMemory=0.5;

%% Define the Structure of Settings
% In this part, we define some structure to pass the information.
BasicSettings.Width=Width;
BasicSettings.Length=Length;
BasicSettings.Hight=Hight;
BasicSettings.IterationTime=IterationTime;
BasicSettings.InitialIterationTimes=InitialIterationTimes;
BasicSettings.DeltaX=DeltaX;
BasicSettings.DeltaY=DeltaY;
BasicSettings.DeltaZ=DeltaZ;

SituationCCaOutSide.NumofInitialCa=NumofInitialCa;
SituationCCaOutSide.MinCCaOutSide=MinCCaOutSide;
SituationCCaOutSide.MaxCCaOutSide=MaxCCaOutSide;
SituationCCaOutSide.MinCCaOutSideFast=MinCCaOutSideFast;
SituationCCaOutSide.MaxCCaOutSideFast=MaxCCaOutSideFast;

SituationSomas.NumofInitialSomas=NumofInitialSomas;
SituationSomas.MinRadius=MinRadius;
SituationSomas.MaxRadius=MaxRadius;

SituationCCaConvection.DiffusionCCaX=DiffusionCCaX;
SituationCCaConvection.DiffusionCCaY=DiffusionCCaY;
SituationCCaConvection.DiffusionCCaZ=DiffusionCCaZ;
SituationCCaConvection.AdvectionCCaX=AdvectionCCaX;
SituationCCaConvection.AdvectionCCaY=AdvectionCCaY;
SituationCCaConvection.AdvectionCCaZ=AdvectionCCaZ;
SituationCCaConvection.MinCCaInSide=MinCCaInSide;
SituationCCaConvection.MaxCCaInSide=MaxCCaInSide;

SituationCaInflux.InfluxPermeabilityConstant=InfluxPermeabilityConstant;

BasicSettingsforChemical.TubulinProduction=TubulinProduction;
BasicSettingsforChemical.DiffusionCTubulin=DiffusionCTubulin;
BasicSettingsforChemical.AdvectionCTubulin=AdvectionCTubulin;
BasicSettingsforChemical.CEnlongation=CEnlongation;
BasicSettingsforChemical.CAssembly=CAssembly;
BasicSettingsforChemical.CDAssembly=CDAssembly;
BasicSettingsforChemical.CTubulinDecy=CTubulinDecy;
BasicSettingsforChemical.CalciumProduction=CalciumProduction;
BasicSettingsforChemical.DiffusionCCalcium=DiffusionCCalcium;
BasicSettingsforChemical.CCalciumDecy=CCalciumDecy;
BasicSettingsforChemical.UMAP2Production=UMAP2Production;
BasicSettingsforChemical.DiffusionCUMAP2=DiffusionCUMAP2;
BasicSettingsforChemical.AdvectionCUMAP2=AdvectionCUMAP2;
BasicSettingsforChemical.CUMAP2Decy=CUMAP2Decy;
BasicSettingsforChemical.PMAP2Decy=PMAP2Decy;
BasicSettingsforChemical.CPCP=CPCP;
BasicSettingsforChemical.CPP=CPP;
BasicSettingsforChemical.CPCD=CPCD;
BasicSettingsforChemical.CPD=CPD;
BasicSettingsforChemical.Beta1=Beta1;
BasicSettingsforChemical.Beta2=Beta2;
BasicSettingsforChemical.Beta3=Beta3;
BasicSettingsforChemical.Beta4=Beta4;
BasicSettingsforChemical.CBUMAP2Decy=CBUMAP2Decy;
BasicSettingsforChemical.CBranching=CBranching;
BasicSettingsforChemical.CControalBranchingMemory=CControalBranchingMemory;
BasicSettingsforChemical.CCompetitiveBranchingMemory=CCompetitiveBranchingMemory;
%% Experiment Type
% There are two types of experiments. The first type is the complete one
% that starts from the initialization of Ca distributaion based on the
% convection process. The second type is the fast one, which starts from
% the initialization of Ca distribution based on the random distribution.
% If you want to test the whole system, we encourage you to use the first
% type and please note that the InitialIterationTimes should be set large
% enough (for instance 5000 for a 500*500*500 space). But if you only care
% about the neural development and just want to do some neural experiment,
% we encourage you to use the second type so that you don't need to wait
% for a really long time to initialize the Ca distribution. 

% If you want to run the first type, do not set the space to be too large,
% or the MATLAB might breakdown if you don't have enough computing power!

InitializationType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Experiment Part
% This is the experiment part, you will need to wait for a while to let the
% system finish running. 
%% Initialization Experiment
if InitializationType==1
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas,FigureofInitialSoma]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Initialization Distribution of Ca
    disp('Define the Initialization Distribution of Ca');
    [CellofInitialCentroidofCa,VectorofInitialCofCa]=InitializationofCaDistribution(SituationCCaOutSide,BasicSettings);
    InformationInitializedofCa.CellofInitialCentroidofCa=CellofInitialCentroidofCa;
    InformationInitializedofCa.VectorofInitialCofCa=VectorofInitialCofCa;
    %% Plot the Initializetion Distribution of Ca
    disp('Plot the Initializetion Distribution of Ca');
    [SpaceofCaCell]=PlotFunctionofCa(InformationInitializedofCa,InformationInitializedofSomas,SituationCCaConvection,BasicSettings);
    %% Display the Statical Data for the Initialized Distribution of Ca
    disp('Display the Statical Data for the Initialized Distribution of Ca');
    [StaticalInformationStructureofCa]=StaticalAnalysisofCaDistribution(SpaceofCaCell,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
    elseif InitializationType==2
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Second Type of Initialization Distribution of Ca
    [SpaceofCaCell]=FastTypeInitializationofCa(SituationCCaOutSide,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
end

%% Formal Experiment Type
% There are two types of the formal experiments. The first one is
% the complete one, which takes the real-time convection of Ca into
% consideration. The second one is the fast type, which doesn't includes
% the convection of Ca and use a static Ca distribution. If you want to run
% the real situation but a time-costing experiment, you can use the first
% time. If you can accpet the reasonable noise and want a fast experiment,
% you can use the second one.
FormalExperimentType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Neural Development Experiment
IterationCellofInfluxSpace=cell(ExperimentTimes,5);
IterationCellofNeuralSpace=cell(ExperimentTimes,2);
MulitDPofLamellipodiaCellAccrostheTime=cell(ExperimentTimes,1);
LengthCellAcrossTime=cell(ExperimentTimes-2,2);
TubluinCellAcrossTime=cell(ExperimentTimes-2,1);
CalciumCellAcrossTime=cell(ExperimentTimes-2,1);
UMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
BUMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
PMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
CellofNeuritesAcrossTime=cell(ExperimentTimes-2,1);
CellofDirectionAcrossTime=cell(ExperimentTimes-2,1);
CellIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellPreNewIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellofSizeAcrossTime=cell(ExperimentTimes-2,1);
if FormalExperimentType==1
        %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
        %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    for IDIteration=1:ExperimentTimes-1
        %% Convection Outside of Somas
        disp('Deffuision Outside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaOutside(OutsideSpace,InitializedSpaceofCaCell,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Convection Inside of Somas
        disp('Deffuision Inside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaInside(InsideSpace,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
        [FigureofNeuron]=GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
       if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
else
    %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
    for IDIteration=1:ExperimentTimes-1
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
%         GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
        if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
end

view(45,10);
set(gca,'XLim',[-450 450]);
set(gca,'YLim',[-450 450]);
set(gca,'ZLim',[-450 450]);
xlabel('Width \mum');
ylabel('Length \mum');
zlabel('Hight \mum');
title('The Synapse Development of Neurons');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');
print(gcf,'-dbitmap','D:\ACBPlan\OutputData\Initialization\Neuron-.bmp');
  end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
 if get(hObject,'Value') == 1
      %%
% clc; clear all; close all;
%%

% Thanks for using the THANS, an artificial neural system that is
% biological plausible and directly based on biophysics.

% This project is supported by Tsinghua University, China. The Copyright
% belongs to Mr. Yang Tian at tianyang16@mails.tsinghua.edu.cn and Mr.
% Weihua He at hwh16@mails.tsinghua.edu.cn. If you have any question about
% the code, please connect with them via e-mail.

% Note that this code is the vision without GUI, if you want to use GUI,
% please see another vision whose name ends with GUI.

% In short, you need to finish two steps to start your own experiment.
% The first step is to set the initial settings for the system. The second
% step is to set the experiment type.

%% Setting Part for the Whole System
%% Initial Settings
% In this part, we define some basic information for our computtational
% model. The [Width,Length,Hight] will define the whole space, and the norm
% is 1 micrometer. The IterationTime=0.001 means that each iteration
% corresponds to 0.01 s or 10 ms. Apart of that, the norm of all
% concentration is umol/um^3.

Width=150;
Length=150;
Hight=150;
InitialIterationTimes=400;       % This is the iteration number of the initalization part.
MinRadius=15;
MaxRadius=17;
NumofInitialSomas=2;
NumofInitialCa=500;
MinCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*1000*10^(-15);
MaxCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*2000*10^(-15);
MinCCaOutSideFast=1000*10^(-15);
MaxCCaOutSideFast=2000*10^(-15);
MinCCaInSide=0.1*10^(-15);
MaxCCaInSide=1*10^(-15);
IterationTime=0.1;
DeltaX=1;
DeltaY=1;
DeltaZ=1;
DiffusionCCaX=1*10^(-2);
DiffusionCCaY=1*10^(-2);
DiffusionCCaZ=1*10^(-2);
AdvectionCCaX=1*10^(-3);
AdvectionCCaY=1*10^(-3);
AdvectionCCaZ=1*10^(-3);
InfluxPermeabilityConstant=0.0001;      % This is the passive membrane of permeability.
ExperimentTimes=48;  % This is the iteration number of the experiment part.
EnvelopeType=1;

TubulinProduction=2;
DiffusionCTubulin=1*10^(-2);
AdvectionCTubulin=2*10^(-2);
CEnlongation=100;
CAssembly=0.1;
CDAssembly=0.0005;
CTubulinDecy=0.001;
CalciumProduction=0.5;
DiffusionCCalcium=1*10^(-2);
CCalciumDecy=0.001;
CBUMAP2Decy=0.001;
UMAP2Production=1;
DiffusionCUMAP2=1*10^(-2);
AdvectionCUMAP2=2*10^(-2);
CUMAP2Decy=0.001;
PMAP2Decy=0.001;
% CPCP=2;
% CPP=1;
% CPCD=2;
% CPD=1;
% Beta1=0.8;
% Beta2=0.1;
% Beta3=0.1;
% Beta4=1;
CPCP=0.5;
CPP=2;
CPCD=0.5;
CPD=1;
Beta1=0.4;
Beta2=0.05;
Beta3=0.05;
Beta4=0.5;
CBranching=0.01;
CControalBranchingMemory=1; 
CCompetitiveBranchingMemory=0.5;

%% Define the Structure of Settings
% In this part, we define some structure to pass the information.
BasicSettings.Width=Width;
BasicSettings.Length=Length;
BasicSettings.Hight=Hight;
BasicSettings.IterationTime=IterationTime;
BasicSettings.InitialIterationTimes=InitialIterationTimes;
BasicSettings.DeltaX=DeltaX;
BasicSettings.DeltaY=DeltaY;
BasicSettings.DeltaZ=DeltaZ;

SituationCCaOutSide.NumofInitialCa=NumofInitialCa;
SituationCCaOutSide.MinCCaOutSide=MinCCaOutSide;
SituationCCaOutSide.MaxCCaOutSide=MaxCCaOutSide;
SituationCCaOutSide.MinCCaOutSideFast=MinCCaOutSideFast;
SituationCCaOutSide.MaxCCaOutSideFast=MaxCCaOutSideFast;

SituationSomas.NumofInitialSomas=NumofInitialSomas;
SituationSomas.MinRadius=MinRadius;
SituationSomas.MaxRadius=MaxRadius;

SituationCCaConvection.DiffusionCCaX=DiffusionCCaX;
SituationCCaConvection.DiffusionCCaY=DiffusionCCaY;
SituationCCaConvection.DiffusionCCaZ=DiffusionCCaZ;
SituationCCaConvection.AdvectionCCaX=AdvectionCCaX;
SituationCCaConvection.AdvectionCCaY=AdvectionCCaY;
SituationCCaConvection.AdvectionCCaZ=AdvectionCCaZ;
SituationCCaConvection.MinCCaInSide=MinCCaInSide;
SituationCCaConvection.MaxCCaInSide=MaxCCaInSide;

SituationCaInflux.InfluxPermeabilityConstant=InfluxPermeabilityConstant;

BasicSettingsforChemical.TubulinProduction=TubulinProduction;
BasicSettingsforChemical.DiffusionCTubulin=DiffusionCTubulin;
BasicSettingsforChemical.AdvectionCTubulin=AdvectionCTubulin;
BasicSettingsforChemical.CEnlongation=CEnlongation;
BasicSettingsforChemical.CAssembly=CAssembly;
BasicSettingsforChemical.CDAssembly=CDAssembly;
BasicSettingsforChemical.CTubulinDecy=CTubulinDecy;
BasicSettingsforChemical.CalciumProduction=CalciumProduction;
BasicSettingsforChemical.DiffusionCCalcium=DiffusionCCalcium;
BasicSettingsforChemical.CCalciumDecy=CCalciumDecy;
BasicSettingsforChemical.UMAP2Production=UMAP2Production;
BasicSettingsforChemical.DiffusionCUMAP2=DiffusionCUMAP2;
BasicSettingsforChemical.AdvectionCUMAP2=AdvectionCUMAP2;
BasicSettingsforChemical.CUMAP2Decy=CUMAP2Decy;
BasicSettingsforChemical.PMAP2Decy=PMAP2Decy;
BasicSettingsforChemical.CPCP=CPCP;
BasicSettingsforChemical.CPP=CPP;
BasicSettingsforChemical.CPCD=CPCD;
BasicSettingsforChemical.CPD=CPD;
BasicSettingsforChemical.Beta1=Beta1;
BasicSettingsforChemical.Beta2=Beta2;
BasicSettingsforChemical.Beta3=Beta3;
BasicSettingsforChemical.Beta4=Beta4;
BasicSettingsforChemical.CBUMAP2Decy=CBUMAP2Decy;
BasicSettingsforChemical.CBranching=CBranching;
BasicSettingsforChemical.CControalBranchingMemory=CControalBranchingMemory;
BasicSettingsforChemical.CCompetitiveBranchingMemory=CCompetitiveBranchingMemory;
%% Experiment Type
% There are two types of experiments. The first type is the complete one
% that starts from the initialization of Ca distributaion based on the
% convection process. The second type is the fast one, which starts from
% the initialization of Ca distribution based on the random distribution.
% If you want to test the whole system, we encourage you to use the first
% type and please note that the InitialIterationTimes should be set large
% enough (for instance 5000 for a 500*500*500 space). But if you only care
% about the neural development and just want to do some neural experiment,
% we encourage you to use the second type so that you don't need to wait
% for a really long time to initialize the Ca distribution. 

% If you want to run the first type, do not set the space to be too large,
% or the MATLAB might breakdown if you don't have enough computing power!

InitializationType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Experiment Part
% This is the experiment part, you will need to wait for a while to let the
% system finish running. 
%% Initialization Experiment
if InitializationType==1
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas,FigureofInitialSoma]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Initialization Distribution of Ca
    disp('Define the Initialization Distribution of Ca');
    [CellofInitialCentroidofCa,VectorofInitialCofCa]=InitializationofCaDistribution(SituationCCaOutSide,BasicSettings);
    InformationInitializedofCa.CellofInitialCentroidofCa=CellofInitialCentroidofCa;
    InformationInitializedofCa.VectorofInitialCofCa=VectorofInitialCofCa;
    %% Plot the Initializetion Distribution of Ca
    disp('Plot the Initializetion Distribution of Ca');
    [SpaceofCaCell]=PlotFunctionofCa(InformationInitializedofCa,InformationInitializedofSomas,SituationCCaConvection,BasicSettings);
    %% Display the Statical Data for the Initialized Distribution of Ca
    disp('Display the Statical Data for the Initialized Distribution of Ca');
    [StaticalInformationStructureofCa]=StaticalAnalysisofCaDistribution(SpaceofCaCell,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
    elseif InitializationType==2
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Second Type of Initialization Distribution of Ca
    [SpaceofCaCell]=FastTypeInitializationofCa(SituationCCaOutSide,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
end

%% Formal Experiment Type
% There are two types of the formal experiments. The first one is
% the complete one, which takes the real-time convection of Ca into
% consideration. The second one is the fast type, which doesn't includes
% the convection of Ca and use a static Ca distribution. If you want to run
% the real situation but a time-costing experiment, you can use the first
% time. If you can accpet the reasonable noise and want a fast experiment,
% you can use the second one.
FormalExperimentType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Neural Development Experiment
IterationCellofInfluxSpace=cell(ExperimentTimes,5);
IterationCellofNeuralSpace=cell(ExperimentTimes,2);
MulitDPofLamellipodiaCellAccrostheTime=cell(ExperimentTimes,1);
LengthCellAcrossTime=cell(ExperimentTimes-2,2);
TubluinCellAcrossTime=cell(ExperimentTimes-2,1);
CalciumCellAcrossTime=cell(ExperimentTimes-2,1);
UMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
BUMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
PMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
CellofNeuritesAcrossTime=cell(ExperimentTimes-2,1);
CellofDirectionAcrossTime=cell(ExperimentTimes-2,1);
CellIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellPreNewIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellofSizeAcrossTime=cell(ExperimentTimes-2,1);
if FormalExperimentType==1
        %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
        %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    for IDIteration=1:ExperimentTimes-1
        %% Convection Outside of Somas
        disp('Deffuision Outside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaOutside(OutsideSpace,InitializedSpaceofCaCell,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Convection Inside of Somas
        disp('Deffuision Inside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaInside(InsideSpace,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
        [FigureofNeuron]=GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
       if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
else
    %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
    for IDIteration=1:ExperimentTimes-1
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
%         GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
        if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
end

view(45,10);
set(gca,'XLim',[-450 450]);
set(gca,'YLim',[-450 450]);
set(gca,'ZLim',[-450 450]);
xlabel('Width \mum');
ylabel('Length \mum');
zlabel('Hight \mum');
title('The Synapse Development of Neurons');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');
print(gcf,'-dbitmap','D:\ACBPlan\OutputData\Initialization\Neuron-.bmp');
  end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
 if get(hObject,'Value') == 1
      %%
% clc; clear all; close all;
%%

% Thanks for using the THANS, an artificial neural system that is
% biological plausible and directly based on biophysics.

% This project is supported by Tsinghua University, China. The Copyright
% belongs to Mr. Yang Tian at tianyang16@mails.tsinghua.edu.cn and Mr.
% Weihua He at hwh16@mails.tsinghua.edu.cn. If you have any question about
% the code, please connect with them via e-mail.

% Note that this code is the vision without GUI, if you want to use GUI,
% please see another vision whose name ends with GUI.

% In short, you need to finish two steps to start your own experiment.
% The first step is to set the initial settings for the system. The second
% step is to set the experiment type.

%% Setting Part for the Whole System
%% Initial Settings
% In this part, we define some basic information for our computtational
% model. The [Width,Length,Hight] will define the whole space, and the norm
% is 1 micrometer. The IterationTime=0.001 means that each iteration
% corresponds to 0.01 s or 10 ms. Apart of that, the norm of all
% concentration is umol/um^3.

Width=150;
Length=150;
Hight=150;
InitialIterationTimes=400;       % This is the iteration number of the initalization part.
MinRadius=15;
MaxRadius=17;
NumofInitialSomas=3;
NumofInitialCa=500;
MinCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*1000*10^(-15);
MaxCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*2000*10^(-15);
MinCCaOutSideFast=1000*10^(-15);
MaxCCaOutSideFast=2000*10^(-15);
MinCCaInSide=0.1*10^(-15);
MaxCCaInSide=1*10^(-15);
IterationTime=0.1;
DeltaX=1;
DeltaY=1;
DeltaZ=1;
DiffusionCCaX=1*10^(-2);
DiffusionCCaY=1*10^(-2);
DiffusionCCaZ=1*10^(-2);
AdvectionCCaX=1*10^(-3);
AdvectionCCaY=1*10^(-3);
AdvectionCCaZ=1*10^(-3);
InfluxPermeabilityConstant=0.0001;      % This is the passive membrane of permeability.
ExperimentTimes=48;  % This is the iteration number of the experiment part.
EnvelopeType=1;

TubulinProduction=2;
DiffusionCTubulin=1*10^(-2);
AdvectionCTubulin=2*10^(-2);
CEnlongation=100;
CAssembly=0.1;
CDAssembly=0.0005;
CTubulinDecy=0.001;
CalciumProduction=0.5;
DiffusionCCalcium=1*10^(-2);
CCalciumDecy=0.001;
CBUMAP2Decy=0.001;
UMAP2Production=1;
DiffusionCUMAP2=1*10^(-2);
AdvectionCUMAP2=2*10^(-2);
CUMAP2Decy=0.001;
PMAP2Decy=0.001;
% CPCP=2;
% CPP=1;
% CPCD=2;
% CPD=1;
% Beta1=0.8;
% Beta2=0.1;
% Beta3=0.1;
% Beta4=1;
CPCP=0.5;
CPP=2;
CPCD=0.5;
CPD=1;
Beta1=0.4;
Beta2=0.05;
Beta3=0.05;
Beta4=0.5;
CBranching=0.01;
CControalBranchingMemory=1; 
CCompetitiveBranchingMemory=0.5;

%% Define the Structure of Settings
% In this part, we define some structure to pass the information.
BasicSettings.Width=Width;
BasicSettings.Length=Length;
BasicSettings.Hight=Hight;
BasicSettings.IterationTime=IterationTime;
BasicSettings.InitialIterationTimes=InitialIterationTimes;
BasicSettings.DeltaX=DeltaX;
BasicSettings.DeltaY=DeltaY;
BasicSettings.DeltaZ=DeltaZ;

SituationCCaOutSide.NumofInitialCa=NumofInitialCa;
SituationCCaOutSide.MinCCaOutSide=MinCCaOutSide;
SituationCCaOutSide.MaxCCaOutSide=MaxCCaOutSide;
SituationCCaOutSide.MinCCaOutSideFast=MinCCaOutSideFast;
SituationCCaOutSide.MaxCCaOutSideFast=MaxCCaOutSideFast;

SituationSomas.NumofInitialSomas=NumofInitialSomas;
SituationSomas.MinRadius=MinRadius;
SituationSomas.MaxRadius=MaxRadius;

SituationCCaConvection.DiffusionCCaX=DiffusionCCaX;
SituationCCaConvection.DiffusionCCaY=DiffusionCCaY;
SituationCCaConvection.DiffusionCCaZ=DiffusionCCaZ;
SituationCCaConvection.AdvectionCCaX=AdvectionCCaX;
SituationCCaConvection.AdvectionCCaY=AdvectionCCaY;
SituationCCaConvection.AdvectionCCaZ=AdvectionCCaZ;
SituationCCaConvection.MinCCaInSide=MinCCaInSide;
SituationCCaConvection.MaxCCaInSide=MaxCCaInSide;

SituationCaInflux.InfluxPermeabilityConstant=InfluxPermeabilityConstant;

BasicSettingsforChemical.TubulinProduction=TubulinProduction;
BasicSettingsforChemical.DiffusionCTubulin=DiffusionCTubulin;
BasicSettingsforChemical.AdvectionCTubulin=AdvectionCTubulin;
BasicSettingsforChemical.CEnlongation=CEnlongation;
BasicSettingsforChemical.CAssembly=CAssembly;
BasicSettingsforChemical.CDAssembly=CDAssembly;
BasicSettingsforChemical.CTubulinDecy=CTubulinDecy;
BasicSettingsforChemical.CalciumProduction=CalciumProduction;
BasicSettingsforChemical.DiffusionCCalcium=DiffusionCCalcium;
BasicSettingsforChemical.CCalciumDecy=CCalciumDecy;
BasicSettingsforChemical.UMAP2Production=UMAP2Production;
BasicSettingsforChemical.DiffusionCUMAP2=DiffusionCUMAP2;
BasicSettingsforChemical.AdvectionCUMAP2=AdvectionCUMAP2;
BasicSettingsforChemical.CUMAP2Decy=CUMAP2Decy;
BasicSettingsforChemical.PMAP2Decy=PMAP2Decy;
BasicSettingsforChemical.CPCP=CPCP;
BasicSettingsforChemical.CPP=CPP;
BasicSettingsforChemical.CPCD=CPCD;
BasicSettingsforChemical.CPD=CPD;
BasicSettingsforChemical.Beta1=Beta1;
BasicSettingsforChemical.Beta2=Beta2;
BasicSettingsforChemical.Beta3=Beta3;
BasicSettingsforChemical.Beta4=Beta4;
BasicSettingsforChemical.CBUMAP2Decy=CBUMAP2Decy;
BasicSettingsforChemical.CBranching=CBranching;
BasicSettingsforChemical.CControalBranchingMemory=CControalBranchingMemory;
BasicSettingsforChemical.CCompetitiveBranchingMemory=CCompetitiveBranchingMemory;
%% Experiment Type
% There are two types of experiments. The first type is the complete one
% that starts from the initialization of Ca distributaion based on the
% convection process. The second type is the fast one, which starts from
% the initialization of Ca distribution based on the random distribution.
% If you want to test the whole system, we encourage you to use the first
% type and please note that the InitialIterationTimes should be set large
% enough (for instance 5000 for a 500*500*500 space). But if you only care
% about the neural development and just want to do some neural experiment,
% we encourage you to use the second type so that you don't need to wait
% for a really long time to initialize the Ca distribution. 

% If you want to run the first type, do not set the space to be too large,
% or the MATLAB might breakdown if you don't have enough computing power!

InitializationType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Experiment Part
% This is the experiment part, you will need to wait for a while to let the
% system finish running. 
%% Initialization Experiment
if InitializationType==1
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas,FigureofInitialSoma]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Initialization Distribution of Ca
    disp('Define the Initialization Distribution of Ca');
    [CellofInitialCentroidofCa,VectorofInitialCofCa]=InitializationofCaDistribution(SituationCCaOutSide,BasicSettings);
    InformationInitializedofCa.CellofInitialCentroidofCa=CellofInitialCentroidofCa;
    InformationInitializedofCa.VectorofInitialCofCa=VectorofInitialCofCa;
    %% Plot the Initializetion Distribution of Ca
    disp('Plot the Initializetion Distribution of Ca');
    [SpaceofCaCell]=PlotFunctionofCa(InformationInitializedofCa,InformationInitializedofSomas,SituationCCaConvection,BasicSettings);
    %% Display the Statical Data for the Initialized Distribution of Ca
    disp('Display the Statical Data for the Initialized Distribution of Ca');
    [StaticalInformationStructureofCa]=StaticalAnalysisofCaDistribution(SpaceofCaCell,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
    elseif InitializationType==2
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Second Type of Initialization Distribution of Ca
    [SpaceofCaCell]=FastTypeInitializationofCa(SituationCCaOutSide,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
end

%% Formal Experiment Type
% There are two types of the formal experiments. The first one is
% the complete one, which takes the real-time convection of Ca into
% consideration. The second one is the fast type, which doesn't includes
% the convection of Ca and use a static Ca distribution. If you want to run
% the real situation but a time-costing experiment, you can use the first
% time. If you can accpet the reasonable noise and want a fast experiment,
% you can use the second one.
FormalExperimentType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Neural Development Experiment
IterationCellofInfluxSpace=cell(ExperimentTimes,5);
IterationCellofNeuralSpace=cell(ExperimentTimes,2);
MulitDPofLamellipodiaCellAccrostheTime=cell(ExperimentTimes,1);
LengthCellAcrossTime=cell(ExperimentTimes-2,2);
TubluinCellAcrossTime=cell(ExperimentTimes-2,1);
CalciumCellAcrossTime=cell(ExperimentTimes-2,1);
UMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
BUMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
PMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
CellofNeuritesAcrossTime=cell(ExperimentTimes-2,1);
CellofDirectionAcrossTime=cell(ExperimentTimes-2,1);
CellIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellPreNewIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellofSizeAcrossTime=cell(ExperimentTimes-2,1);
if FormalExperimentType==1
        %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
        %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    for IDIteration=1:ExperimentTimes-1
        %% Convection Outside of Somas
        disp('Deffuision Outside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaOutside(OutsideSpace,InitializedSpaceofCaCell,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Convection Inside of Somas
        disp('Deffuision Inside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaInside(InsideSpace,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
        [FigureofNeuron]=GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
       if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
else
    %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
    for IDIteration=1:ExperimentTimes-1
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
%         GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
        if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
end

view(45,10);
set(gca,'XLim',[-450 450]);
set(gca,'YLim',[-450 450]);
set(gca,'ZLim',[-450 450]);
xlabel('Width \mum');
ylabel('Length \mum');
zlabel('Hight \mum');
title('The Synapse Development of Neurons');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');
print(gcf,'-dbitmap','D:\ACBPlan\OutputData\Initialization\Neuron-.bmp');
  end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    if get(hObject,'Value') == 1
      %%
% clc; clear all; close all;
%%

% Thanks for using the THANS, an artificial neural system that is
% biological plausible and directly based on biophysics.

% This project is supported by Tsinghua University, China. The Copyright
% belongs to Mr. Yang Tian at tianyang16@mails.tsinghua.edu.cn and Mr.
% Weihua He at hwh16@mails.tsinghua.edu.cn. If you have any question about
% the code, please connect with them via e-mail.

% Note that this code is the vision without GUI, if you want to use GUI,
% please see another vision whose name ends with GUI.

% In short, you need to finish two steps to start your own experiment.
% The first step is to set the initial settings for the system. The second
% step is to set the experiment type.

%% Setting Part for the Whole System
%% Initial Settings
% In this part, we define some basic information for our computtational
% model. The [Width,Length,Hight] will define the whole space, and the norm
% is 1 micrometer. The IterationTime=0.001 means that each iteration
% corresponds to 0.01 s or 10 ms. Apart of that, the norm of all
% concentration is umol/um^3.

Width=200;
Length=200;
Hight=200;
InitialIterationTimes=400;       % This is the iteration number of the initalization part.
MinRadius=15;
MaxRadius=17;
NumofInitialSomas=4;
NumofInitialCa=500;
MinCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*1000*10^(-15);
MaxCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*2000*10^(-15);
MinCCaOutSideFast=1000*10^(-15);
MaxCCaOutSideFast=2000*10^(-15);
MinCCaInSide=0.1*10^(-15);
MaxCCaInSide=1*10^(-15);
IterationTime=0.1;
DeltaX=1;
DeltaY=1;
DeltaZ=1;
DiffusionCCaX=1*10^(-2);
DiffusionCCaY=1*10^(-2);
DiffusionCCaZ=1*10^(-2);
AdvectionCCaX=1*10^(-3);
AdvectionCCaY=1*10^(-3);
AdvectionCCaZ=1*10^(-3);
InfluxPermeabilityConstant=0.0001;      % This is the passive membrane of permeability.
ExperimentTimes=48;  % This is the iteration number of the experiment part.
EnvelopeType=1;

TubulinProduction=2;
DiffusionCTubulin=1*10^(-2);
AdvectionCTubulin=2*10^(-2);
CEnlongation=100;
CAssembly=0.1;
CDAssembly=0.0005;
CTubulinDecy=0.001;
CalciumProduction=0.5;
DiffusionCCalcium=1*10^(-2);
CCalciumDecy=0.001;
CBUMAP2Decy=0.001;
UMAP2Production=1;
DiffusionCUMAP2=1*10^(-2);
AdvectionCUMAP2=2*10^(-2);
CUMAP2Decy=0.001;
PMAP2Decy=0.001;
% CPCP=2;
% CPP=1;
% CPCD=2;
% CPD=1;
% Beta1=0.8;
% Beta2=0.1;
% Beta3=0.1;
% Beta4=1;
CPCP=0.5;
CPP=2;
CPCD=0.5;
CPD=1;
Beta1=0.4;
Beta2=0.05;
Beta3=0.05;
Beta4=0.5;
CBranching=0.01;
CControalBranchingMemory=1; 
CCompetitiveBranchingMemory=0.5;

%% Define the Structure of Settings
% In this part, we define some structure to pass the information.
BasicSettings.Width=Width;
BasicSettings.Length=Length;
BasicSettings.Hight=Hight;
BasicSettings.IterationTime=IterationTime;
BasicSettings.InitialIterationTimes=InitialIterationTimes;
BasicSettings.DeltaX=DeltaX;
BasicSettings.DeltaY=DeltaY;
BasicSettings.DeltaZ=DeltaZ;

SituationCCaOutSide.NumofInitialCa=NumofInitialCa;
SituationCCaOutSide.MinCCaOutSide=MinCCaOutSide;
SituationCCaOutSide.MaxCCaOutSide=MaxCCaOutSide;
SituationCCaOutSide.MinCCaOutSideFast=MinCCaOutSideFast;
SituationCCaOutSide.MaxCCaOutSideFast=MaxCCaOutSideFast;

SituationSomas.NumofInitialSomas=NumofInitialSomas;
SituationSomas.MinRadius=MinRadius;
SituationSomas.MaxRadius=MaxRadius;

SituationCCaConvection.DiffusionCCaX=DiffusionCCaX;
SituationCCaConvection.DiffusionCCaY=DiffusionCCaY;
SituationCCaConvection.DiffusionCCaZ=DiffusionCCaZ;
SituationCCaConvection.AdvectionCCaX=AdvectionCCaX;
SituationCCaConvection.AdvectionCCaY=AdvectionCCaY;
SituationCCaConvection.AdvectionCCaZ=AdvectionCCaZ;
SituationCCaConvection.MinCCaInSide=MinCCaInSide;
SituationCCaConvection.MaxCCaInSide=MaxCCaInSide;

SituationCaInflux.InfluxPermeabilityConstant=InfluxPermeabilityConstant;

BasicSettingsforChemical.TubulinProduction=TubulinProduction;
BasicSettingsforChemical.DiffusionCTubulin=DiffusionCTubulin;
BasicSettingsforChemical.AdvectionCTubulin=AdvectionCTubulin;
BasicSettingsforChemical.CEnlongation=CEnlongation;
BasicSettingsforChemical.CAssembly=CAssembly;
BasicSettingsforChemical.CDAssembly=CDAssembly;
BasicSettingsforChemical.CTubulinDecy=CTubulinDecy;
BasicSettingsforChemical.CalciumProduction=CalciumProduction;
BasicSettingsforChemical.DiffusionCCalcium=DiffusionCCalcium;
BasicSettingsforChemical.CCalciumDecy=CCalciumDecy;
BasicSettingsforChemical.UMAP2Production=UMAP2Production;
BasicSettingsforChemical.DiffusionCUMAP2=DiffusionCUMAP2;
BasicSettingsforChemical.AdvectionCUMAP2=AdvectionCUMAP2;
BasicSettingsforChemical.CUMAP2Decy=CUMAP2Decy;
BasicSettingsforChemical.PMAP2Decy=PMAP2Decy;
BasicSettingsforChemical.CPCP=CPCP;
BasicSettingsforChemical.CPP=CPP;
BasicSettingsforChemical.CPCD=CPCD;
BasicSettingsforChemical.CPD=CPD;
BasicSettingsforChemical.Beta1=Beta1;
BasicSettingsforChemical.Beta2=Beta2;
BasicSettingsforChemical.Beta3=Beta3;
BasicSettingsforChemical.Beta4=Beta4;
BasicSettingsforChemical.CBUMAP2Decy=CBUMAP2Decy;
BasicSettingsforChemical.CBranching=CBranching;
BasicSettingsforChemical.CControalBranchingMemory=CControalBranchingMemory;
BasicSettingsforChemical.CCompetitiveBranchingMemory=CCompetitiveBranchingMemory;
%% Experiment Type
% There are two types of experiments. The first type is the complete one
% that starts from the initialization of Ca distributaion based on the
% convection process. The second type is the fast one, which starts from
% the initialization of Ca distribution based on the random distribution.
% If you want to test the whole system, we encourage you to use the first
% type and please note that the InitialIterationTimes should be set large
% enough (for instance 5000 for a 500*500*500 space). But if you only care
% about the neural development and just want to do some neural experiment,
% we encourage you to use the second type so that you don't need to wait
% for a really long time to initialize the Ca distribution. 

% If you want to run the first type, do not set the space to be too large,
% or the MATLAB might breakdown if you don't have enough computing power!

InitializationType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Experiment Part
% This is the experiment part, you will need to wait for a while to let the
% system finish running. 
%% Initialization Experiment
if InitializationType==1
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas,FigureofInitialSoma]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Initialization Distribution of Ca
    disp('Define the Initialization Distribution of Ca');
    [CellofInitialCentroidofCa,VectorofInitialCofCa]=InitializationofCaDistribution(SituationCCaOutSide,BasicSettings);
    InformationInitializedofCa.CellofInitialCentroidofCa=CellofInitialCentroidofCa;
    InformationInitializedofCa.VectorofInitialCofCa=VectorofInitialCofCa;
    %% Plot the Initializetion Distribution of Ca
    disp('Plot the Initializetion Distribution of Ca');
    [SpaceofCaCell]=PlotFunctionofCa(InformationInitializedofCa,InformationInitializedofSomas,SituationCCaConvection,BasicSettings);
    %% Display the Statical Data for the Initialized Distribution of Ca
    disp('Display the Statical Data for the Initialized Distribution of Ca');
    [StaticalInformationStructureofCa]=StaticalAnalysisofCaDistribution(SpaceofCaCell,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
    elseif InitializationType==2
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Second Type of Initialization Distribution of Ca
    [SpaceofCaCell]=FastTypeInitializationofCa(SituationCCaOutSide,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
end

%% Formal Experiment Type
% There are two types of the formal experiments. The first one is
% the complete one, which takes the real-time convection of Ca into
% consideration. The second one is the fast type, which doesn't includes
% the convection of Ca and use a static Ca distribution. If you want to run
% the real situation but a time-costing experiment, you can use the first
% time. If you can accpet the reasonable noise and want a fast experiment,
% you can use the second one.
FormalExperimentType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Neural Development Experiment
IterationCellofInfluxSpace=cell(ExperimentTimes,5);
IterationCellofNeuralSpace=cell(ExperimentTimes,2);
MulitDPofLamellipodiaCellAccrostheTime=cell(ExperimentTimes,1);
LengthCellAcrossTime=cell(ExperimentTimes-2,2);
TubluinCellAcrossTime=cell(ExperimentTimes-2,1);
CalciumCellAcrossTime=cell(ExperimentTimes-2,1);
UMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
BUMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
PMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
CellofNeuritesAcrossTime=cell(ExperimentTimes-2,1);
CellofDirectionAcrossTime=cell(ExperimentTimes-2,1);
CellIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellPreNewIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellofSizeAcrossTime=cell(ExperimentTimes-2,1);
if FormalExperimentType==1
        %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
        %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    for IDIteration=1:ExperimentTimes-1
        %% Convection Outside of Somas
        disp('Deffuision Outside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaOutside(OutsideSpace,InitializedSpaceofCaCell,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Convection Inside of Somas
        disp('Deffuision Inside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaInside(InsideSpace,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
        [FigureofNeuron]=GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
       if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
else
    %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
    for IDIteration=1:ExperimentTimes-1
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
%         GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
        if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
end

view(45,10);
set(gca,'XLim',[-450 450]);
set(gca,'YLim',[-450 450]);
set(gca,'ZLim',[-450 450]);
xlabel('Width \mum');
ylabel('Length \mum');
zlabel('Hight \mum');
title('The Synapse Development of Neurons');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');
print(gcf,'-dbitmap','D:\ACBPlan\OutputData\Initialization\Neuron-.bmp');
     end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
     if get(hObject,'Value') == 1
      %%
% clc; clear all; close all;
%%

% Thanks for using the THANS, an artificial neural system that is
% biological plausible and directly based on biophysics.

% This project is supported by Tsinghua University, China. The Copyright
% belongs to Mr. Yang Tian at tianyang16@mails.tsinghua.edu.cn and Mr.
% Weihua He at hwh16@mails.tsinghua.edu.cn. If you have any question about
% the code, please connect with them via e-mail.

% Note that this code is the vision without GUI, if you want to use GUI,
% please see another vision whose name ends with GUI.

% In short, you need to finish two steps to start your own experiment.
% The first step is to set the initial settings for the system. The second
% step is to set the experiment type.

%% Setting Part for the Whole System
%% Initial Settings
% In this part, we define some basic information for our computtational
% model. The [Width,Length,Hight] will define the whole space, and the norm
% is 1 micrometer. The IterationTime=0.001 means that each iteration
% corresponds to 0.01 s or 10 ms. Apart of that, the norm of all
% concentration is umol/um^3.

Width=250;
Length=250;
Hight=250;
InitialIterationTimes=400;       % This is the iteration number of the initalization part.
MinRadius=15;
MaxRadius=17;
NumofInitialSomas=5;
NumofInitialCa=500;
MinCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*1000*10^(-15);
MaxCCaOutSide=(1/NumofInitialCa)*Width*Length*Hight*2000*10^(-15);
MinCCaOutSideFast=1000*10^(-15);
MaxCCaOutSideFast=2000*10^(-15);
MinCCaInSide=0.1*10^(-15);
MaxCCaInSide=1*10^(-15);
IterationTime=0.1;
DeltaX=1;
DeltaY=1;
DeltaZ=1;
DiffusionCCaX=1*10^(-2);
DiffusionCCaY=1*10^(-2);
DiffusionCCaZ=1*10^(-2);
AdvectionCCaX=1*10^(-3);
AdvectionCCaY=1*10^(-3);
AdvectionCCaZ=1*10^(-3);
InfluxPermeabilityConstant=0.0001;      % This is the passive membrane of permeability.
ExperimentTimes=48;  % This is the iteration number of the experiment part.
EnvelopeType=1;

TubulinProduction=2;
DiffusionCTubulin=1*10^(-2);
AdvectionCTubulin=2*10^(-2);
CEnlongation=100;
CAssembly=0.1;
CDAssembly=0.0005;
CTubulinDecy=0.001;
CalciumProduction=0.5;
DiffusionCCalcium=1*10^(-2);
CCalciumDecy=0.001;
CBUMAP2Decy=0.001;
UMAP2Production=1;
DiffusionCUMAP2=1*10^(-2);
AdvectionCUMAP2=2*10^(-2);
CUMAP2Decy=0.001;
PMAP2Decy=0.001;
% CPCP=2;
% CPP=1;
% CPCD=2;
% CPD=1;
% Beta1=0.8;
% Beta2=0.1;
% Beta3=0.1;
% Beta4=1;
CPCP=0.5;
CPP=2;
CPCD=0.5;
CPD=1;
Beta1=0.4;
Beta2=0.05;
Beta3=0.05;
Beta4=0.5;
CBranching=0.01;
CControalBranchingMemory=1; 
CCompetitiveBranchingMemory=0.5;

%% Define the Structure of Settings
% In this part, we define some structure to pass the information.
BasicSettings.Width=Width;
BasicSettings.Length=Length;
BasicSettings.Hight=Hight;
BasicSettings.IterationTime=IterationTime;
BasicSettings.InitialIterationTimes=InitialIterationTimes;
BasicSettings.DeltaX=DeltaX;
BasicSettings.DeltaY=DeltaY;
BasicSettings.DeltaZ=DeltaZ;

SituationCCaOutSide.NumofInitialCa=NumofInitialCa;
SituationCCaOutSide.MinCCaOutSide=MinCCaOutSide;
SituationCCaOutSide.MaxCCaOutSide=MaxCCaOutSide;
SituationCCaOutSide.MinCCaOutSideFast=MinCCaOutSideFast;
SituationCCaOutSide.MaxCCaOutSideFast=MaxCCaOutSideFast;

SituationSomas.NumofInitialSomas=NumofInitialSomas;
SituationSomas.MinRadius=MinRadius;
SituationSomas.MaxRadius=MaxRadius;

SituationCCaConvection.DiffusionCCaX=DiffusionCCaX;
SituationCCaConvection.DiffusionCCaY=DiffusionCCaY;
SituationCCaConvection.DiffusionCCaZ=DiffusionCCaZ;
SituationCCaConvection.AdvectionCCaX=AdvectionCCaX;
SituationCCaConvection.AdvectionCCaY=AdvectionCCaY;
SituationCCaConvection.AdvectionCCaZ=AdvectionCCaZ;
SituationCCaConvection.MinCCaInSide=MinCCaInSide;
SituationCCaConvection.MaxCCaInSide=MaxCCaInSide;

SituationCaInflux.InfluxPermeabilityConstant=InfluxPermeabilityConstant;

BasicSettingsforChemical.TubulinProduction=TubulinProduction;
BasicSettingsforChemical.DiffusionCTubulin=DiffusionCTubulin;
BasicSettingsforChemical.AdvectionCTubulin=AdvectionCTubulin;
BasicSettingsforChemical.CEnlongation=CEnlongation;
BasicSettingsforChemical.CAssembly=CAssembly;
BasicSettingsforChemical.CDAssembly=CDAssembly;
BasicSettingsforChemical.CTubulinDecy=CTubulinDecy;
BasicSettingsforChemical.CalciumProduction=CalciumProduction;
BasicSettingsforChemical.DiffusionCCalcium=DiffusionCCalcium;
BasicSettingsforChemical.CCalciumDecy=CCalciumDecy;
BasicSettingsforChemical.UMAP2Production=UMAP2Production;
BasicSettingsforChemical.DiffusionCUMAP2=DiffusionCUMAP2;
BasicSettingsforChemical.AdvectionCUMAP2=AdvectionCUMAP2;
BasicSettingsforChemical.CUMAP2Decy=CUMAP2Decy;
BasicSettingsforChemical.PMAP2Decy=PMAP2Decy;
BasicSettingsforChemical.CPCP=CPCP;
BasicSettingsforChemical.CPP=CPP;
BasicSettingsforChemical.CPCD=CPCD;
BasicSettingsforChemical.CPD=CPD;
BasicSettingsforChemical.Beta1=Beta1;
BasicSettingsforChemical.Beta2=Beta2;
BasicSettingsforChemical.Beta3=Beta3;
BasicSettingsforChemical.Beta4=Beta4;
BasicSettingsforChemical.CBUMAP2Decy=CBUMAP2Decy;
BasicSettingsforChemical.CBranching=CBranching;
BasicSettingsforChemical.CControalBranchingMemory=CControalBranchingMemory;
BasicSettingsforChemical.CCompetitiveBranchingMemory=CCompetitiveBranchingMemory;
%% Experiment Type
% There are two types of experiments. The first type is the complete one
% that starts from the initialization of Ca distributaion based on the
% convection process. The second type is the fast one, which starts from
% the initialization of Ca distribution based on the random distribution.
% If you want to test the whole system, we encourage you to use the first
% type and please note that the InitialIterationTimes should be set large
% enough (for instance 5000 for a 500*500*500 space). But if you only care
% about the neural development and just want to do some neural experiment,
% we encourage you to use the second type so that you don't need to wait
% for a really long time to initialize the Ca distribution. 

% If you want to run the first type, do not set the space to be too large,
% or the MATLAB might breakdown if you don't have enough computing power!

InitializationType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Experiment Part
% This is the experiment part, you will need to wait for a while to let the
% system finish running. 
%% Initialization Experiment
if InitializationType==1
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas,FigureofInitialSoma]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Initialization Distribution of Ca
    disp('Define the Initialization Distribution of Ca');
    [CellofInitialCentroidofCa,VectorofInitialCofCa]=InitializationofCaDistribution(SituationCCaOutSide,BasicSettings);
    InformationInitializedofCa.CellofInitialCentroidofCa=CellofInitialCentroidofCa;
    InformationInitializedofCa.VectorofInitialCofCa=VectorofInitialCofCa;
    %% Plot the Initializetion Distribution of Ca
    disp('Plot the Initializetion Distribution of Ca');
    [SpaceofCaCell]=PlotFunctionofCa(InformationInitializedofCa,InformationInitializedofSomas,SituationCCaConvection,BasicSettings);
    %% Display the Statical Data for the Initialized Distribution of Ca
    disp('Display the Statical Data for the Initialized Distribution of Ca');
    [StaticalInformationStructureofCa]=StaticalAnalysisofCaDistribution(SpaceofCaCell,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
    elseif InitializationType==2
    %% Define the Initialization Distribution of Somas
    disp('Define the Initialization Distribution of Somas');
    [CellofInitialCentroidofSomas,VectorofInitialRadiusofSomas]=InitializationofSomaDistribution(BasicSettings,SituationSomas);
    InformationInitializedofSomas.CellofInitialCentroidofSomas=CellofInitialCentroidofSomas;
    InformationInitializedofSomas.VectorofInitialRadiusofSomas=VectorofInitialRadiusofSomas;
    %% Plot the Initializetion Distribution of Somas
    disp('Plot the Initializetion Distribution of Somas');
    [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas);
    InitializetionPlotInformationofSoma.XLocationofCentroid=XLocationofCentroid;
    InitializetionPlotInformationofSoma.YLocationofCentroid=YLocationofCentroid;
    InitializetionPlotInformationofSoma.ZLocationofCentroid=ZLocationofCentroid;
    InitializetionPlotInformationofSoma.VectorofInitialColorofSomas=VectorofInitialColorofSomas;
    %% Define the Second Type of Initialization Distribution of Ca
    [SpaceofCaCell]=FastTypeInitializationofCa(SituationCCaOutSide,BasicSettings);
    %% Add the Soma Information to the Initializetion Distribution of Ca
    disp('Add the Soma Information to the Initializetion Distribution of Ca');
    [InitializedSpaceofCaCell,TheIndexofSoma,TheMembraneofSoma]=AddSomaInformation(SpaceofCaCell,SituationCCaConvection,InformationInitializedofSomas,BasicSettings);
    InitializedInformation.InitializedSpaceofCaCell=InitializedSpaceofCaCell;
    InitializedInformation.TheIndexofSoma=TheIndexofSoma;
    InitializedInformation.TheMembraneofSoma=TheMembraneofSoma;
end

%% Formal Experiment Type
% There are two types of the formal experiments. The first one is
% the complete one, which takes the real-time convection of Ca into
% consideration. The second one is the fast type, which doesn't includes
% the convection of Ca and use a static Ca distribution. If you want to run
% the real situation but a time-costing experiment, you can use the first
% time. If you can accpet the reasonable noise and want a fast experiment,
% you can use the second one.
FormalExperimentType=2;                                           % Type 1 for the first type and type 2 for the second type

%% Neural Development Experiment
IterationCellofInfluxSpace=cell(ExperimentTimes,5);
IterationCellofNeuralSpace=cell(ExperimentTimes,2);
MulitDPofLamellipodiaCellAccrostheTime=cell(ExperimentTimes,1);
LengthCellAcrossTime=cell(ExperimentTimes-2,2);
TubluinCellAcrossTime=cell(ExperimentTimes-2,1);
CalciumCellAcrossTime=cell(ExperimentTimes-2,1);
UMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
BUMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
PMAP2CellAcrossTime=cell(ExperimentTimes-2,1);
CellofNeuritesAcrossTime=cell(ExperimentTimes-2,1);
CellofDirectionAcrossTime=cell(ExperimentTimes-2,1);
CellIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellPreNewIndexofCentrifugalOrderAcrossTime=cell(ExperimentTimes-2,1);
CellofSizeAcrossTime=cell(ExperimentTimes-2,1);
if FormalExperimentType==1
        %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
        %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    for IDIteration=1:ExperimentTimes-1
        %% Convection Outside of Somas
        disp('Deffuision Outside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaOutside(OutsideSpace,InitializedSpaceofCaCell,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Convection Inside of Somas
        disp('Deffuision Inside of Somas');
        [IterationCellofNeuralSpace]=PlotFunctionofCaInside(InsideSpace,BasicSettings,IDIteration,SituationCCaConvection,IterationCellofNeuralSpace);
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
        [FigureofNeuron]=GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
       if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
else
    %% Loading the Initialized Neural Space
        IterationCellofNeuralSpace{1,1}=SpaceofCaCell{end,1};
    %% Define the Search Space
        [SearchSpace]=EnvelopeCreateFunction(EnvelopeType);
        %% Convection Space of Both the Outside and Inside of Somas
        disp('Convection Space of Both the Outside and Inside of Somas');
        [OutsideSpace,InsideSpace]=DefinetheConvectionSpaceofOutandInside(InitializedInformation);
    for IDIteration=1:ExperimentTimes-1
        %% Early Period of Neural Development: Dendritic and Axonal Morphogenesis
        %% The Development of Lamellipodia
        disp('Analyze the Ca Influx Situation of Each Soma');
        [IterationCellofInfluxSpace]=SituationoftheMembraneforSomas(InitializedInformation,SearchSpace,SituationSomas,BasicSettings,IDIteration,IterationCellofInfluxSpace,IterationCellofNeuralSpace);
        InfluxSituationInformation.LocationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,1};
        InfluxSituationInformation.SituationofMembraneVectorCell=IterationCellofInfluxSpace{IDIteration,2};
        InfluxSituationInformation.InsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,3};
        InfluxSituationInformation.OutsidePointofAllSomaCell=IterationCellofInfluxSpace{IDIteration,4};
        disp('Add the Influx of Ca to of Each Soma');
        [IterationCellofNeuralSpace]=InfluxFunctionofCa(InfluxSituationInformation,SituationCCaConvection,SituationCaInflux,InitializedInformation,SituationSomas,InformationInitializedofSomas,IDIteration,IterationCellofNeuralSpace,IterationTime);
        SituationofInfluxedInformation.InfluexedCaSpace=IterationCellofNeuralSpace{IDIteration,1};
        SituationofInfluxedInformation.AddValueVectorMultiCell=IterationCellofNeuralSpace{IDIteration,2};
        disp('Define the Development probability of Lamellipodia');
        [MulitDPofLamellipodiaCellAccrostheTime]=DefinetheDPofLamellipodia(IterationCellofNeuralSpace,MulitDPofLamellipodiaCellAccrostheTime,IDIteration);
        disp('Start to Growth the Lamellipodia');
%         GrowthofLamellipodia(IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InformationInitializedofSomas,SituationSomas,IDIteration);
        %% Lamellipodia Condensation into Neurites
        if IDIteration>2
            %% Define the Initial Structure of Neurites
           [CellofNeuritesAcrossTime,TheNeuritesofSomas,TheNeuritesofEachSoma]=DefineTheStructureofNeurites(CellofNeuritesAcrossTime,IterationCellofInfluxSpace,MulitDPofLamellipodiaCellAccrostheTime,InitializedInformation,InformationInitializedofSomas,IDIteration);
            %% Chemical Substances
           [TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,LengthCellAcrossTime]=ChemicalSystemandNeuralDevelopment(CellofNeuritesAcrossTime,LengthCellAcrossTime,TubluinCellAcrossTime,CalciumCellAcrossTime,UMAP2CellAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings);
            %% Direction Structure
           [CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofSizeAcrossTime,CellofNeuritesAcrossTime]=DirectionDefinitionFunction(LengthCellAcrossTime,CellofSizeAcrossTime,CellofDirectionAcrossTime,CellIndexofCentrifugalOrderAcrossTime,CellPreNewIndexofCentrifugalOrderAcrossTime,CellofNeuritesAcrossTime,BUMAP2CellAcrossTime,PMAP2CellAcrossTime,BasicSettingsforChemical,IDIteration,BasicSettings,InformationInitializedofSomas);
            %% Neurites Development
               NeuralBrachingandDevelopment(SituationSomas,MulitDPofLamellipodiaCellAccrostheTime,CellofNeuritesAcrossTime,CellofSizeAcrossTime,IterationCellofInfluxSpace,IDIteration,InformationInitializedofSomas,ExperimentTimes)
       end
        %% Pass the Neural Space
        IterationCellofNeuralSpace{IDIteration+1,1}=IterationCellofNeuralSpace{IDIteration,1};
    end
end

view(45,10);
set(gca,'XLim',[-450 450]);
set(gca,'YLim',[-450 450]);
set(gca,'ZLim',[-450 450]);
xlabel('Width \mum');
ylabel('Length \mum');
zlabel('Hight \mum');
title('The Synapse Development of Neurons');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');
print(gcf,'-dbitmap','D:\ACBPlan\OutputData\Initialization\Neuron-.bmp');
     end
