// TODO: make player stop and run animation

var _itemType = argument0;

switch (_itemType)
{

case o_pickupCons_Berries:
stats.m_health += 2;
_playerInteractItemDecrementBelt();
break;

case o_pickupCons_Meats:
stats.m_health += 3;
_playerInteractItemDecrementBelt();
break;

case o_pickupCons_ScorpStick:
stats.m_health += 3;
_playerInteractItemDecrementBelt();
break;

case o_pickupCons_Nuts:
stats.m_health += 2;
_playerInteractItemDecrementBelt();
break;

case o_pickupCons_FermPotion:
stats.m_health += 4;
_playerInteractItemDecrementBelt();
break;

case o_pickupCons_CactusRed:
stats.m_health += -5;
m_will += 1 * 80;
_playerInteractItemDecrementBelt();
break;

case o_pickupCons_HoneyAbsinthe:
stats.m_health += -3;
m_will += 1 * 40;
_playerInteractItemDecrementBelt();
break;


}


return 0;