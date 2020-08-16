// TODO: make player stop and run animation

var _itemType = argument0;

switch (_itemType)
{

	//NON-CRAFTED

	case o_pickupCons_Berries:
		stats.m_health += 2;
		_playerInteractItemDecrementBelt();
		break;	
	case o_pickupCons_MedLeaf:
		stats.m_health += 5;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_Meats:
		stats.m_health += 3;
		_playerInteractItemDecrementBelt();
		break;	
	case o_pickupCons_Nuts:
		stats.m_health += 2;
		_playerInteractItemDecrementBelt();
		break;

	//CRAFTED

	//DRINKS


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
	case o_pickupCons_CactusJizz:
		stats.m_health += -7;
		m_will += 1 * 90;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_ScorpJuice:
		stats.m_health += 3;
		_playerInteractItemDecrementBelt();
		break;
		
	case o_pickupCons_CoconutMilk:
		stats.m_health += 5;
		_playerInteractItemDecrementBelt();
		break;
		
	
	//FOOD
	
	case o_pickupCons_RiceBalls:
		stats.m_health += 2;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_SweetBun:
		stats.m_health += 4;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_StuffedBun:
		stats.m_health += 5;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_RedCroiss:
		stats.m_health += 3;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_MithranCheese:
		stats.m_health += 4;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_ScorpStick:
		stats.m_health += 3;
		_playerInteractItemDecrementBelt();
		break;
	
	//SOUP VENDOR
	
	case o_pickupCons_VeggieSoup:
		stats.m_health += 12;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_CactusTato:
		stats.m_health += 10;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_StoneSoup:
		stats.m_health += 8;
		_playerInteractItemDecrementBelt();
		break;
	case o_pickupCons_StuffedMush:
		stats.m_health += 6;
		_playerInteractItemDecrementBelt();
		break;

	//NATES SOUP
	
	case o_pickupCons_NathanSoup:
		stats.m_health = stats.m_healthMax;
		_playerInteractItemDecrementBelt();
		break;





}


return 0;