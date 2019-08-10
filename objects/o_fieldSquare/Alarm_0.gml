// Get the current time:
var currentTime = timeofdayGetTotalHours();

// If dried out, then we nned to check for water.
if (watered == false)
{	
	/*var kWaterDistance = 16 * 3 + 8;
	// Needs prev watered state for charges
	var wasWatered = watered;

	// Loop through all the canals to find one in range
	var canalCount = instance_number(o_miniCanalWater);
	var sqrWaterDistance = sqr(kWaterDistance);
	for (var i = 0; i < canalCount; ++i)
	{
		var canal = instance_find(o_miniCanalWater, i);
		if (canal.m_waterLevel <= 0)
		{
			continue;
		}
	
		//var sqrDistance = sqr(x - canal.x) + sqr(y - canal.y);
		var manhattanDistance = max(abs(x - canal.x), abs(y - canal.y));
	
		//if (sqrDistance < sqrWaterDistance)
		if (manhattanDistance < kWaterDistance)
		{
			watered = true;
			break;
		}
	}
	// If not watered, fall back to pots
	if (watered == false)
	{
		var potCount = instance_number(o_potWater);
		var sqrWaterDistance = sqr(kWaterDistance);
		for (var i = 0; i < potCount; ++i)
		{
			var pot = instance_find(o_potWater, i);
			if (!pot.filled || pot.m_isPickedUp)
			{
				continue;
			}
		
			//var sqrDistance = sqr(x - canal.x) + sqr(y - canal.y);
			var manhattanDistance = max(abs(x - pot.x), abs(y - pot.y));
	
			//if (sqrDistance < sqrWaterDistance)
			if (manhattanDistance < kWaterDistance)
			{
				if (!wasWatered) {
					pot.charges -= 1;
				}
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
		
			if (sqrDistance < sqr(water.sprite_width / 2 + kWaterDistance / 4))
			{
				watered = true;
				break;
			}
		}
	}
	
	// If now watered, record the watered day
	m_wateredTime = currentTime;*/
}

if (m_wasWatered != watered)
{
	if (watered)
	{
		// If now watered, record the watered day
		m_wateredTime = currentTime;
	}
	m_wasWatered = watered;
}

// Dry out after 18 hours during the day
if (abs(currentTime - m_wateredTime) > 18.0 && timeofdayIsDaytime())
{
	// Dry it out!
	watered = false;
}

// Check again later
alarm[0] = 10;//50 + floor(random(room_speed * 5));