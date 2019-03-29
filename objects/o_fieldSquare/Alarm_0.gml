var kWaterDistance = 16 * 3 + 8;
// Dry it out
watered = false;

// Loop through all the canals to find one in range
var canalCount = instance_number(o_miniCanalWater);
var sqrWaterDistance = sqr(kWaterDistance);
for (var i = 0; i < canalCount; ++i)
{
	var canal = instance_find(o_miniCanalWater, i);
	//var sqrDistance = sqr(x - canal.x) + sqr(y - canal.y);
	var manhattanDistance = max(abs(x - canal.x), abs(y - canal.y));
	
	//if (sqrDistance < sqrWaterDistance)
	if (manhattanDistance < kWaterDistance)
	{
		if (canal.m_waterLevel > 0)
		{
			watered = true;
			break;
		}
	}
}
// If not watered, fall back to water zones
if (watered == false)
{
	// Loop through the water volumes to find one in range
	var waterCount = instance_number(o_waterMetaball);
	for (var i = 0; i < waterCount; ++i)
	{
		var water = instance_find(o_waterMetaball, i);
		var sqrDistance = sqr(x - water.x) + sqr(y - water.y);
		
		if (sqrDistance < sqr(water.sprite_width / 2 + sqrWaterDistance / 4))
		{
			watered = true;
			break;
		}
	}
}


// Check again later
alarm[0] = 50 + floor(random(room_speed * 5));