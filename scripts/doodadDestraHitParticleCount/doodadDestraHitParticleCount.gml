switch (sprite_index)
{
	case s_propCairn0: case s_propCairn1: case s_propCairn2:
	case s_propCairnPainted1:
	case s_propDRock0: case s_propRock:
		return choose(2, 3, 4, 5);
	break;
	
	case s_propCrate:
		return choose(1, 2);
	break;
	
	case s_propDesertBarrelMeed0: case s_propDesertBarrelSmol0:
		return choose(1, 2, 3);
	break;
	
	case s_propDesertBarrelMeed1: case s_propDesertBarrelSmol1:
		return choose(1, 2, 3);
	break;
	
	case s_propCactus:
	case s_propDCactusMedium:
	case s_propDCactusSmall:
	case s_propSmallCactus:
	case s_propVerySmallCactus:
	case s_propBunnyCactus:
		return choose(1, 2, 3);
	break;
	
	case s_propBigPot: case s_potWater:
		return choose(1, 2);
	break;
}

return 0;