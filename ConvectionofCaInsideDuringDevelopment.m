function [NewSpaceofCa]=ConvectionofCaInsideDuringDevelopment(CaSpace,BasicSettings,SituationCCaConvection,InsideSpace)
%% Start to Work out the Diffusion 
IterationTime=BasicSettings.IterationTime;
DeltaX=BasicSettings.DeltaX;
DeltaY=BasicSettings.DeltaY;
DeltaZ=BasicSettings.DeltaZ;

DiffusionCCaX=SituationCCaConvection.DiffusionCCaX;
DiffusionCCaY=SituationCCaConvection.DiffusionCCaY;
DiffusionCCaZ=SituationCCaConvection.DiffusionCCaZ;
AdvectionCCaX=SituationCCaConvection.AdvectionCCaX;
AdvectionCCaY=SituationCCaConvection.AdvectionCCaY;
AdvectionCCaZ=SituationCCaConvection.AdvectionCCaZ;

%% Start to Work out the Convection 
PreNewSpaceofCa=CaSpace;
for ID1=2:size(PreNewSpaceofCa,1)-1
      for ID2=2:size(PreNewSpaceofCa,2)-1
            for ID3=2:size(PreNewSpaceofCa,3)-1
                  if InsideSpace(ID1,ID2,ID3,1)>0
                  disp(['Point of', num2str(ID1), '-',num2str(ID2),'-',num2str(ID3), ' -Starts to Process in the Formal Experiment']);
                  ConvectionofDimX=(IterationTime*(2*DiffusionCCaX-DeltaX*AdvectionCCaX)*CaSpace(ID1+1,ID2,ID3,1)*InsideSpace(ID1+1,ID2,ID3,1)+IterationTime*(2*DiffusionCCaX+DeltaX*AdvectionCCaX)*CaSpace(ID1-1,ID2,ID3,1)*InsideSpace(ID1-1,ID2,ID3,1))/(2*DeltaX^2);
                  ConvectionofDimY=(IterationTime*(2*DiffusionCCaY-DeltaY*AdvectionCCaY)*CaSpace(ID1,ID2+1,ID3,1)*InsideSpace(ID1,ID2+1,ID3,1)+IterationTime*(2*DiffusionCCaY+DeltaY*AdvectionCCaY)*CaSpace(ID1,ID2-1,ID3,1)*InsideSpace(ID1,ID2-1,ID3,1))/(2*DeltaY^2);
                  ConvectionofDimZ=(IterationTime*(2*DiffusionCCaZ-DeltaZ*AdvectionCCaZ)*CaSpace(ID1,ID2,ID3+1,1)*InsideSpace(ID1,ID2,ID3+1,1)+IterationTime*(2*DiffusionCCaZ+DeltaZ*AdvectionCCaZ)*CaSpace(ID1,ID2,ID3-1,1)*InsideSpace(ID1,ID2,ID3-1,1))/(2*DeltaZ^2);
                  ConvectionofOhter=(1-IterationTime*((2*DiffusionCCaX)/(DeltaX^2)+(2*DiffusionCCaY)/(DeltaY^2)+(2*DiffusionCCaZ)/(DeltaZ^2)))*CaSpace(ID1,ID2,ID3,1);
                  PreNewSpaceofCa(ID1,ID2,ID3,1)=ConvectionofDimX+ConvectionofDimY+ConvectionofDimZ+ConvectionofOhter;
                  end
            end
      end
end

