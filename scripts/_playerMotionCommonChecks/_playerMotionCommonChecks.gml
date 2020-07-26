// Perform area checks
inWater = areaInWater(x, y, z + z_height);
inTar = areaInDeathtar(x, y, z + z_height);
// Perform usage checks
isBusyInteracting = m_isTilling || m_isPlanting || m_isHarvesting;
if (ctsGabbersHaveFocus())
{
	//isBusyInteracting = isBusyInteracting || ob_CtsTalker.input_priority;
	with (ob_CtsTalker)
	{
		if (input_priority)
		{
			other.isBusyInteracting = true;
			break;
		}
	}
}
