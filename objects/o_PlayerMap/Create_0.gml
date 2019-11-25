/// @description Load map

kMapFile = "sys/mapinfo";

map_width = 80;
map_height = 80;
map_depth = 3;
map = array_create(map_width * map_height * map_depth, null);

rooms_info = [];
rooms_number = 0;

event_user(0);