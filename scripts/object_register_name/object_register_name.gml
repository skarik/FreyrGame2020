/// @description  object_register_name(index)
/// @param index

var index = argument0;
ds_map_add(global._object_mapping, object_get_name(index), index);