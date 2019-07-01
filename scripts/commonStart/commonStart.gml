global._object_mapping = ds_map_create();
object_register_name(null);

global._room_mapping = ds_map_create();
room_register_name(rm_oasis_farm);

global._script_mapping = ds_map_create();
script_register_name(null);
script_register_name(nullScript);

mt19937_init();