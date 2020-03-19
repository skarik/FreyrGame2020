/// @description Create the initial state

m_link = array_create(0);
m_link_type = array_create(0);
//m_procedural = false;

z = collision3_get_highest_position(x, y, 0);

m_loaded = false;
m_valid = true;
alarm[0] = 2; // Create links next frame

