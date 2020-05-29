var supply_source = argument0;
var supply_target = argument1;

// Find our outputs
if (array_length_1d(supply_source.m_muxOutputs) == 0)
{
	with (ob_livelyPowered)
	{
		if (iexists(m_powerSource) && m_powerSource.id == supply_source.id)
		{
			supply_source.m_muxOutputs[array_length_1d(supply_source.m_muxOutputs)] = id;
		}
	}
}

// Select a single output
if (supply_source.m_powerMuxSelection >= 0
	&& supply_source.m_powerMuxSelection < array_length_1d(supply_source.m_muxOutputs)
	&& supply_target == supply_source.m_muxOutputs[supply_source.m_powerMuxSelection])
{
	return supply_source.m_powerOutput;
}
else
{
	return 0.0;
}