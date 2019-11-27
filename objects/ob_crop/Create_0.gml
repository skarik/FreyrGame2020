/// @description set defaults

image_speed = 0;
image_index = image_number - 1;

m_growValue = 0;
m_dirt = collision_point(x, y, o_fieldSquare, true, true);
m_startDay = 0;
m_startHour = 0;
m_itemDrop = null;
//m_watered = array_create(30, 0);
m_watered = ds_map_create();
m_visible_timer = 0.0;

// Customizable values
m_growAmountDryNight = 0;
m_growAmountWetNight = 0;
m_growAmountDryDay = 0;
m_growAmountWetDay = 1;
m_growAmountMature = 12 * 2.7;
