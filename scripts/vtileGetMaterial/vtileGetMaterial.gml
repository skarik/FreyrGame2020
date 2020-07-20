#macro kTileIdInfoOffset 4096

#macro kTileMaterial_None	0
#macro kTileMaterial_Sand	1
#macro kTileMaterial_Grass	2
#macro kTileMaterial_Stone	3
#macro kTileMaterial_Water	4
#macro kTileMaterial_Tar	5
#macro kTileMaterial_Wood	6
#macro kTileMaterial_Dirt	7
#macro kTileMaterial_Metal	8
#macro kTileMaterial_Hay	9

// Select correct tileset
var tile_id = argument0;
var tileset = tileset0;
if (tile_id > kTileIdInfoOffset * 2)
{
	tile_id -= kTileIdInfoOffset * 2;
	tileset = tilesetMaterial;
}
else if (tile_id > kTileIdInfoOffset)
{
	tile_id -= kTileIdInfoOffset;
	tileset = tileset1;
}

// Check tile id based on tileset
if (tileset == tilesetMaterial)
{
	return tile_id;
}
else if (tileset == tileset0)
{
	switch (tile_id) 
	{
		         case 1:  case 2:  case 3:
		case 16: case 17: case 18: case 19:
		case 32: case 33: case 34: case 35:
		case 48: case 49: case 50: case 51:
			return kTileMaterial_Grass;
			
		case 256:
			return kTileMaterial_Stone;
		
		case 320: case 321: case 322: case 323: case 324: case 325: case 326: case 327:
		case 336: case 337: case 338: case 339: case 340: case 341: case 342: case 343:
		case 352: case 353: case 354: case 355: case 356: case 357: case 358: case 359:
		case 368: case 369: case 370: case 371: case 372: case 373: case 374: case 375:
			return kTileMaterial_Wood;
			
		default:
			if (tile_id > 64 * 5 && tile_id < 64 * 7) {
				return kTileMaterial_Wood;
			}
			if (tile_id > 64 * 7 && tile_id < 64 * 8) {
				return kTileMaterial_Metal;
			}
			if (tile_id > 16*16) {
				return kTileMaterial_Stone;
			}
			break;
	}
}
else if (tileset == tileset1)
{
	switch (tile_id) 
	{
		         case 1:  case 2:  case 3:
		case 16: case 17: case 18: case 19:
		case 32: case 33: case 34: case 35:
		case 48: case 49: case 50: case 51:
			return kTileMaterial_Dirt;
			
		          case 129:
		          case 321:
		case 336:
		case 352:
		case 368:
			return kTileMaterial_Stone;
			
		case 384: case 385: case 386:                               case 340: case 341: case 342:
		                                                            case 356: case 357: case 358:
		                                                            case 372: case 373: case 374:
		                                                            case 388: case 389: case 390:
		                                                            case 404: case 405: case 406:
			return kTileMaterial_Tar;
			
		default:
			if (tile_id > 64 * 2 && tile_id < 64 * 3) {
				return kTileMaterial_Stone;
			}
			if (tile_id > 16*16) {
				return kTileMaterial_Stone;
			}
			break;
	}
}

return kTileMaterial_Sand;