/// @description Set up


if (exists(m_bridgeTarget))
{
	m_bridgeTarget.visible = false;
	visible = false;
}
else
{
	debugOut("missing bridge target");
	delete(this);
	exit;
}

// Calculate how many segments we need
m_plankCount = round(abs(x - m_bridgeTarget.x + 6) / sprite_get_width(sprite_index));
// Create dummy planks
m_planks = [];
for (var i = 0; i < m_plankCount; ++i)
{
	m_planks[i] = new(_dummy);
	m_planks[i].sprite_index = sprite_index;
	m_planks[i].image_index = floor(random(sprite_get_number(sprite_index) - 0.01));
	m_planks[i].visible = true;
}

// Create elevation zones
m_zones = [];
for (var i = 0; i < m_plankCount; ++i)
{
	m_zones[i] = instance_create_depth(x, y, depth, ob_elevationAreaLift);
	m_zones[i].sprite_index = m_planks[i].sprite_index;
	m_zones[i].mask_index   = m_planks[i].sprite_index;
	m_zones[i].ignore_below = true;
}