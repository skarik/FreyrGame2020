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
