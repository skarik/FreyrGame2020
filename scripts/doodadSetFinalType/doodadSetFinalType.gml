var doodad_type = argument0;
var sprite = argument1;

if (doodad_type == ob_doodad)
{
	switch (sprite)
	{
		case s_propDTree0: case s_propDBushes0: case s_propDGrass:
		case s_oasisTree: case s_propDPalm0:
		case s_propViggoTrainCar_Flowers:
		case s_propViggoTrainCar_Tree:
			doodad_type = ob_doodadTreeWiggle;
			break;
		
		case s_oasisTree2:
			doodad_type = ob_doodadTreeWiggleOasis;
			break;
			
		case s_propRuinsSkull0:
		case s_propViggoRuins0:
			doodad_type = (doodad_type == ob_doodad) ? ob_doodadSpecialShadow : doodad_type;
			break;
			
		default:
			break;
	}
}

return doodad_type;