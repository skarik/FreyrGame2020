/// @description emit embers

ember_timer -= Time.deltaTime;
if (ember_timer < 0.0)
{
	ember_timer = max(0.0, ember_timer + random_range(0.1, 1.0) );
	
	// create ember to draw
	instance_create_depth(x + random_range(-3, +3), y + random_range(-3, +3), -50, o_lightEmber);
}