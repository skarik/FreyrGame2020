//@function procRoomGetInstances(room)
//@param room_to_load

var objects = [];

instance_deactivate_all(Gameplay);
instance_deactivate_all(Game);
persistent = true;

var original_room = room;
room_goto(argument0);
with (all)
{
	if (!persistent)
	{
		var new_object = [object_index,
						  x,
						  y,
						  depth,
						  image_xscale,
						  image_yscale,
						  image_angle,
						  image_blend,
						  image_alpha];
		objects[array_length_1d(objects)] = new_object;
	}
}
room_goto(original_room);

persistent = false;
instance_activate_object(Game);
instance_activate_object(Gameplay);

return objects;