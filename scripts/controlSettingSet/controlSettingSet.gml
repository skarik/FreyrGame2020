/// @function controlSettingSet(controlname, value)
/// @param controlname {String}
/// @param value {Control Array}

var controlname = argument0;
var value =  argument1;

switch (controlname)
{
	case "use": Settings.ctUse = value;
		break;
	
	default:
		// Nothing
};
