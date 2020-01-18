/// @description Update glow amount via power

//if (m_powerOutput < 0.5)

//lightingPower = motion1d_to(lightingPower, saturate(m_powerOutput), 1.1 * Time.deltaTime);
//emissive.image_alpha = saturate(m_powerOutput);
emissive.image_alpha = motion1d_to(emissive.image_alpha, saturate(m_powerOutput), 1.2 * Time.deltaTime);