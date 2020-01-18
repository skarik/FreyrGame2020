/// @description set image

//emissive.image_alpha = saturate(m_powerOutput);

if (m_powerOutput > 0.5)
{
	image_index = 1;
	lightingPower = motion1d_to(lightingPower, saturate(m_powerOutput), 1.1 * Time.deltaTime);
}
else
{
	image_index = 0;
	lightingPower = motion1d_to(lightingPower, saturate(m_powerOutput), 2.0 * Time.deltaTime);
}