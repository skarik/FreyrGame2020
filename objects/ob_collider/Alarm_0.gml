/// @description Set up depth parameters

var using_infinite_height = true;

// Get the current layer name
var layer_name = layer_get_name(layer);
// Does the layer have a specific name and number in it?
if (string_pos("colli", layer_name) != 0)
{
	var num_str = string_digits(layer_name);
	if (string_length(num_str) > 0)
	{
		// Create a number from the end of the string
		var active_z = real(num_str);
		
		// Now we want to create depth-collider on our position that has the given depth.
		var collider = instance_create_depth(x, y, depth, ob_colliderDepth);
			collider.z = active_z;
			collider.z_height = z_height;
			collider.sprite_index = sprite_index;
			collider.image_index = image_index;
			collider.image_speed = image_speed;
			collider.image_xscale = image_xscale;
			collider.image_yscale = image_yscale;
			collider.image_angle = image_angle;
		
		// Remove the original
		delete(this);
		
		using_infinite_height = false;
	}
}


// Normal behavior
if (using_infinite_height)
{
	// Now we want to create depth-collider on our position that has the given depth.
	var collider = instance_create_depth(x, y, depth, ob_colliderNoDepth);
		collider.sprite_index = sprite_index;
		collider.image_index = image_index;
		collider.image_speed = image_speed;
		collider.image_xscale = image_xscale;
		collider.image_yscale = image_yscale;
		collider.image_angle = image_angle;
	
	// Remove the original
	delete(this);
}