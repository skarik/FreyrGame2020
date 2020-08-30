var l_parserMode = argument0;
var l_commandSplit = argument1;

if (l_parserMode == kCmdlineParserModeWork)
{	
	var cmd_count = array_length_1d(l_commandSplit);
	
	if (cmd_count == 1)
	{
		debugOut("gender value");
	}
	else if (cmd_count >= 2)
	{
		// Find the named flag with the same name
		var gender = real(l_commandSplit[1]);
		
		if (iexists(o_PlayerStats))
			o_PlayerStats.m_gender = gender;
			
		return 0;
	}
}
else if (l_parserMode == kCmdlineParserModeSuggest)
{
	return [];
}
else if (l_parserMode == kCmdlineParserModeAutocomplete)
{
	return [];
}