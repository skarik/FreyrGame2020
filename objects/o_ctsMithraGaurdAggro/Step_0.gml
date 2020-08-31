/// @description Get flag state & set aggry

var bDisableAggression = false;

var flagMithraEscape = questGetValue(kQidMithraEscape);
var flagFoolsTower = questGetValue(kQidFoolsTower);

if (flagMithraEscape < 10)
{
	bDisableAggression = true;
}
if (flagFoolsTower >= 40)
{
	bDisableAggression = true;
}

with (o_chMithraGaurdNpc)
{
	m_ai_disableAggression = bDisableAggression;
}