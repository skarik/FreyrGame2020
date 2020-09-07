function doodadSetFinalType(argument0, argument1) {
	var doodad_type = argument0;
	var sprite = argument1;

	if (doodad_type == ob_doodad)
	{
		switch (sprite)
		{
			// Shrubbery and trees:
			case s_propDTree0: case s_propDBushes0: case s_propDGrass:
			case s_propFlatGrass:
			case s_propPuffFlower:
			case s_propWildFlowers: case s_propWildFlowers2:
			case s_propWildPom:
			case s_propBellFlower:
			case s_propOrchardPom:
			case s_BaoTree:
			case s_propWildLemonTree:
			case s_propSquatTree:
			case s_oasisTree: case s_propDPalm0: case s_dropCoconutTree:
			case s_propViggoTrainCar_Flowers:
			case s_propViggoTrainCar_Tree:
				doodad_type = ob_doodadTreeWiggle;
				break;
		
			// Special tree:
			case s_oasisTree2:
				doodad_type = ob_doodadTreeWiggleOasis;
				break;
			
			// Hand-drawn shadows:
			case s_propRuinsSkull0:
			case s_propViggoRuins0:
				doodad_type = (doodad_type == ob_doodad) ? ob_doodadSpecialShadow : doodad_type;
				break;
			
			// Spinny windmills:
			case s_propWindmillArms:
				doodad_type = ob_doodadWindmillSpinner;
				break;
			
			// Buildings, modular system:
			case s_propMithraBuilding0: case s_propMithraBuilding1:
			case s_propMithraBuildingExt0: case s_propMithraBuildingExt1:
			case s_propMithraBuilding2: case s_propMithraBuilding2b:
			case s_propMithraBuilding3:
				doodad_type = ob_doodadModularBuilding;
				break;
			
			// Buildings, large:
				//break;
			
			// Water doodads:
			case s_propWWoodPole0:
				doodad_type = ob_doodadInWater;
				break;
			
			case s_propWFlower1:
			case s_propWPlant1:
			case s_propWWood0:
				doodad_type = ob_doodadInWaterWobble;
				break;
			
			case s_propWPlant2:
				doodad_type = ob_doodadInWater;
				break;
			
			default:
				break;
		}
	}

	return doodad_type;


}