NewSpaceofCa=CaSpace;
for ID1=2:size(PreNewSpaceofCa,1)-1
      for ID2=2:size(PreNewSpaceofCa,2)-1
            for ID3=2:size(PreNewSpaceofCa,3)-1
                if InsideSpace(ID1,ID2,ID3,1)>0
                  disp(['Point of', num2str(ID1), '-',num2str(ID2),'-',num2str(ID3), ' -Starts to Process in the Formal Experiment']);
                  ConvectionofDimXFNow=((2*DiffusionCCaX-DeltaX*AdvectionCCaX)*CaSpace(ID1+1,ID2,ID3,1)*InsideSpace(ID1+1,ID2,ID3,1)+(2*DiffusionCCaX+DeltaX*AdvectionCCaX)*CaSpace(ID1-1,ID2,ID3,1)*InsideSpace(ID1-1,ID2,ID3,1))/(2*DeltaX^2);
                  ConvectionofDimYFNow=((2*DiffusionCCaY-DeltaY*AdvectionCCaY)*CaSpacea(ID1,ID2+1,ID3,1)*InsideSpace(ID1,ID2+1,ID3,1)+(2*DiffusionCCaY+DeltaY*AdvectionCCaY)*CaSpace(ID1,ID2-1,ID3,1)*InsideSpace(ID1,ID2-1,ID3,1))/(2*DeltaY^2);
                  ConvectionofDimZFNow=((2*DiffusionCCaZ-DeltaZ*AdvectionCCaZ)*CaSpace(ID1,ID2,ID3+1,1)*InsideSpace(ID1,ID2,ID3+1,1)+(2*DiffusionCCaZ+DeltaZ*AdvectionCCaZ)*CaSpace(ID1,ID2,ID3-1,1)*InsideSpace(ID1,ID2,ID3-1,1))/(2*DeltaZ^2);
                  ConvectionofOhterFNow=-((2*DiffusionCCaX)/(DeltaX^2)+(2*DiffusionCCaY)/(DeltaY^2)+(2*DiffusionCCaZ)/(DeltaZ^2))*CaSpace(ID1,ID2,ID3,1);
                  FNow=ConvectionofDimXFNow+ConvectionofDimYFNow+ConvectionofDimZFNow+ConvectionofOhterFNow;
                  ConvectionofDimXFPredicated=((2*DiffusionCCaX-DeltaX*AdvectionCCaX)*PreNewSpaceofCa(ID1+1,ID2,ID3,1)*InsideSpace(ID1+1,ID2,ID3,1)+(2*DiffusionCCaX+DeltaX*AdvectionCCaX)*PreNewSpaceofCa(ID1-1,ID2,ID3,1)*InsideSpace(ID1-1,ID2,ID3,1))/(2*DeltaX^2);
                  ConvectionofDimYFPredicated=((2*DiffusionCCaY-DeltaY*AdvectionCCaY)*PreNewSpaceofCa(ID1,ID2+1,ID3,1)*InsideSpace(ID1,ID2+1,ID3,1)+(2*DiffusionCCaY+DeltaY*AdvectionCCaY)*PreNewSpaceofCa(ID1,ID2-1,ID3,1)*InsideSpace(ID1,ID2-1,ID3,1))/(2*DeltaY^2);
                  ConvectionofDimZFPredicated=((2*DiffusionCCaZ-DeltaZ*AdvectionCCaZ)*PreNewSpaceofCa(ID1,ID2,ID3+1,1)*InsideSpace(ID1,ID2,ID3+1,1)+(2*DiffusionCCaZ+DeltaZ*AdvectionCCaZ)*PreNewSpaceofCa(ID1,ID2,ID3-1,1)*InsideSpace(ID1,ID2,ID3-1,1))/(2*DeltaZ^2);
                  ConvectionofOhterFPredicated=-((2*DiffusionCCaX)/(DeltaX^2)+(2*DiffusionCCaY)/(DeltaY^2)+(2*DiffusionCCaZ)/(DeltaZ^2))*PreNewSpaceofCa(ID1,ID2,ID3,1);
                  FPredicated=ConvectionofDimXFPredicated+ConvectionofDimYFPredicated+ConvectionofDimZFPredicated+ConvectionofOhterFPredicated;
                  NewSpaceofCa(ID1,ID2,ID3,1)=CaSpace(ID1,ID2,ID3,1)+(IterationTime/2)*(FNow+FPredicated);
                end
            end
      end
end


