/// @description Set up the inventory options
event_inherited();

m_name           = "Shoddy Canal";
m_description   = "Agricultural revolution. Viva La Plants."
m_maxStack       = 5;
m_onUseScript    = canalOnUse;
m_checkUseScript = canalCheckUse;

image_speed = 0;