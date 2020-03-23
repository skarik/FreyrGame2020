/// @function controlSettingGet(controlname)
/// @param controlname {String}
/// @returns Control Array

var controlname = argument0;

switch (controlname)
{
	case "attack": return Settings.ctAttack;
		break;
	case "use": return Settings.ctUse;
		break;
	case "useitem": return Settings.ctUseItem;
		break;
	case "usekeyitem": return Settings.ctUseKeyItem;
		break;
	case "usespecial": return Settings.ctUseSpecial;
		break;
	case "dodge": return Settings.ctDodge;
		break;
	
	default:
		return null;
};
