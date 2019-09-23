function [StaticalInformationStructureofCa]=StaticalAnalysisofCaDistribution(InitializedSpaceofCaCell,BasicSettings)

Width=BasicSettings.Width;
Length=BasicSettings.Length;
Hight=BasicSettings.Hight;

ExpectationMatrixacrossWidth=zeros(size(InitializedSpaceofCaCell,1),Width);
VarMatrixacrossWidth=zeros(size(InitializedSpaceofCaCell,1),Width);
for ID0=1:size(InitializedSpaceofCaCell,1)
    InitializedSpaceofCa=InitializedSpaceofCaCell{ID0,1};
for ID1=1:Width
    disp(['The Expectation of the Width', num2str(ID1), 'in the Iteration-', num2str(ID0), 'is under Processing']);
    ExpectationMatrixacrossWidth(ID0,ID1)=sum(sum(InitializedSpaceofCa(ID1,:,:,1)))/(Length*Hight);
    disp(['The Var of the Width', num2str(ID1), 'in the Iteration-', num2str(ID0), 'is under Processing']);
    VarMatrixacrossWidth(ID0,ID1)=(std2(InitializedSpaceofCa(ID1,:,:,1)))^2;
end
end

ExpectationMatrixacrossLength=zeros(size(InitializedSpaceofCaCell,1),Length);
VarMatrixacrossLength=zeros(size(InitializedSpaceofCaCell,1),Length);
for ID0=1:size(InitializedSpaceofCaCell,1)
    InitializedSpaceofCa=InitializedSpaceofCaCell{ID0,1};
for ID1=1:Length
    disp(['The Expectation of the Length', num2str(ID1), 'in the Iteration-', num2str(ID0), 'is under Processing']);
    ExpectationMatrixacrossLength(ID0,ID1)=sum(sum(InitializedSpaceofCa(ID1,:,:,1)))/(Width*Hight);
    disp(['The Var of the Length', num2str(ID1), 'in the Iteration-', num2str(ID0), 'is under Processing']);
    VarMatrixacrossLength(ID0,ID1)=(std2(InitializedSpaceofCa(ID1,:,:,1)))^2;
end
end

ExpectationMatrixacrossHight=zeros(size(InitializedSpaceofCaCell,1),Hight);
VarMatrixacrossHight=zeros(size(InitializedSpaceofCaCell,1),Hight);
for ID0=1:size(InitializedSpaceofCaCell,1)
    InitializedSpaceofCa=InitializedSpaceofCaCell{ID0,1};
for ID1=1:Hight
    disp(['The Expectation of the Hight', num2str(ID1), 'in the Iteration-', num2str(ID0), 'is under Processing']);
    ExpectationMatrixacrossHight(ID0,ID1)=sum(sum(InitializedSpaceofCa(ID1,:,:,1)))/(Width*Length);
    disp(['The Var of the Hight', num2str(ID1), 'in the Iteration-', num2str(ID0), 'is under Processing']);
    VarMatrixacrossHight(ID0,ID1)=(std2(InitializedSpaceofCa(ID1,:,:,1)))^2;
end
end

StaticalInformationStructureofCa.ExpectationMatrixacrossWidth=ExpectationMatrixacrossWidth;
StaticalInformationStructureofCa.VarMatrixacrossWidth=VarMatrixacrossWidth;
StaticalInformationStructureofCa.ExpectationMatrixacrossLength=ExpectationMatrixacrossLength;
StaticalInformationStructureofCa.VarMatrixacrossLength=VarMatrixacrossLength;
StaticalInformationStructureofCa.ExpectationMatrixacrossHight=ExpectationMatrixacrossHight;
StaticalInformationStructureofCa.VarMatrixacrossHight=VarMatrixacrossHight;

%% 
figure;
subplot(3,3,1);
InitializedSpaceofCaW=InitializedSpaceofCaCell{1,1};
InitializedSpaceofCaW=InitializedSpaceofCaW(ceil(Width/2),:,:,1);
for ID1=1:Length
    for ID2=1:Hight
          NeedtoPlotW(ID1,ID2)=InitializedSpaceofCaW(1,ID1,ID2);
    end
