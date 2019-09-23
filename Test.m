Width=80;
Length=80;
Hight=80;

NumofInitialSomas=3;
MinRadius=18;
MaxRadius=20;

%% Generation of the Whole Space
Limitation=[Width,Length,Hight];

%% Generation of the Somas
CellofInitialCentroidofSomas=cell(NumofInitialSomas,1);
VectorofInitialRadiusofSomas=zeros(NumofInitialSomas,1);
% AA=[23,20,20;50,65,70;120,90,90;30,77,20;120,30,120;21,21,130;77,110,55;22,110,90;130,130,22;110,130,90;160,160,160;];
for ID=1:NumofInitialSomas
    if ID==1
        InitialCentroidofSomas=[randi([20 Limitation(1,1)-20],1,1),randi([20 Limitation(1,2)-20],1,1),randi([20 Limitation(1,3)-20],1,1)];
        CellofInitialCentroidofSomas{ID,1}=InitialCentroidofSomas;
        VectorofInitialRadiusofSomas(ID,1)=MinRadius + (MaxRadius-MinRadius).*rand(1,1);
    elseif ID>1
        %% Define the History
        InitialCentroidofSomas=[randi([20 Limitation(1,1)-20],1,1),randi([20 Limitation(1,2)-20],1,1),randi([20 Limitation(1,3)-20],1,1)];
        VectorofInitialRadiusofSomas(ID,1)=MinRadius + (MaxRadius-MinRadius).*rand(1,1);
        NeedforCentroidos=zeros((ID-1),3);
        for IDSearch=1:(ID-1)
              NeededLocation=CellofInitialCentroidofSomas{IDSearch,1};
              disp('Note')
              disp(ID)
              disp(num2str(IDSearch));
              disp(CellofInitialCentroidofSomas{IDSearch,1});
              disp('Yep')
              NeedforCentroidos(IDSearch,:)=NeededLocation;
        end
        NeedforX=NeedforCentroidos(:,1);
        NeedforY=NeedforCentroidos(:,2);
        NeedforZ=NeedforCentroidos(:,3);
        NeedtoMasure=VectorofInitialRadiusofSomas(ID,1)+VectorofInitialRadiusofSomas(1:(ID-1),1);
        %% Start to Create a new one based on the history
            while any((InitialCentroidofSomas(1)-NeedforX).^2+(InitialCentroidofSomas(2)-NeedforY).^2+(InitialCentroidofSomas(3)-NeedforZ).^2<=NeedtoMasure.^2)
                       InitialCentroidofSomas=[randi([20 Limitation(1,1)-20],1,1),randi([20 Limitation(1,2)-20],1,1),randi([20 Limitation(1,3)-20],1,1)];
                       CellofInitialCentroidofSomas{ID,1}=InitialCentroidofSomas;
                      VectorofInitialRadiusofSomas(ID,1)=MinRadius + (MaxRadius-MinRadius).*rand(1,1);
            end
    end
end