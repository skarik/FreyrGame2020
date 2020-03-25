/// @function controlSettingSet(controlname, value)
/// @param controlname {String}
/// @param value {Control Array}

var controlname = argument0;
var value =  argument1;

switch (controlname)
{
	case "moveleft": Settings.ctMoveLeft = value;
		break;
	case "moveright": Settings.ctMoveRight = value;
		break;
	case "moveup": Settings.ctMoveUp = value;
		break;
	case "movedown": Settings.ctMoveDown = value;
		break;
	
	case "aimleft": Settings.ctAimLeft = value;
		break;
	case "aimright": Settings.ctAimRight = value;
		break;
	case "aimup": Settings.ctAimUp = value;
		break;
	case "aimdown": Settings.ctAimDown = value;
		break;
	
	case "jump": Settings.ctJump = value;
		break;
	case "attack": Settings.ctAttack = value;
		break;
	case "use": Settings.ctUse = value;
		break;
	case "useitem": Settings.ctUseItem = value;
		break;
	case "usekeyitem": Settings.ctUseKeyItem = value;
		break;
	case "usespecial": Settings.ctUseSpecial = value;
		break;
	case "dodge": Settings.ctDodge = value;
		break;
		
	case "inventory": Settings.ctInventory = value;
		break;
	case "journal": Settings.ctJournal = value;
		break;
	case "map": Settings.ctMap = value;
		break;
	
	case "item1": Settings.ctItem1 = value;
		break;
	case "item2": Settings.ctItem2 = value;
		break;
	case "item3": Settings.ctItem3 = value;
		break;
	case "item4": Settings.ctItem4 = value;
		break;
	case "item5": Settings.ctItem5 = value;
		break;
	case "item6": Settings.ctItem6 = value;
		break;
	case "itemprevious": Settings.ctItemPrevious = value;
		break;
	case "itemnext": Settings.ctItemNext = value;
		break;
	case "itemunequip": Settings.ctItemUnequip = value;
		break;
		
	case "uiprevious": Settings.ctUiPrevious = value;
		break;
	case "uinext": Settings.ctUiNext = value;
		break;
	case "uiselect": Settings.ctUiSelect = value;
		break;
	case "uicancel": Settings.ctUiCancel = value;
		break;
		
	default:
		// Nothing
};
