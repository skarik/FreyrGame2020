/// @description Get flag state & set aggry

var bDisableAggression = false;

var flagFoolsTower = questGetValue(kQidFoolsTower);
if (flagFoolsTower >= 40)
{
	bDisableAggression = true;
}

with (o_chMithraGaurdNpc)
{
	m_ai_disableAggression = bDisableAggression;
}