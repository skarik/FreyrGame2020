var sz, i, ret = array_create(0);


switch (sprite_index)
{
	case s_propRock:
	case s_propDRock0:
	case s_propCairn0:
	case s_propCairn1:
	case s_propCairn2:
		sz = choose(1, 2, 3);
		for (i = 0; i < sz; ++i)
			ret[i] = o_pickupJunk_Rock;
			
		return ret;
					
	case s_propCactus:
	case s_propDCactusMedium:
		sz = choose(0,0,0,1);
		for (i = 0; i < sz; ++i)
			ret[i] = o_pickupItem_CactusChunk;
	
		return ret;
		
}


return null;