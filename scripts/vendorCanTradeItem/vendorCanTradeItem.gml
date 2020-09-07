/// @function vendorCanTradeItem(instance)
/// @param instance
function vendorCanTradeItem(argument0) {

	var item_instance = argument0;

	if (item_instance.m_type == kItemPickupTool
		|| (item_instance.m_flags & kItemFlagsUnique))
	{
		return false;
	}
	return true;


}
