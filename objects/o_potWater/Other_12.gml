/// @description On put down

event_inherited();

filled = filled || areaInWater(x, y);

image_index = filled ? 1 : 0;
m_name = filled ? "Full Water Pot" : "Empty Water Pot";