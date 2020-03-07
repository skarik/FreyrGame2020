/// @function soundscapesLoad() : Initialize and load all soundscapes from disk

global.soundscape_lookup = ds_map_create();

soundscapesLoadFromFile("scripts/sfxscape_desert.txt");