/// @description Create rainfall & update wind

// Set up the wind
var windDirection = sin(Time.time * 0.17) * 20 + Time.time * 4.0;
var windStrength = (m_strength / kWeatherStrengthFull) * (sin(Time.time * 0.36) * 20 + 80);

m_windOffset[0] = lengthdir_x(windStrength, windDirection);
m_windOffset[1] = lengthdir_y(windStrength, windDirection);

// Spawn rain
var kRainMargin = 64;

m_spawnCounter_rain += Time.deltaTime * power(m_strength, 3) * 8;
while (m_spawnCounter_rain > 0)
{
	m_spawnCounter_rain -= 1;
	
	var raindrop = new(o_ptcRainDrop);
		raindrop.x = GameCamera.view_x - kRainMargin + random(GameCamera.width + kRainMargin * 2);
		raindrop.y = GameCamera.view_y - kRainMargin + random(GameCamera.height + kRainMargin * 2);
}

// Spawn clouds
var cloudTarget = ceil((m_strength + 0.5) * 0.2 * (room_width / 200) * (room_height / 200));
if (instance_number(o_ashadowCloudMover) < cloudTarget)
{
	instance_create_depth(random(room_width), random(room_height), 0, o_ashadowCloudMover);
}

// Set up ambient drop
if (!exists(m_ambientDrop))
{
	m_ambientDrop = new(o_ashadowSquareGradient);
	m_ambientDrop.image_xscale = Screen.width / m_ambientDrop.sprite_width;
	m_ambientDrop.image_yscale = Screen.height / m_ambientDrop.sprite_height;
	m_ambientDrop.image_alpha = 0.0;
	m_ambientDrop.image_blend = make_color_rgb(8, 9, 17);
}
else
{
	m_ambientDrop.image_alpha = motion1d_to(m_ambientDrop.image_alpha, m_strength * 0.1, Time.deltaTime * 0.02);
	m_ambientDrop.x = GameCamera.x;
	m_ambientDrop.y = GameCamera.y;
}