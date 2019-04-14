/// @description Depth update

depthUpdate();

if (filled)
{
	if (charges <= 0)
	{
		filled = false;
		image_index = 0;
	}
	else
	{
		image_index = 1;
		m_name = "Water Pot (" + string(charges) + "/" + string(kMaxCharges) + ")";
	}
}
else
{
	image_index = 0;
	m_name = "Empty Water Pot";
}