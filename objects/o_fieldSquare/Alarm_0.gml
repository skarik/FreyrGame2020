var kWaterDistance = 16 * 5 + 8;
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


// Check again later
alarm[0] = 50 + floor(random(room_speed * 5));