/// @description cutsceneGetPortrait(character_object, expression)
/// @param character_object
/// @param expression
/// @return sprite_index
var character = argument0;
var expression = argument1;

if (character == o_PlayerTest && iexists(o_PlayerStats))
{
	var stats = instance_find(o_PlayerStats, 0);
	if (expression == kPortraitExpressionQuestioning)
	{
		if (stats.m_shirtless) {
			if (stats.m_gender == kGenderFemale) return sui_portraitPlayerAnekkidQuestioning;
			if (stats.m_gender == kGenderMale) return sui_portraitPlayerCnekkidQuestioning;
			if (stats.m_gender == kGenderNonbi) return sui_portraitPlayerPnekkidQuestioning;
		}
		else {
			if (stats.m_gender == kGenderFemale) return sui_portraitPlayerAQuestioning;
			if (stats.m_gender == kGenderMale) return sui_portraitPlayerCQuestioning;
			if (stats.m_gender == kGenderNonbi) return sui_portraitPlayerPQuestioning;
		}
	}
	else if (expression == kPortraitExpressionNeutral)
	{
		if (stats.m_shirtless) {
			if (stats.m_gender == kGenderFemale) return sui_portraitPlayerAnekkidNeutral;
			if (stats.m_gender == kGenderMale) return sui_portraitPlayerCnekkidNeutral;
			if (stats.m_gender == kGenderNonbi) return sui_portraitPlayerPnekkidNeutral;
		}
		else {
			if (stats.m_gender == kGenderFemale) return sui_portraitPlayerANeutral;
			if (stats.m_gender == kGenderMale) return sui_portraitPlayerCNeutral;
			if (stats.m_gender == kGenderNonbi) return sui_portraitPlayerPNeutral;
		}
	}
}
else if (character == o_chNathan)
{
	return sui_portraitNathanNeutral;
}

return sui_portraitRef;