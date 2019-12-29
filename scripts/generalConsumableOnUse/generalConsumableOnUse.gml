// TODO: make player stop and run animation

var _itemType = argument0;

if (_itemType == o_pickupCons_Berries)
{
	stats.m_health += 2;
	_playerInteractItemDecrementBelt();
}
if (_itemType == o_pickupCons_Nuts)
{
	stats.m_health += 3;
	_playerInteractItemDecrementBelt();
}
if (_itemType == o_pickupCons_Meats)
{
	stats.m_health += 3;
	_playerInteractItemDecrementBelt();
}

return 0;