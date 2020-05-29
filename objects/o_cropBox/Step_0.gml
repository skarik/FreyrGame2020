/// @description Insert description here
// You can write your code in this editor

var currentTime = timeofdayGetHour();
if (m_dailyPickup == true && currentTime < 1)
{
	m_dailyPickup = false;	
}

if (m_dailyPickup == false && currentTime > 8)
{
	m_dailyPickup = true;
	var returnBox = instance_find(o_cropReturn, 0).m_inventory;
	//Handle the daily trade
	for (var i = 0; i < inventoryGetCount(m_inventory); i++)
	{
		if	(iexists(m_inventory.item[i]) && m_inventory.item[i].object != null)
		{
			 var item = farmPlaceReturnItem(m_inventory.item[i]);	
			 if (item != null)
			 {
				//m_inventory.item[i] = item;
				inventorySwapIntoChest(returnBox, -1, item);
				itemEntryFree(m_inventory.item[i].object);
				itemEntryClear(m_inventory.item[i]);
			 }
		}
	}	
}