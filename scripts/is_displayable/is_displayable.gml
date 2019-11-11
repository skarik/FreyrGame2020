/// @description  is_displayable(char)
/// @param char
var ch = ord(argument0);
if (ch >= 32 && ch <= 126)
{
	return true;
}
return false;