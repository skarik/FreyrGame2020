/// @description Updates values for the color overlay

// update the time of day
//m_timeOfDay += Time.deltaTime;
if (m_timeOfDay >= 24.00)
{
	m_timeOfDay -= 24.00;
	m_day += 1;
}

if (keyboard_check_pressed(ord("O")))
{
	m_timeOfDay -= 1.0;
	if (m_timeOfDay < 0)
		m_timeOfDay += 24.00;
}
if (keyboard_check_pressed(ord("P")))
{
	m_timeOfDay += 1.0;
	if (m_timeOfDay >= 24.00)
		m_timeOfDay -= 24.00;
}


// test some day night cycles

var blend0 = 0.0;
var blend1 = 0.0;
blend0 = min(1.0, max(0.0, +sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 1.4));
blend1 = min(1.0, max(0.0, -sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 1.4));
var color0 = merge_color(make_color_rgb(128, 128, 128), make_color_rgb(255 * 0.6, 180 * 0.6, 60 * 0.6), 1.0 - blend0);
color0 = merge_color(color0, make_color_rgb(90, 70, 255), blend1);

//draw_set_color(merge_color(make_color_rgb(128, 128, 128), color0, 0.2));
//draw_rectangle(GameCamera.x - GameCamera.width, GameCamera.y - GameCamera.height, GameCamera.x + GameCamera.width, GameCamera.y + GameCamera.height, false);
m_overlayColor = merge_color(make_color_rgb(128, 128, 128), color0, 0.2);

paletteSetMadd2(merge_color(make_color_rgb(128, 128, 128), color0, 0.8));