end
surf(NeedtoPlotW);
shading interp;

subplot(3,3,2);
InitializedSpaceofCaL=InitializedSpaceofCaCell{1,1};
InitializedSpaceofCaL=InitializedSpaceofCaL(:,ceil(Length/2),:,1);
for ID1=1:Width
    for ID2=1:Hight
          NeedtoPlotL(ID1,ID2)=InitializedSpaceofCaL(ID1,1,ID2);
    end
end
surf(NeedtoPlotL);
shading interp;

subplot(3,3,3);
InitializedSpaceofCaH=InitializedSpaceofCaCell{1,1};
InitializedSpaceofCaH=InitializedSpaceofCaH(:,:,ceil(Hight/2),1);
for ID1=1:Width
    for ID2=1:Length
          NeedtoPlotH(ID1,ID2)=InitializedSpaceofCaH(ID1,ID2,1);
    end
end
surf(NeedtoPlotH);
shading interp;

subplot(3,3,4);
InitializedSpaceofCaW=InitializedSpaceofCaCell{ceil(0.5*size(InitializedSpaceofCaCell,1)),1};
InitializedSpaceofCaW=InitializedSpaceofCaW(ceil(Width/2),:,:,1);
for ID1=1:Length
    for ID2=1:Hight
          NeedtoPlotW(ID1,ID2)=InitializedSpaceofCaW(1,ID1,ID2);
    end
end
surf(NeedtoPlotW);
shading interp;

subplot(3,3,5);
InitializedSpaceofCaL=InitializedSpaceofCaCell{ceil(0.5*size(InitializedSpaceofCaCell,1)),1};
InitializedSpaceofCaL=InitializedSpaceofCaL(:,ceil(Length/2),:,1);
for ID1=1:Width
    for ID2=1:Hight
          NeedtoPlotL(ID1,ID2)=InitializedSpaceofCaL(ID1,1,ID2);
    end
end
surf(NeedtoPlotL);
shading interp;

subplot(3,3,6);
InitializedSpaceofCaH=InitializedSpaceofCaCell{ceil(0.5*size(InitializedSpaceofCaCell,1)),1};
InitializedSpaceofCaH=InitializedSpaceofCaH(:,:,ceil(Hight/2),1);
for ID1=1:Width
    for ID2=1:Length
          NeedtoPlotH(ID1,ID2)=InitializedSpaceofCaH(ID1,ID2,1);
    end
end
surf(NeedtoPlotH);
shading interp;

subplot(3,3,7);
InitializedSpaceofCaW=InitializedSpaceofCaCell{ceil(1*size(InitializedSpaceofCaCell,1)),1};
InitializedSpaceofCaW=InitializedSpaceofCaW(ceil(Width/2),:,:,1);
for ID1=1:Length
    for ID2=1:Hight
          NeedtoPlotW(ID1,ID2)=InitializedSpaceofCaW(1,ID1,ID2);
    end
end
surf(NeedtoPlotW);
shading interp;

subplot(3,3,8);
InitializedSpaceofCaL=InitializedSpaceofCaCell{ceil(1*size(InitializedSpaceofCaCell,1)),1};
InitializedSpaceofCaL=InitializedSpaceofCaL(:,ceil(Length/2),:,1);
for ID1=1:Width
    for ID2=1:Hight
          NeedtoPlotL(ID1,ID2)=InitializedSpaceofCaL(ID1,1,ID2);
    end
end
surf(NeedtoPlotL);
shading interp;

subplot(3,3,9);
InitializedSpaceofCaH=InitializedSpaceofCaCell{ceil(1*size(InitializedSpaceofCaCell,1)),1};
InitializedSpaceofCaH=InitializedSpaceofCaH(:,:,ceil(Hight/2),1);
for ID1=1:Width
    for ID2=1:Length
          NeedtoPlotH(ID1,ID2)=InitializedSpaceofCaH(ID1,ID2,1);
    end
end
surf(NeedtoPlotH);
shading interp;

