function [XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialColorofSomas]=PlotFunctionofSomas(InformationInitializedofSomas,SituationSomas)

CellofInitialCentroidofSomas=InformationInitializedofSomas.CellofInitialCentroidofSomas;
VectorofInitialRadiusofSomas=InformationInitializedofSomas.VectorofInitialRadiusofSomas;

MinRadius=SituationSomas.MinRadius;
MaxRadius=SituationSomas.MaxRadius;

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

% FigureofInitialSoma=figure('Color',[1 1 1]);
% NumberDonnotChange=300;
% Memebrane=cell(size(CellofInitialCentroidofSomas,1),1);
% for ID=1:size(CellofInitialCentroidofSomas,1)
%       hold on;
%       Memebrane{ID,1} = MemebraneGenerateFunction(VectorofInitialRadiusofSomas(ID),XLocationofCentroid(ID,1),YLocationofCentroid(ID,1),ZLocationofCentroid(ID,1),VectorofInitialColorofSomas(ID,:),NumberDonnotChange);
%       hold off;
% end
% axis equal;
% % scatter3(XLocationofCentroid,YLocationofCentroid,ZLocationofCentroid,VectorofInitialRadiusofSomas,VectorofInitialColorofSomas/255,'filled');
% grid off;
% saveas(FigureofInitialSoma,['D:\ACBPlan\OutputData\Initialization\','InitialSoma_',num2str(1),'.jpg']); 
% saveas(FigureofInitialSoma,['D:\ACBPlan\OutputData\Initialization\','InitialSoma_',num2str(1),'.fig']); 



