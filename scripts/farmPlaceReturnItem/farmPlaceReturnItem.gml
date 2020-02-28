/// @description farmPlaceReturnItem (tradeItem)
/// @param tradeItem

var tradeItem = argument0;

if (tradeItem == null || tradeItem.tradeItem[0] == noone)
{
	return null;	
}

//Create an instance of the item
var returnItem = itemEntryNew();
var item = new (tradeItem.tradeItem[0]); //This line is magic, apparently.

returnItem.object = tradeItem.tradeItem[0];
returnItem.count = tradeItem.tradeItem[1] * tradeItem.count;
returnItem.name = tradeItem.tradeItem[0].m_name;
returnItem.checkUse = tradeItem.tradeItem[0].m_checkUseScript;
returnItem.onUse = tradeItem.tradeItem[0].m_onUseScript;
returnItem.onDeplete = tradeItem.tradeItem[0].m_onDepleteScript;
returnItem.type = tradeItem.tradeItem[0].m_type;

return returnItem;