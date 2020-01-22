/// @description Depth update

// Update Z (needed for plug wire physics)
z = collision3_get_highest_position(x, y, z);

depthUpdate();

m_light.x = x;
m_light.y = y;
m_light.image_alpha = saturate(energyPower + (random(0.2) - 0.1));

if (!energyFade)
{
	energyPower = min(1.0, energyPower + Time.deltaTime);
}
else
{
	energyPower -= Time.deltaTime * 0.5;
	if (energyPower <= 0.0)
	{
		delete(this);
	}
}

/*if (filled)
{
	if (charges <= 0)
	{
		filled = false;
		image_index = 0;
	}
	else
	{
		image_index = 1;
		m_name = "Water Pot (" + string(charges) + "/" + string(kMaxCharges) + ")";
	}
}
else
{
	image_index = 0;
	m_name = "Empty Water Pot";
}

if (charges > 0)
{
	var dx = floor(x / 16) * 16 + 8;
	var dy = floor(y / 16) * 16 + 8;
	
	var till_square = collision_point(dx, dy, o_fieldSquare, false, true);
	if (exists(till_square))
	{
		if (!till_square.watered)
		{
			till_square.watered = true;
			charges -= 1;
		}
	}
}

// fill with water
var inWater = areaInWater(x, y, -128);
filled = filled || inWater;
if (inWater)
{
	charges = kMaxCharges;
}
*/