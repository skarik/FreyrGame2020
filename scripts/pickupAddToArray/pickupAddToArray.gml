/// @function pickupAddToArray(itemArray)
/// @param itemArray
function pickupAddToArray(argument0) {

	var itemArray = argument0;
	var item = itemArrayAddItemProp(itemArray,
									object_index,
									m_count,
									m_maxStack,
									m_name,
									m_checkUseScript,
									m_onUseScript,
									m_onDepleteScript,
									m_onUiScript,
									m_type,
									m_tradeItem,
									m_userInfo, m_userInfoString);
	return item;


}
