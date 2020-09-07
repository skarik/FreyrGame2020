/// @function dropItems(style, droplist)
/// @param style {kDrop}
/// @param droplist {Array[{Item, Chance, Number}]}
function dropItems(argument0, argument1) {

#macro kDropOnlyOneFromList 0
#macro kDropSeparateChances 1

	var dropChanceStyle = argument0;
	var dropList = argument1;

	if (dropChanceStyle == kDropSeparateChances)
	{
		for (var i = 0; i < array_length_1d(dropList); ++i)
		{
			var dropEntry = dropList[i];
		
			var dropItem = dropEntry[0];
			var dropChance = dropEntry[1];
			var dropCount = dropEntry[2];
		
			if (random(1.0) < dropChance)
			{
				for (var i = 0; i < dropCount; ++i)
				{
					var angle = random_range(0, 360);
					var sped = random_range(140, 180);
        
					var item = instance_create_depth(x, y + 16, depth, dropItem);
					    item.z_height = 24;
					    item.z = z;
					    item.m_pickupSpeedX = lengthdir_x(sped, angle);
					    item.m_pickupSpeedY = lengthdir_y(sped, angle);
				}
			}
		}
	}
	else
	{
		// TODO: shite
	}


}
