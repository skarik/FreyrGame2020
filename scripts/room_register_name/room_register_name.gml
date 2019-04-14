/// @description  room_register_name(index)
/// @param index

var index = argument0;
ds_map_add(global._room_mapping, room_get_name(index), index);