%%
figure;
subplot(2,3,1);
hold on;
for ID=1:size(InitializedSpaceofCaCell,1)
      LocationVector=ID*ones(1,Width);
      WidthVector=cumsum(ones(1,Width));
      plot3(LocationVector',WidthVector',ExpectationMatrixacrossWidth(ID,:)','-','Color',[0.5, 0.5+(size(InitializedSpaceofCaCell,1)-ID)*0.5/size(InitializedSpaceofCaCell,1), 0.5+ID*0.5/size(InitializedSpaceofCaCell,1)],'LineWidth',1);
end
grid on;
hold off;

subplot(2,3,2);
hold on;
for ID=1:size(InitializedSpaceofCaCell,1)
      LocationVector=ID*ones(1,Length);
      LengthVector=cumsum(ones(1,Length));
      plot3(LocationVector',LengthVector',ExpectationMatrixacrossLength(ID,:)','-','Color',[0.5, 0.5+(size(InitializedSpaceofCaCell,1)-ID)*0.5/size(InitializedSpaceofCaCell,1), 0.5+ID*0.5/size(InitializedSpaceofCaCell,1)],'LineWidth',1);
end
grid on;
hold off;

subplot(2,3,3);
hold on;
for ID=1:size(InitializedSpaceofCaCell,1)
      LocationVector=ID*ones(1,Hight);
      HightVector=cumsum(ones(1,Hight));
      plot3(LocationVector',HightVector',ExpectationMatrixacrossHight(ID,:)','-','Color',[0.5, 0.5+(size(InitializedSpaceofCaCell,1)-ID)*0.5/size(InitializedSpaceofCaCell,1), 0.5+ID*0.5/size(InitializedSpaceofCaCell,1)],'LineWidth',1);
end
grid on;
hold off;

subplot(2,3,4);
hold on;
for ID=1:size(InitializedSpaceofCaCell,1)
      LocationVector=ID*ones(1,Width);
      WidthVector=cumsum(ones(1,Width));
      plot3(LocationVector',WidthVector',VarMatrixacrossWidth(ID,:)','-','Color',[0.5, 0.5+(size(InitializedSpaceofCaCell,1)-ID)*0.5/size(InitializedSpaceofCaCell,1), 0.5+ID*0.5/size(InitializedSpaceofCaCell,1)],'LineWidth',1);
end
grid on;
hold off;

subplot(2,3,5);
hold on;
for ID=1:size(InitializedSpaceofCaCell,1)
      LocationVector=ID*ones(1,Length);
      LengthVector=cumsum(ones(1,Length));
      plot3(LocationVector',LengthVector',VarMatrixacrossLength(ID,:)','-','Color',[0.5, 0.5+(size(InitializedSpaceofCaCell,1)-ID)*0.5/size(InitializedSpaceofCaCell,1), 0.5+ID*0.5/size(InitializedSpaceofCaCell,1)],'LineWidth',1);
end
grid on;
hold off;

subplot(2,3,6);
hold on;
for ID=1:size(InitializedSpaceofCaCell,1)
      LocationVector=ID*ones(1,Hight);
      HightVector=cumsum(ones(1,Hight));
      plot3(LocationVector',HightVector',VarMatrixacrossHight(ID,:)','-','Color',[0.5, 0.5+(size(InitializedSpaceofCaCell,1)-ID)*0.5/size(InitializedSpaceofCaCell,1), 0.5+ID*0.5/size(InitializedSpaceofCaCell,1)],'LineWidth',1);
end
grid on;
hold off;

% %%
figure;
for ID=1:25
subplot(5,5,ID);
InitializedSpaceofCaL=SpaceofCaCell{ID,1};
InitializedSpaceofCaL=InitializedSpaceofCaL(:,0*ceil(Length/2)+10,:,1);
for ID1=1:Width
    for ID2=1:Hight
          NeedtoPlotL(ID1,ID2)=InitializedSpaceofCaL(ID1,1,ID2);
    end
end
surf(NeedtoPlotL);
shading interp;
end
% print(gcf,'-dbitmap','D:\ACBPlan\OutputData\Initialization\20-20-TimeSequence.bmp')
