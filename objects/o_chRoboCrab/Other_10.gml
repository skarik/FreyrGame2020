/// @description On Death (health < 0)

// Inherit the parent event
event_inherited();

// Drop scrap from robocrabs
var items = array_create(3, null);
for (var i = 0; i < array_length_1d(items); ++i)
	items[i] = choose(null, o_pickupRes_Bolt, o_pickupRes_Gear);
for (var i = 0; i < array_length_1d(items); ++i)
{
	if (items[i] != null)
	{
		var item = instance_create_depth(x, y, depth, items[i]);
			item.m_pickupSpeedX += random_range(-50, +50);
			item.m_pickupSpeedY += random_range(-50, +50);
	}
}

// Delete the slime
delete(this);