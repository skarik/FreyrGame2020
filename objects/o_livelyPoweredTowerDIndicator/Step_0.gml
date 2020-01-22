/// @description Update depth

depthUpdate();

visual_power = motion1d_to(visual_power, saturate(m_powerOutput), 1.2 * Time.deltaTime);