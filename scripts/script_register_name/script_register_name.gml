/// @description  script_register_name(index)
/// @param index

var index = argument0;
ds_map_add(global._script_mapping, script_get_name(index), index);