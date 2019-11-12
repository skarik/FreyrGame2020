/// @description Update planks

// Set up the status
var dist = point_distance(x, y, m_bridgeTarget.x, m_bridgeTarget.y);

// Move the planks into position
for (var i = 0; i < m_plankCount; ++i)
{
	var plank_t = i / (m_plankCount - 1.0);
	m_planks[i].x = lerp(x, m_bridgeTarget.x, plank_t);
	m_planks[i].y = lerp(y, m_bridgeTarget.y, plank_t);
	
	var drop = 0.5 - abs(0.5 - plank_t);
	drop *= 2.0; // make it a linear 0.0 to 1.0
	// drop the wire
	m_planks[i].y += sqrt(drop) * (sqrt(dist) + m_bridgeDropOffset) * 0.5;
	// make it sway!
	//dx1 += drop * sin(i * 0.04 + current_time * 0.001 + id) * sqrt(dist) * 0.3;
	
	// round positions now
	m_planks[i].x = round(m_planks[i].x);
	m_planks[i].y = round(m_planks[i].y);
	
	// update elevation
	m_zones[i].x = m_planks[i].x;
	m_zones[i].y = m_planks[i].y;
	platform3_set_z(m_zones[i], round(lerp(z, m_bridgeTarget.z, plank_t)));
	
	// update the visuals' depth
	m_planks[i].z = m_zones[i].z;
	with (m_planks[i])
	{
		z_height = 0;
		depthUpdate();
	}
}