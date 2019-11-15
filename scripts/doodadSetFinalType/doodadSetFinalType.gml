var doodad_type = argument0;
var sprite = argument1;

if (doodad_type == ob_doodad)
{
	switch (sprite)
	{
		// Shrubbery and trees:
		case s_propDTree0: case s_propDBushes0: case s_propDGrass:
		case s_oasisTree: case s_propDPalm0:
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
			//break;
			
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