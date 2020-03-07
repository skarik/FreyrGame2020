/// @description  audio_register_name(index)
/// @param index

var index = argument0;
ds_map_add(global._audio_mapping, audio_get_name(index), index);