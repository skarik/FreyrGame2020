
function itemfixGenerateStruct(itemObjectIndex)
{
	var result;
	
	var inst = inew(itemObjectIndex);
	with (inst)
	{
		result = {
			name			: m_name,
			description		: m_description,
			flags			: m_flags,
			maxStack		: m_maxStack,
			onUseScript		: m_onUseScript,
			checkUseScript	: m_checkUseScript,
			onDepleteScript	: m_onDepleteScript,
			onUiScript		: m_onUiScript,
			type			: m_type,
			tradeItem		: m_tradeItem,
			worthInGears	: m_worthInGears,
			userInfo		: m_userInfo,
			userInfoString	: m_userInfoString,
			
			count			: m_count,
			allowOnBelt		: m_allowOnBelt,
		};
	}
	idelete(inst);
	

	return result;
}