// Perform area checks
inWater = areaInWater(x, y, z + z_height);
// Perform usage checks
isBusyInteracting = m_isTilling;
if (exists(ob_CtsTalker))
{
	isBusyInteracting = isBusyInteracting || ob_CtsTalker.input_priority;
}
