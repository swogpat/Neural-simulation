function Memebrane = MemebraneGenerateFunction(InitialRadiusofSomas,Centerx,Centery,Centerz,VectorofInitialColorofSomas,NumberDonnotChange)
[X,Y,Z] = sphere(NumberDonnotChange);
Memebrane  = surf(InitialRadiusofSomas*X+Centerx, InitialRadiusofSomas*Y+Centery, InitialRadiusofSomas*Z+Centerz);
Memebrane.EdgeColor =VectorofInitialColorofSomas/255;
Memebrane.FaceColor = Memebrane.EdgeColor;
