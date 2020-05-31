/// @description Move sand & junk to wind

// Set up the wind
var windDirection = sin(Time.time * 0.17) * 5;//Time.time * 10.0;
var windStrength = sqr(m_strength / kWeatherStrengthFull) * (sin(Time.time * 0.36) * 40 + 160);

m_windOffset[0] = lengthdir_x(windStrength, windDirection);
m_windOffset[1] = lengthdir_y(windStrength, windDirection);

var windOffsetDirection = sin(Time.time * 0.41) * 10.0;
var windOffsetStrength = (windStrength * 0.2 + 8.0);
var windOffset = [lengthdir_x(windOffsetStrength, windDirection + windOffsetDirection),
				  lengthdir_y(windOffsetStrength, windDirection + windOffsetDirection)];

var wind = weatherGetWind();

// Update overlay motion
m_overlay0_pos[0] += (wind[0] + windOffset[0]) * Time.deltaTime;
m_overlay0_pos[1] += (wind[1] + windOffset[1]) * Time.deltaTime;

m_overlay1_pos[0] += wind[0] * 2.0 * Time.deltaTime;
m_overlay1_pos[1] += wind[1] * 2.0 * Time.deltaTime;

// Spawn snow
var kRainMargin = 128;

//m_spawnCounter_snow += Time.deltaTime * power(m_strength, 3) * 8;
m_spawnCounter_snow += Time.deltaTime * m_strength * 40;
while (m_spawnCounter_snow > 0)
{
	m_spawnCounter_snow -= 1;
	
	var raindrop = inew(o_ptcSnowflake);
		raindrop.x = GameCamera.view_x - kRainMargin + random(GameCamera.width + kRainMargin * 2);
		raindrop.y = GameCamera.view_y - kRainMargin + random(GameCamera.height + kRainMargin * 2);
		raindrop.z_height = 100 + random(100);
}

// Move snow
if (m_strength > 1.0)
{
	//var caller = id;
	var motion_strength_mul = (m_strength - 1.0) * Time.deltaTime * 0.25;
	with (o_ptcSnowflake)
	{
		if (z_height > 0.0)
		{
			x += wind[0] * motion_strength_mul;
			y += wind[1] * motion_strength_mul;
		}
	}
}

// Create leaf particles
m_spawnCounter_leaf += Time.deltaTime * m_strength * sqrt(abs(windStrength)) / 10.0;
while (m_spawnCounter_leaf > 0)
{
	m_spawnCounter_leaf -= 1.0;
	
	var leaf = inew(o_ptcWheatLeaf);
		leaf.x = (wind[0] > 0) ? (GameCamera.view_x - 4) : (GameCamera.view_x + GameCamera.width + 4);
		leaf.y = GameCamera.view_y + random(GameCamera.height);
		leaf.xspeed = wind[0];
		leaf.yspeed = wind[1];
		leaf.z_height = 64 + random(256);
		leaf.y += leaf.z_height * 0.95;
		leaf.zgravity *= 0.1;
}


// Update dust particle counts
m_dustParticleCount = sqr(m_strength) * 8;
if (array_length_1d(m_dustParticles) < m_dustParticleCount)
{
	for (var i = array_length_1d(m_dustParticles); i < m_dustParticleCount; ++i)
	{
		m_dustParticles[i] = [random(GameCamera.width),
							  random(GameCamera.height),
							  wind[0] * 0.2,
							  wind[1] * 0.2,
							  make_color_rgb(240, 250, 255)];
	}
}

// Update dust particle motion
for (var i = 0; i < m_dustParticleCount; ++i)
{
	var particle = m_dustParticles[i];
		
	// Change motion to match wind
	particle[2] = motion1d_to(particle[2], (wind[0] + windOffset[0]) * 0.2, 50 * Time.deltaTime);
	particle[3] = motion1d_to(particle[3], (wind[1] + windOffset[1]) * 0.2, 50 * Time.deltaTime);
		
	// Provide motion
	particle[0] += particle[2] * Time.deltaTime;
	particle[1] += particle[3] * Time.deltaTime;
	
	// Limit to screen
	if (particle[0] < GameCamera.view_x)
		particle[0] += GameCamera.width;
	else if (particle[0] > GameCamera.view_x + GameCamera.width)
		particle[0] -= GameCamera.width;
		
	if (particle[1] < GameCamera.view_y)
		particle[1] += GameCamera.height;
	else if (particle[1] > GameCamera.view_y + GameCamera.height)
		particle[1] -= GameCamera.height;
		
	m_dustParticles[i] = particle;
}