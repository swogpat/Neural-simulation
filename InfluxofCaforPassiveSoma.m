function AddValue=InfluxofCaforPassiveSoma(OutSideSituationValue,DivisionValue,InitialRadiusofSomas,InfluxPermeabilityConstant,IterationTime,DiffusionCCa)

AddValue=IterationTime*((InitialRadiusofSomas*InfluxPermeabilityConstant)/(DiffusionCCa+InitialRadiusofSomas*InfluxPermeabilityConstant))*OutSideSituationValue/DivisionValue;



