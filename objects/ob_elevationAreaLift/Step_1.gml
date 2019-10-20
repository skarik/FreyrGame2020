/// @description Update tracked object elevations

// Update Z to the requested value
z = z_requested;

// Calculate needed motion
var delta_z = z - z_previous;
/*if (abs(delta_z) > 0)
	debugOut(string(delta_z));*/

// Update the tracked object list
tracked_objects = array_create(0);
var platform = id;
with (ob_character)
{
	if (place_meeting(x, y, platform))
	{
		platform.tracked_objects[array_length_1d(platform.tracked_objects)] = id;
	}
}
//tracked_object_count

// Update the tracked objects
var tracked_object_count = array_length_1d(tracked_objects);
for (var i = 0; i < tracked_object_count; ++i)
{
	// Update Z coordinates
	tracked_objects[i].z += delta_z;
	tracked_objects[i].y -= delta_z;
}

// Save the previous z position now that we've done calculations
z_previous = z;