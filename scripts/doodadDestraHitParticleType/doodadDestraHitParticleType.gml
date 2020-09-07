function doodadDestraHitParticleType() {
	switch (sprite_index)
	{
		case s_propCairn0: case s_propCairn1: case s_propCairn2:
		case s_propCairnPainted1:
		case s_propDRock0: case s_propRock:
			return o_ptcPebble;
		break;
	
		case s_propCrate:
			return o_ptcChunkWood;
		break;
	
		case s_propDesertBarrelMeed0: case s_propDesertBarrelSmol0:
			return o_ptcChunkBarrel0;
		break;
	
		case s_propDesertBarrelMeed1: case s_propDesertBarrelSmol1:
			return o_ptcChunkBarrel1;
		break;
	
		case s_propCactus:
		case s_propDCactusMedium:
		case s_propDCactusSmall:
		case s_propSmallCactus:
		case s_propVerySmallCactus:
		case s_propBunnyCactus:
			return o_ptcChunkCactus;
		break;
	
		case s_propBigPot: case s_potWater:
			return o_ptcChunkCeramic;
		break;
	}

	return null;


}
