/// @description Insert description here
// You can write your code in this editor

image_xscale = m_size / sprite_get_width(sprite_index);
image_yscale = m_size / sprite_get_height(sprite_index);
image_alpha = saturate(m_life * 2.0) * 0.7;
visible = true;

// apply grow
m_size += m_grow * Time.deltaTime;

// apply motion
m_speed = point_distance(0, 0, m_xspeed, m_yspeed);
m_direction = point_direction(0, 0, m_xspeed, m_yspeed);

m_speed -= m_friction * Time.deltaTime;
if (m_speed < 0.0)
	m_speed = 0.0;
	
m_xspeed = lengthdir_x(m_speed, m_direction);
m_yspeed = lengthdir_y(m_speed, m_direction);
	
x += m_xspeed * Time.deltaTime;
y += m_yspeed * Time.deltaTime; 

// apply life
m_life -= Time.deltaTime;
if (m_life <= 0.0)
	delete(this);