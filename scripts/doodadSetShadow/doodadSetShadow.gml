function doodadSetShadow(argument0) {
	var doodad = argument0;

	switch (doodad.sprite_index)
	{
		case s_propRuinsSkull0:
			doodad.shadow_index = s_propRuinsSkull0_Shadow;
			break;
		case s_propViggoRuins0:
			doodad.shadow_index = s_propViggoRuins0_Shadow;
			break;
		
		case s_propViggoTrainCar_Tree:
		case s_propViggoTrainCar_Flowers:
			doodad.shadow_enabled = false;
			break;
	}


}
