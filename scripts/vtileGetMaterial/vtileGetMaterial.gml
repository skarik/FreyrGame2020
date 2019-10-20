#macro kTileIdInfoOffset 4096

#macro kTileMaterial_Sand 1
#macro kTileMaterial_Grass 2
#macro kTileMaterial_Stone 3
#macro kTileMaterial_Water 4

// Select correct tileset
var tile_id = argument0;
var tileset = tileset0;
if (tile_id > kTileIdInfoOffset)
{
	tile_id -= kTileIdInfoOffset;
	tileset = tileset1;
}

// Check tile id based on tileset
if (tileset == tileset0)
{
	switch (tile_id) 
	{
		         case 1:  case 2:  case 3:
		case 16: case 17: case 18: case 19:
		case 32: case 33: case 34: case 35:
		case 48: case 49: case 50: case 51:
			return kTileMaterial_Grass;
			
		default:
			if (tile_id > 16*16) {
				return kTileMaterial_Stone;
			}
			break;
	}
}


return kTileMaterial_Sand;